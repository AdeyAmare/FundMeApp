package recipientInfo

import "github.com/FundStation2/models"

type RecipientInfoRepository interface {
	InsertRecipientInfo(recipientInfo models.RecipientInfo, rec models.Recipient) error
	SelectRecipientInfo(int) (models.RecipientInfo, error)
	UpdateRecipientInfo(int) error
	AccountExistsInfo(account string) bool
	//SelectApproved() (rinfo []models.RecipientInfo,err error)
	SelectApproved() ([]models.DonationInfo, error)
	SelectIndividualById(id int) (models.DonationInfo, error)
	SelectAllRecipientInfo() ([]models.DonationInfo, error)
	DeleteRecipientInfoById(int) error
}
