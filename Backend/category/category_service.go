package category

import "github.com/FundStation2/models"

type CategoryService interface {
	InsertCategory(*models.Category) (*models.Category, error)
	ViewCategory(string) ([]models.Category, error)
	ViewAllCategory() ([]models.Category, error)
	ViewSpecificCategory(string) (models.Category, error)
}
