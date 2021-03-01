package category_service

import (
	"github.com/FundStation2/category"
	"github.com/FundStation2/models"
)

type CategoryService struct {
	cRepo category.CategoryRepository
}

// NewCategoryService will create new CategoryService object
func NewCategoryService(catRepo category.CategoryRepository) *CategoryService {
	return &CategoryService{cRepo: catRepo}
}

func (cs *CategoryService) InsertCategory(cat *models.Category) (categoryy *models.Category, err error) {

	categoryy, err = cs.cRepo.InsertCategory(cat)

	if err != nil {
		return categoryy, err
	}

	return categoryy, nil
}

func (cs *CategoryService) ViewCategory(typee string) (categoryy []models.Category, err error) {

	categoryy, err = cs.cRepo.SelectCategory(typee)

	if err != nil {
		return categoryy, err
	}

	return categoryy, nil
}

func (cs *CategoryService) ViewAllCategory() (categoryy []models.Category, err error) {

	categoryy, err = cs.cRepo.SelectAllCategory()

	if err != nil {
		return categoryy, err
	}

	return categoryy, nil
}

func (cs *CategoryService) ViewSpecificCategory(catName string) (categoryy models.Category, err error) {

	categoryy, err = cs.cRepo.SelectSpecificCategory(catName)

	if err != nil {
		return categoryy, err
	}

	return categoryy, nil
}
