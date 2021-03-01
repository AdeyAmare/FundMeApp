package REST_API

import (
	"context"
	"encoding/json"
	"fmt"
	"net/http"
	"path"
	"strconv"
	"strings"

	"github.com/FundStation2/models"
	"github.com/FundStation2/permission"
	"github.com/FundStation2/recipient"
	"github.com/FundStation2/role"
	"github.com/FundStation2/session"
	"github.com/FundStation2/tokens"
	"golang.org/x/crypto/bcrypt"
	//"path"
	//"strconv"
)

type RecipientApiHandler struct {
	recApiService     recipient.RecipientService
	sessionService    role.SessionService
	recpSess          *models.Session
	loggedInRecipient *models.Recipient
	recipientRole     role.RoleRepository
	csrfSignKey       []byte
}

func NewRecipientApiHandler(rs recipient.RecipientService, sessServ role.SessionService, rRole role.RoleService,
	usrSess *models.Session, csKey []byte) *RecipientApiHandler {
	return &RecipientApiHandler{recApiService: rs, sessionService: sessServ,
		recipientRole: rRole, recpSess: usrSess, csrfSignKey: csKey}
}

func (rah *RecipientApiHandler) Logout(w http.ResponseWriter, r *http.Request) {
	rSess, _ := r.Context().Value(ctxUserSessionKey).(*models.Session)
	session.Remove(rSess.UUID, w)
	rah.sessionService.DeleteSession(rSess.UUID)
	//http.Redirect(w, r, "/donor/login", http.StatusSeeOther)
}

func (rah *RecipientApiHandler) loggedIn(r *http.Request) bool {
	if rah.recpSess == nil {
		return false
	}
	rSess := rah.recpSess
	c, err := r.Cookie(rSess.UUID)
	if err != nil {
		return false
	}
	ok, err := session.Valid(c.Value, rSess.SigningKey)
	if !ok || (err != nil) {
		return false
	}
	return true
}

func (rah *RecipientApiHandler) checkRecipient(r models.Role) bool {

	if strings.ToUpper(r.Name) == strings.ToUpper("recipient") {
		return true
	}

	return false
}

func (rah *RecipientApiHandler) Authenticated(next http.Handler) http.Handler {
	fn := func(w http.ResponseWriter, r *http.Request) {
		ok := rah.loggedIn(r)
		if !ok {
			//http.Redirect(w, r, "/donor", http.StatusSeeOther)
			return
		}
		ctx := context.WithValue(r.Context(), ctxUserSessionKey, rah.recpSess)
		next.ServeHTTP(w, r.WithContext(ctx))
	}
	return http.HandlerFunc(fn)
}

func (rah *RecipientApiHandler) Authorized(next http.Handler) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		if rah.loggedInRecipient == nil {
			http.Error(w, http.StatusText(http.StatusUnauthorized), http.StatusUnauthorized)
			return
		}
		role, errs := rah.recipientRole.RecipientRoles(rah.loggedInRecipient)
		if errs != nil {
			http.Error(w, http.StatusText(http.StatusUnauthorized), http.StatusUnauthorized)
			return
		}

		permitted := permission.HasPermission(r.URL.Path, role.Name, r.Method)
		if !permitted {
			http.Error(w, http.StatusText(http.StatusUnauthorized), http.StatusUnauthorized)
			return

		}
		// if r.Method == http.MethodPost {
		// 	ok, err := tokens.ValidCSRF(r.FormValue("_csrf"), dah.csrfSignKey)
		// 	if !ok || (err != nil) {
		// 		http.Error(w, http.StatusText(http.StatusUnauthorized), http.StatusUnauthorized)
		// 		return
		// 	}
		// }
		// if r.Method == http.MethodGet {
		// 	ok, err := tokens.ValidCSRF(r.FormValue("_csrf"), dah.csrfSignKey)
		// 	if !ok || (err != nil) {
		// 		http.Error(w, http.StatusText(http.StatusUnauthorized), http.StatusUnauthorized)
		// 		return
		// 	}
		// }
		next.ServeHTTP(w, r)
	})
}

func (rah *RecipientApiHandler) GetRecipients(w http.ResponseWriter, r *http.Request) {
	recipients, err := rah.recApiService.ViewAllRecipient()
	fmt.Println("recipients", recipients)
	if err != nil {
		return
	}
	output, err := json.MarshalIndent(&recipients, "", "\t")

	if err != nil {
		return
	}
	w.Header().Set("Content-Type", "application/json")
	w.Write(output)
	return
}
func (rah *RecipientApiHandler) GetRecipient(w http.ResponseWriter, r *http.Request) {
	id := path.Base(r.URL.Path)
	// if err != nil {
	// 	return
	// }
	recipient, err := rah.recApiService.RecipientByUsername(id)
	fmt.Println("recipient", recipient)
	if err != nil {
		return
	}
	output, err := json.MarshalIndent(&recipient, "", "\t\t")

	if err != nil {
		return
	}
	w.Header().Set("Content-Type", "application/json")
	w.Write(output)
	return
}

var recip = models.Recipient{}

func (rah *RecipientApiHandler) PostRecipient(w http.ResponseWriter, r *http.Request) {
	len := r.ContentLength
	body := make([]byte, len)
	r.Body.Read(body)
	//var recipient models.Recipient

	json.Unmarshal(body, &recip)
	role, errs := rah.recipientRole.RoleByName("RECIPIENT")
	if errs != nil {
		return
	}
	recip.RoleID = uint(role.ID)

	hashedPassword, erro := bcrypt.GenerateFromPassword([]byte(recip.Password), 12)

	if erro != nil {
		return
	}
	recip.Password = string(hashedPassword)
	//uniqueId = recipient.RecipientNo
	fmt.Println(recip)
	p := fmt.Sprintf("/v1/recipient/%d", recip.RecipientNo)
	//uexists := rah.recApiService.UsernameExists(recipient.Username)
	// if uexists {
	// 	w.Write([]byte("username exists"))
	// 	w.WriteHeader(http.StatusConflict) //409
	// 	return

	// }
	_, err := rah.recApiService.SignupRecipient(&recip)
	//	recp = recipient
	if err != nil {
		fmt.Println("err", err)
		return
	}
	rah.loggedInRecipient = &recip
	fmt.Println(err)

	claims := tokens.Claims(recip.Username, rah.recpSess.Expires)
	session.Create(claims, rah.recpSess.UUID, rah.recpSess.SigningKey, w)
	newSess, errs := rah.sessionService.StoreSession(rah.recpSess)
	if errs != nil {

		return
	}
	rah.recpSess = newSess

	w.Header().Set("Location", p)
	//w.Write([]byte(strconv.Itoa(recipient.RecipientNo)))
	//w.Header().Set("id", strconv.Itoa(recipient.RecipientNo))
	w.WriteHeader(http.StatusCreated)

	return
}
func (rah *RecipientApiHandler) PutRecipient(w http.ResponseWriter, r *http.Request) {
	id, err := strconv.Atoi(path.Base(r.URL.Path))
	if err != nil {
		return
	}
	recipient, err := rah.recApiService.RecipientById(id)
	if err != nil {
		return
	}
	len := r.ContentLength
	body := make([]byte, len)
	r.Body.Read(body)
	json.Unmarshal(body, &recipient)
	err = rah.recApiService.UpdateRecipientById(recipient)
	if err != nil {
		return
	}
	w.WriteHeader(200)
	return
}
func (rah *RecipientApiHandler) DeleteRecipient(w http.ResponseWriter, r *http.Request) {
	id, err := strconv.Atoi(path.Base(r.URL.Path))
	if err != nil {
		return
	}
	recipient, err := rah.recApiService.RecipientById(id)
	if err != nil {
		return
	}
	err = rah.recApiService.DeleteRecipientById(recipient)
	if err != nil {
		return
	}
	w.WriteHeader(200)
	return
}

func (rah *RecipientApiHandler) LoginRecipient(w http.ResponseWriter, r *http.Request) {
	len := r.ContentLength
	body := make([]byte, len)
	r.Body.Read(body)
	var recipient models.Recipient
	//rId,_:=strconv.Atoi(r.FormValue("role_id"))

	json.Unmarshal(body, &recipient)

	recipient2, err := rah.recApiService.RecipientByUsername(recipient.Username)
	err = bcrypt.CompareHashAndPassword([]byte(recipient.Password), []byte(recipient.Password))
	fmt.Println("recipient", recipient)
	if err != nil {
		w.WriteHeader(http.StatusNotFound)
		return
	}
	output, err1 := json.MarshalIndent(&recipient2, "", "\t\t")

	if err1 != nil {
		return
	}
	rah.loggedInRecipient = &recipient
	fmt.Println(err)

	claims := tokens.Claims(recipient.Username, rah.recpSess.Expires)
	session.Create(claims, rah.recpSess.UUID, rah.recpSess.SigningKey, w)
	newSess, errs := rah.sessionService.StoreSession(rah.recpSess)
	if errs != nil {

		return
	}
	rah.recpSess = newSess

	roles, _ := rah.recipientRole.RecipientRoles(&recipient)
	if rah.checkRecipient(roles) {
		w.WriteHeader(http.StatusUnauthorized)
		return
	}
	w.Header().Set("Content-Type", "application/json")
	w.Write(output)
	//w.WriteHeader(http.StatusOK)
	return
}
