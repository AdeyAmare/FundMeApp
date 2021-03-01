package REST_API

import (
	"context"
	"encoding/json"
	"fmt"
	"net/http"
	"path"
	"strconv"
	"strings"

	//"github.com/FundStation2/donor"
	"github.com/FundStation2/donor"
	"github.com/FundStation2/models"
	"github.com/FundStation2/permission"
	"github.com/FundStation2/role"
	"github.com/FundStation2/session"
	"github.com/FundStation2/tokens"

	//"github.com/FundStation2/tokens"

	"golang.org/x/crypto/bcrypt"
	//"golang.org/x/crypto/bcrypt"
)

type DonorApiHandler struct {
	donorApiService donor.DonorService

	sessionService role.SessionService
	donorSess      *models.Session
	loggedInDonor  *models.Donor
	donorRole      role.RoleService
	csrfSignKey    []byte
}

type contextKey string

var ctxUserSessionKey = contextKey("signed_in_user_session")

func NewDonorApiHandler(ds donor.DonorService, sessServ role.SessionService, dRole role.RoleService,
	usrSess *models.Session, csKey []byte) *DonorApiHandler {
	return &DonorApiHandler{donorApiService: ds, sessionService: sessServ,
		donorRole: dRole, donorSess: usrSess, csrfSignKey: csKey}
}

func (dah *DonorApiHandler) Logout(w http.ResponseWriter, r *http.Request) {
	donSess, _ := r.Context().Value(ctxUserSessionKey).(*models.Session)
	session.Remove(donSess.UUID, w)
	dah.sessionService.DeleteSession(donSess.UUID)
	//http.Redirect(w, r, "/donor/login", http.StatusSeeOther)
}

func (dah *DonorApiHandler) loggedIn(r *http.Request) bool {
	if dah.donorSess == nil {
		print("a")
		return false
	}
	donSess := dah.donorSess
	c, err := r.Cookie(donSess.UUID)
	if err != nil {
		fmt.Println("b ", err)
		return false
	}
	ok, err := session.Valid(c.Value, donSess.SigningKey)
	if !ok || (err != nil) {
		print("c")
		return false
	}
	return true
}

func (dah *DonorApiHandler) checkDonor(r models.Role) bool {

	if strings.ToUpper(r.Name) == strings.ToUpper("donor") {
		return true
	}

	return false
}

func (dah *DonorApiHandler) Authenticated(next http.Handler) http.Handler {
	fn := func(w http.ResponseWriter, r *http.Request) {
		ok := dah.loggedIn(r)
		if !ok {
			println("authhh")
			//http.Redirect(w, r, "/donor", http.StatusSeeOther)
			return
		}
		ctx := context.WithValue(r.Context(), ctxUserSessionKey, dah.donorSess)
		next.ServeHTTP(w, r.WithContext(ctx))
	}
	return http.HandlerFunc(fn)
}

func (dah *DonorApiHandler) Authorized(next http.Handler) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		println("lala")
		if dah.loggedInDonor == nil {
			println("noDonor")
			http.Error(w, http.StatusText(http.StatusUnauthorized), http.StatusUnauthorized)
			return
		}
		role, errs := dah.donorRole.DonorRoles(dah.loggedInDonor)
		if errs != nil {
			fmt.Println("roleError", errs)
			http.Error(w, http.StatusText(http.StatusUnauthorized), http.StatusUnauthorized)
			return
		}

		permitted := permission.HasPermission(r.URL.Path, role.Name, r.Method)
		if !permitted {
			fmt.Println("permError", errs)
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

func (dah *DonorApiHandler) GetDonors(w http.ResponseWriter, r *http.Request) {
	//id,err := strconv.Atoi(path.Base(r.URL.Path))
	//if err != nil{
	//	return
	//}
	donors, err := dah.donorApiService.ViewAllDonor()
	fmt.Println("donorss", donors)
	if err != nil {
		return
	}
	output, err := json.MarshalIndent(&donors, "", "\t\t")

	if err != nil {
		return
	}
	w.Header().Set("Content-Type", "application/json")
	w.Write(output)
	return
}

func (dah *DonorApiHandler) LoginDonor(w http.ResponseWriter, r *http.Request) {
	len := r.ContentLength
	body := make([]byte, len)
	r.Body.Read(body)
	var donor models.Donor
	//rId,_:=strconv.Atoi(r.FormValue("role_id"))

	json.Unmarshal(body, &donor)
	fmt.Println("loggedDonor", donor.Username)
	donor2, err := dah.donorApiService.DonorByUsername(donor.Username)
	if err != nil {

		return
	}
	err = bcrypt.CompareHashAndPassword([]byte(donor2.Password), []byte(donor.Password))
	fmt.Println("donorss", donor)

	if err != nil {
		if err == bcrypt.ErrMismatchedHashAndPassword {

			return
		}
		fmt.Println("errnow", err)
		w.WriteHeader(http.StatusNotFound)
		return
	}
	output, err1 := json.MarshalIndent(&donor2, "", "\t\t")

	if err1 != nil {
		return
	}
	dah.loggedInDonor = donor2
	fmt.Println(err)

	claims := tokens.Claims(donor.Username, dah.donorSess.Expires)
	session.Create(claims, dah.donorSess.UUID, dah.donorSess.SigningKey, w)
	newSess, errs := dah.sessionService.StoreSession(dah.donorSess)
	if errs != nil {

		return
	}
	dah.donorSess = newSess

	roles, _ := dah.donorRole.DonorRoles(&donor)
	if dah.checkDonor(roles) {
		println("whatNow")
		w.WriteHeader(http.StatusUnauthorized)
		return
	}
	w.Header().Set("Content-Type", "application/json")
	w.Write(output)
	//w.WriteHeader(http.StatusOK)
	return
}

func (dah *DonorApiHandler) GetDonor(w http.ResponseWriter, r *http.Request) {
	username := path.Base(r.URL.Path)
	// if err != nil{
	// 	return
	// }
	donor, err := dah.donorApiService.DonorByUsername(username)
	fmt.Println("donorss", donor)
	if err != nil {
		return
	}
	output, err := json.MarshalIndent(&donor, "", "\t\t")

	if err != nil {
		return
	}
	w.Header().Set("Content-Type", "application/json")
	w.Write(output)
	return
}

func (dah *DonorApiHandler) PostDonor(w http.ResponseWriter, r *http.Request) {
	//token, err := tokens.CSRFToken(dah.csrfSignKey)

	len := r.ContentLength
	body := make([]byte, len)
	r.Body.Read(body)
	var donor models.Donor
	//rId,_:=strconv.Atoi(r.FormValue("role_id"))

	json.Unmarshal(body, &donor)
	role, errs := dah.donorRole.RoleByName("DONOR")
	if errs != nil {
		return
	}
	donor.RoleID = uint(role.ID)
	hashedPassword, erro := bcrypt.GenerateFromPassword([]byte(donor.Password), 12)

	if erro != nil {
		return
	}
	donor.Password = string(hashedPassword)

	fmt.Println(donor)
	p := fmt.Sprintf("/v1/donor/%d", donor.DonorNo)
	// uexists := dah.donorApiService.UsernameExists(donor.Username)
	// if uexists {
	// 	w.Write([]byte("username exists"))
	// 	w.WriteHeader(http.StatusConflict) //409
	// 	return

	// }
	_, err := dah.donorApiService.SignupDonor(&donor)
	if err != nil {
		fmt.Println("err", err)
		return
	}
	dah.loggedInDonor = &donor
	fmt.Println(err)

	claims := tokens.Claims(donor.Username, dah.donorSess.Expires)
	session.Create(claims, dah.donorSess.UUID, dah.donorSess.SigningKey, w)
	newSess, errs := dah.sessionService.StoreSession(dah.donorSess)

	dah.donorSess = newSess
	w.Header().Set("Location", p)

	w.WriteHeader(http.StatusCreated)
	return
}
func (dah *DonorApiHandler) PutDonor(w http.ResponseWriter, r *http.Request) {
	id, err := strconv.Atoi(path.Base(r.URL.Path))
	if err != nil {
		return
	}
	donor, err := dah.donorApiService.DonorById(id)
	if err != nil {
		return
	}
	len := r.ContentLength
	body := make([]byte, len)
	r.Body.Read(body)
	json.Unmarshal(body, &donor)
	err = dah.donorApiService.UpdateDonorById(donor)
	if err != nil {
		return
	}
	w.WriteHeader(200)
	return
}
func (dah *DonorApiHandler) DeleteDonor(w http.ResponseWriter, r *http.Request) {
	id, err := strconv.Atoi(path.Base(r.URL.Path))
	if err != nil {
		return
	}
	donor, err := dah.donorApiService.DonorById(id)
	if err != nil {
		return
	}
	err = dah.donorApiService.DeleteDonorById(donor)
	if err != nil {
		return
	}
	w.WriteHeader(200)
	return
}
