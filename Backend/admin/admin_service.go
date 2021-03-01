package admin

import "github.com/FundStation2/models"

type AdminService interface {
	LoginAdmin(string) (*models.Admin,error)
}
