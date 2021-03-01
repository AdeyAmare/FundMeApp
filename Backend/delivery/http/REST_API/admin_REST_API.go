package REST_API

import (
	"context"
	"encoding/json"
	"fmt"
	"net/http"
	"path"
	"strings"

	"github.com/FundStation2/admin"
	"github.com/FundStation2/models"
	"github.com/FundStation2/permission"
	"github.com/FundStation2/role"
	"github.com/FundStation2/session"
)

type AdminApiHandler struct {
	adminApiService admin.AdminService
	sessionService  role.SessionService
	adminSess       *models.Session
	loggedInAdmin   *models.Admin
	adminRole       role.RoleService
	csrfSignKey     []byte
}

func NewAdminApiHandler(as admin.AdminService, sessServ role.SessionService, aRole role.RoleService,
	usrSess *models.Session, csKey []byte) *AdminApiHandler {
	return &AdminApiHandler{adminApiService: as, sessionService: sessServ,
		adminRole: aRole, adminSess: usrSess, csrfSignKey: csKey}
}

func (aah *AdminApiHandler) Logout(w http.ResponseWriter, r *http.Request) {
	donSess, _ := r.Context().Value(ctxUserSessionKey).(*models.Session)
	session.Remove(donSess.UUID, w)
	aah.sessionService.DeleteSession(donSess.UUID)
	//http.Redirect(w, r, "/donor/login", http.StatusSeeOther)
}

func (aah *AdminApiHandler) loggedIn(r *http.Request) bool {
	if aah.adminSess == nil {
		print("a")
		return false
	}
	adminSess := aah.adminSess
	c, err := r.Cookie(adminSess.UUID)
	if err != nil {
		fmt.Println("b ", err)
		return false
	}
	ok, err := session.Valid(c.Value, adminSess.SigningKey)
	if !ok || (err != nil) {
		print("c")
		return false
	}
	return true
}

func (aah *AdminApiHandler) checkAdmins(r models.Role) bool {

	if strings.ToUpper(r.Name) == strings.ToUpper("donor") {
		return true
	}

	return false
}

func (aah *AdminApiHandler) Authenticated(next http.Handler) http.Handler {
	fn := func(w http.ResponseWriter, r *http.Request) {
		ok := aah.loggedIn(r)
		if !ok {
			println("authhh")
			//http.Redirect(w, r, "/donor", http.StatusSeeOther)
			return
		}
		ctx := context.WithValue(r.Context(), ctxUserSessionKey, aah.adminSess)
		next.ServeHTTP(w, r.WithContext(ctx))
	}
	return http.HandlerFunc(fn)
}

func (aah *AdminApiHandler) Authorized(next http.Handler) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		println("lala")
		if aah.loggedInAdmin == nil {
			println("noDonor")
			http.Error(w, http.StatusText(http.StatusUnauthorized), http.StatusUnauthorized)
			return
		}
		role, errs := aah.adminRole.AdminRoles(aah.loggedInAdmin)
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

func (aah *AdminApiHandler) GetAdmin(w http.ResponseWriter, r *http.Request) {
	username := path.Base(r.URL.Path)

	admin, err := aah.adminApiService.LoginAdmin(username)
	fmt.Println("admin", admin)
	if err != nil {
		return
	}

	output, err := json.MarshalIndent(&admin, "", "\t\t")

	if err != nil {
		return
	}
	w.Header().Set("Content-Type", "application/json")
	w.Write(output)
	return
}
