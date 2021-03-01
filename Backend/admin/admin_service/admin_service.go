package admin_service

import (
	"github.com/FundStation2/admin"
	"github.com/FundStation2/models"
)

// CategoryService implements menu.CategoryService interface
type AdminService struct {
	aRepo admin.AdminRepository
}

// NewCategoryService will create new CategoryService object
func NewAdminService(adRepo admin.AdminRepository) *AdminService {
	return &AdminService{aRepo: adRepo}
}
func (as *AdminService) LoginAdmin(user string) (*models.Admin,error) {

	adm,err := as.aRepo.SelectAdmin(user)

	if err != nil {
		return adm, err
	}

	return adm,nil
}
