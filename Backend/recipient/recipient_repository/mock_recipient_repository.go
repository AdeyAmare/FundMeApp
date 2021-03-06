package recipient_repository

import (
	"database/sql"
	"errors"
	"github.com/FundStation2/models"
	"github.com/FundStation2/recipient"
)


type MockRecipientRepo struct {
	conn *sql.DB
}




func NewMockRecipientRepo(db *sql.DB) recipient.RecipientRepository {
	return &MockRecipientRepo{conn: db}
}


func (mRecipientRepo *MockRecipientRepo)SelectAllRecipient() ([]models.Recipient, error) {
	recps := []models.Recipient{models.RecipientMock}
	return recps, nil
}


func (mRecipientRepo *MockRecipientRepo) SelectRecipient(rec models.Recipient) (error) {
	rec = models.RecipientMock
	if rec.Username == "mockyuser" && rec.Password=="password" {
		return nil
	}
	return errors.New("Not found")
}

func (mRecipientRepo *MockRecipientRepo) InsertRecipient(recipient *models.Recipient) (*models.Recipient,error) {
	rec := recipient
	return rec,nil
}

func (mRecipientRepo *MockRecipientRepo) PhoneExists(phone string) bool {

	if phone != models.RecipientMock.PhoneNumber{
		return false
	}

	return true
}
func (mRecipientRepo *MockRecipientRepo) UsernameExists(username string) bool {
	if username != models.RecipientMock.Username{
		return false
	}

	return true
}


func (mRecipientRepo *MockRecipientRepo) EmailExists(email string) bool {


	if email != models.RecipientMock.EmailAddress{
		return false
	}

	return true
}

func (mRecipientRepo *MockRecipientRepo) RecipientByUsername(username string) (*models.Recipient,error) {

	if username == "mockyuser" {

		return &models.RecipientMock,nil
	}
	return nil,errors.New("Not found")
}

func (mRecipientRepo *MockRecipientRepo) RecipientById(id int) (*models.Recipient,error) {

	if id == 1 {

		return &models.RecipientMock,nil
	}
	return nil,errors.New("Not found")
}

func (mRecipientRepo *MockRecipientRepo) UpdateRecipientById(recipient *models.Recipient) (error) {

	return nil
}

func (mRecipientRepo *MockRecipientRepo) DeleteRecipientById(recipient *models.Recipient) (error) {

	return nil
}

func (mRecipientRepo *MockRecipientRepo) SelectByUsername(username string)(*models.RecipientInfo,error){
	return &models.RecipientInfoMock,nil
}

