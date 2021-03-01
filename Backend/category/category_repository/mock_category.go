package category_repository

import (
	"database/sql"

	"github.com/FundStation2/category"

	//"errors"

	"github.com/FundStation2/models"
)

type MockCategoryRepository struct {
	conn *sql.DB
}

// NewPsqlCategoryRepository will create an object of PsqlCategoryRepository
func NewMockCategoryRepository(Conn *sql.DB) category.CategoryRepository {
	return &MockCategoryRepository{conn: Conn}
}

func (cr *MockCategoryRepository) SelectCategory(categoryType string) (categoryy []models.Category, err error) {

	categoryy = append(categoryy, models.CategoryMock)
	return categoryy, nil

}

func (cr *MockCategoryRepository) SelectAllCategory() (categoryy []models.Category, err error) {

	categoryy = append(categoryy, models.CategoryMock)
	return categoryy, nil

}

func (cr *MockCategoryRepository) SelectSpecificCategory(categoryName string) (cat models.Category, err error) {
	cat = models.CategoryMock
	return cat, err

}

func (cr *MockCategoryRepository) InsertCategory(cat *models.Category) (catt *models.Category, err error) {
	//catt = models.CategoryMock
	return catt, err
}
