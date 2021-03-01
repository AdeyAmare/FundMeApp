package category

import "github.com/FundStation2/models"

type CategoryRepository interface {
	InsertCategory(*models.Category) (*models.Category, error)
	SelectCategory(string) ([]models.Category, error)
	SelectSpecificCategory(string) (models.Category, error)
	SelectAllCategory() ([]models.Category, error)
}
