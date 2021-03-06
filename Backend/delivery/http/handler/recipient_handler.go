package handler

import (
	"context"
	"fmt"
	"strings"

	"github.com/FundStation2/permission"
	"github.com/FundStation2/recipient"
	"github.com/FundStation2/role"
	"github.com/FundStation2/session"
	"golang.org/x/crypto/bcrypt"

	"html/template"
	"net/http"
	"net/url"

	"github.com/FundStation2/form"
	"github.com/FundStation2/models"
	"github.com/FundStation2/tokens"
)

type RecipientHandler struct {
	tmpl              *template.Template
	recpService       recipient.RecipientService
	sessionService    role.SessionService
	recpSess          *models.Session
	loggedInRecipient *models.Recipient
	recpRole          role.RoleService
	csrfSignKey       []byte
}

func NewRecipientHandler(t *template.Template, rs recipient.RecipientService,
	sessServ role.SessionService, rRole role.RoleService,
	usrSess *models.Session, csKey []byte) *RecipientHandler {
	return &RecipientHandler{tmpl: t, recpService: rs, sessionService: sessServ,
		recpRole: rRole, recpSess: usrSess, csrfSignKey: csKey}
}

func (rch *RecipientHandler) Authenticated(next http.Handler) http.Handler {
	fn := func(w http.ResponseWriter, r *http.Request) {
		ok := rch.loggedIn(r)
		if !ok {
			http.Redirect(w, r, "/recipient/login", http.StatusSeeOther)
			return
		}
		ctx := context.WithValue(r.Context(), ctxUserSessionKey, rch.recpSess)
		next.ServeHTTP(w, r.WithContext(ctx))
	}
	return http.HandlerFunc(fn)
}

func (rch *RecipientHandler) Authorized(next http.Handler) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		if rch.loggedInRecipient == nil {
			http.Error(w, http.StatusText(http.StatusUnauthorized), http.StatusUnauthorized)
			return
		}
		role, errs := rch.recpRole.RecipientRoles(rch.loggedInRecipient)
		if errs != nil {
			http.Error(w, http.StatusText(http.StatusUnauthorized), http.StatusUnauthorized)
			return
		}

		permitted := permission.HasPermission(r.URL.Path, role.Name, r.Method)
		if !permitted {
			http.Error(w, http.StatusText(http.StatusUnauthorized), http.StatusUnauthorized)
			return

		}
		if r.Method == http.MethodPost {
			ok, err := tokens.ValidCSRF(r.FormValue("_csrf"), rch.csrfSignKey)
			if !ok || (err != nil) {
				http.Error(w, http.StatusText(http.StatusUnauthorized), http.StatusUnauthorized)
				return
			}
		}
		next.ServeHTTP(w, r)
	})
}

func (rch *RecipientHandler) Recipients(w http.ResponseWriter, r *http.Request) {
	recp, errs := rch.recpService.ViewAllRecipient()
	if errs != nil {
		http.Error(w, http.StatusText(http.StatusNotFound), http.StatusNotFound)
	}
	token, err := tokens.CSRFToken(rch.csrfSignKey)
	if err != nil {
		http.Error(w, http.StatusText(http.StatusInternalServerError), http.StatusInternalServerError)
	}
	tmplData := struct {
		Values     url.Values
		VErrors    form.ValidationErrors
		Recipients []models.Recipient
		CSRF       string
	}{
		Values:     nil,
		VErrors:    nil,
		Recipients: recp,
		CSRF:       token,
	}
	fmt.Println(tmplData)
	rch.tmpl.ExecuteTemplate(w, "owner.html", tmplData)
}

// AdminCategoriesNew hanlde requests on route /admin/categories/new
var recp = models.Recipient{}

func (rch *RecipientHandler) RecipientSignup(w http.ResponseWriter, r *http.Request) {
	token, err := tokens.CSRFToken(rch.csrfSignKey)
	if err != nil {
		http.Error(w, http.StatusText(http.StatusInternalServerError), http.StatusInternalServerError)
	}
	if r.Method == http.MethodGet {
		newCatForm := struct {
			Values  url.Values
			VErrors form.ValidationErrors
			CSRF    string
		}{
			Values:  nil,
			VErrors: nil,
			CSRF:    token,
		}
		rch.tmpl.ExecuteTemplate(w, "recipientSignup.html", newCatForm)
	}

	if r.Method == http.MethodPost {

		err := r.ParseForm()
		if err != nil {
			http.Error(w, http.StatusText(http.StatusBadRequest), http.StatusBadRequest)
			return
		}

		newDonForm := form.Input{Values: r.PostForm, VErrors: form.ValidationErrors{}}
		newDonForm.Required("firstName", "lastName", "add", "userName", "password", "repassword", "phone", "email")
		newDonForm.MinLength("password", 8)
		newDonForm.ExactLength("phone", 10)
		newDonForm.PasswordMatches("password", "repassword")
		newDonForm.CSRF = token

		if !newDonForm.Valid() {
			rch.tmpl.ExecuteTemplate(w, "recipientSignup.html", newDonForm)
			return
		}

		eExists := rch.recpService.EmailExists(r.FormValue("email"))
		if eExists {
			newDonForm.VErrors.Add("email", "Email Already Exists")
			rch.tmpl.ExecuteTemplate(w, "recipientSignup.html", newDonForm)
			return
		}

		pExists := rch.recpService.PhoneExists(r.FormValue("phone"))
		if pExists {
			newDonForm.VErrors.Add("phone", "Phone Already Exists")
			rch.tmpl.ExecuteTemplate(w, "recipientSignup.html", newDonForm)
			return
		}

		uExists := rch.recpService.UsernameExists(r.FormValue("userName"))
		if uExists {
			newDonForm.VErrors.Add("userName", "Username Already Exists")
			rch.tmpl.ExecuteTemplate(w, "recipientSignup", newDonForm)
			return
		}

		hashedPassword, err := bcrypt.GenerateFromPassword([]byte(r.FormValue("password")), 12)
		if err != nil {
			newDonForm.VErrors.Add("password", "Password Could not be stored")
			rch.tmpl.ExecuteTemplate(w, "recipientSignup.html", newDonForm)
			return
		}

		role, errs := rch.recpRole.RoleByName("RECIPIENT")

		if errs != nil {
			newDonForm.VErrors.Add("email", "could not assign role to the user")
			rch.tmpl.ExecuteTemplate(w, "recipientSignup.html", newDonForm)
			fmt.Println(errs)
			return
		}

		recp = models.Recipient{
			FirstName:    r.FormValue("firstName"),
			LastName:     r.FormValue("lastName"),
			Address:      r.FormValue("add"),
			Occupation:   r.FormValue("occupation"),
			Username:     r.FormValue("userName"),
			Password:     string(hashedPassword),
			PhoneNumber:  r.FormValue("phone"),
			EmailAddress: r.FormValue("email"),
			RoleID:       uint(role.ID),
			//BankAct: req.FormValue("bankAct"),
		}
		fmt.Println(recp)

		_, erro := rch.recpService.SignupRecipient(&recp)
		fmt.Println(erro)
		if erro != nil {
			panic(err)

		}
		rch.loggedInRecipient = &recp
		claims := tokens.Claims(recp.Username, rch.recpSess.Expires)
		session.Create(claims, rch.recpSess.UUID, rch.recpSess.SigningKey, w)

		newSess, errs := rch.sessionService.StoreSession(rch.recpSess)
		if errs != nil {
			newDonForm.VErrors.Add("generic", "Failed to store session")
			rch.tmpl.ExecuteTemplate(w, "recipientSignup.html", newDonForm)
			return
		}
		rch.recpSess = newSess
		http.Redirect(w, r, "/recipientInfo", http.StatusSeeOther)
		//rch.tmpl.ExecuteTemplate(w,"recipientInfo1.layout",nil)

	}
}

func (rch *RecipientHandler) RecipientLogin(w http.ResponseWriter, r *http.Request) {
	token, err := tokens.CSRFToken(rch.csrfSignKey)
	if err != nil {
		http.Error(w, http.StatusText(http.StatusInternalServerError), http.StatusInternalServerError)
	}
	if r.Method == http.MethodGet {
		loginForm := struct {
			Values  url.Values
			VErrors form.ValidationErrors
			CSRF    string
		}{
			Values:  nil,
			VErrors: nil,
			CSRF:    token,
		}
		rch.tmpl.ExecuteTemplate(w, "rlogin.html", loginForm)
		return
	}
	if r.Method == http.MethodPost {
		err := r.ParseForm()
		if err != nil {
			http.Error(w, http.StatusText(http.StatusBadRequest), http.StatusBadRequest)
			return
		}
		loginForm := form.Input{Values: r.PostForm, VErrors: form.ValidationErrors{}}
		rec, errs := rch.recpService.RecipientByUsername(r.FormValue("lusername"))
		if errs != nil {
			loginForm.VErrors.Add("generic", "Username or Password is wrong")
			rch.tmpl.ExecuteTemplate(w, "rlogin.html", loginForm)
			return
		}
		err = bcrypt.CompareHashAndPassword([]byte(rec.Password), []byte(r.FormValue("lpassword")))

		if err == bcrypt.ErrMismatchedHashAndPassword {
			loginForm.VErrors.Add("generic", "Username or Password is wrong")
			rch.tmpl.ExecuteTemplate(w, "rlogin.html", loginForm)
			return
		}

		rch.loggedInRecipient = rec
		fmt.Println(err)
		claims := tokens.Claims(rec.Username, rch.recpSess.Expires)
		session.Create(claims, rch.recpSess.UUID, rch.recpSess.SigningKey, w)
		newSess, errs := rch.sessionService.StoreSession(rch.recpSess)
		if errs != nil {
			loginForm.VErrors.Add("generic", "Failed to store session")
			rch.tmpl.ExecuteTemplate(w, "rlogin.html", loginForm)
			return
		}
		rch.recpSess = newSess
		fmt.Println("recpSesss", rch.recpSess)
		roles, _ := rch.recpRole.RecipientRoles(rec)

		recpInfo := rch.SelectByUsername(r.FormValue("lusername"))

		if rch.checkRecipient(roles) {

			rch.tmpl.ExecuteTemplate(w, "recipientPage.layout", recpInfo)
			return
		}
		//http.Redirect(w, r, "/recipientInfo", http.StatusSeeOther)
		http.Redirect(w, r, "/recipient/signup", http.StatusSeeOther)

	}
}

func (rch *RecipientHandler) Logout(w http.ResponseWriter, r *http.Request) {
	recSess, _ := r.Context().Value(ctxUserSessionKey).(*models.Session)
	fmt.Println("recSess", recSess)
	session.Remove(recSess.UUID, w)
	rch.sessionService.DeleteSession(recSess.UUID)
	http.Redirect(w, r, "/home", http.StatusSeeOther)
}

func (rch *RecipientHandler) loggedIn(r *http.Request) bool {
	if rch.recpSess == nil {
		fmt.Println("la1")
		return false
	}
	recSess := rch.recpSess
	c, err := r.Cookie(recSess.UUID)
	if err != nil {
		fmt.Println("la2", err)
		return false
	}
	ok, err := session.Valid(c.Value, recSess.SigningKey)
	if !ok || (err != nil) {
		fmt.Println("la3", err)
		return false
	}
	return true
}

func (rch *RecipientHandler) checkRecipient(r models.Role) bool {

	if strings.ToUpper(r.Name) == strings.ToUpper("recipient") {
		return true
	}

	return false
}

func (rch *RecipientHandler) SelectByUsername(username string) *models.RecipientInfo {
	recpi, _ := rch.recpService.SelectByUsername(username)
	return recpi

}
