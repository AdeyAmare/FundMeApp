package recipientInfo

import "github.com/FundStation2/models"

// CategoryRepository specifies menu category related database operations
type RecipientInfoService interface {
	CreateRecipientInfo(recipientInfo models.RecipientInfo, rec models.Recipient) error
	ViewSpecificRecipientInfo(int) (models.RecipientInfo, error)
	ApproveRecipientInfo(int) error
	AccountExistsInfo(account string) bool
	//SelectApproved() (rinfo []models.RecipientInfo,err error)
	SelectApproved() ([]models.DonationInfo, error)
	SelectIndividualById(id int) (models.DonationInfo, error)
	SelectAll() ([]models.DonationInfo, error)
	DeleteRecipientInfoById(int) error
}
