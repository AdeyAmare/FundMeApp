package recipientInfo_repository

import (
	"database/sql"
	"fmt"

	"github.com/FundStation2/models"
	"github.com/FundStation2/recipientInfo"
)

type MockRecipientInfoRepository struct {
	conn *sql.DB
}

func NewMockRecipientInfoRepository(Conn *sql.DB) recipientInfo.RecipientInfoRepository {
	return &MockRecipientInfoRepository{conn: Conn}
}

func (mr *MockRecipientInfoRepository) InsertRecipientInfo(ri models.RecipientInfo, rec models.Recipient) error {
	recinfo := models.RecipientInfoMock
	fmt.Println(recinfo)
	return nil
}

func (mr *MockRecipientInfoRepository) SelectRecipientInfo(recipientNo int) (recipientInfo models.RecipientInfo, err error) {
	recipientInfo = models.RecipientInfo{}
	if recipientNo == models.RecipientInfoMock.Recipient.RecipientNo {
		recipientInfo = models.RecipientInfoMock
		return recipientInfo, nil
	}
	return recipientInfo, err

}

func (mr *MockRecipientInfoRepository) SelectAllRecipientInfo() ([]models.DonationInfo, error) {
	recipientInfos := []models.DonationInfo{}
	// recipientInfos = append(recipientInfos, models.RecipientInfoMock)
	// recipientInfos = append(recipientInfos, models.RecipientInfoMock)

	return recipientInfos, nil

}

func (mr *MockRecipientInfoRepository) UpdateRecipientInfo(recipientInfoNo int) (err error) {
	if recipientInfoNo == models.RecipientInfoMock.ID {
		return nil
	}
	return err

}
func (mr *MockRecipientInfoRepository) AccountExistsInfo(account string) bool {

	return false
}

func (mr *MockRecipientInfoRepository) SelectApproved() ([]models.DonationInfo, error) {
	donationInfos := []models.DonationInfo{}
	donationInfos = append(donationInfos, models.DonationInfoMock)
	donationInfos = append(donationInfos, models.DonationInfoMock)

	return donationInfos, nil
}

func (mr *MockRecipientInfoRepository) SelectIndividualById(id int) (don models.DonationInfo, err error) {
	if id == models.RecipientInfoMock.ID {
		return models.DonationInfoMock, nil
	}
	return models.DonationInfoMock, err
}
func (mr *MockRecipientInfoRepository) DeleteRecipientInfoById(id int) (err error) {

	if id == models.RecipientInfoMock.ID {
		return nil
	}
	return err
}
