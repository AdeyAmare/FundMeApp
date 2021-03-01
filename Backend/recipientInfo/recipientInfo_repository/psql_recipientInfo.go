package recipientInfo_repository

import (
	"database/sql"
	"errors"
	"fmt"

	"github.com/FundStation2/models"
)

type PsqlRecipientInfoRepository struct {
	conn *sql.DB
}

func NewPsqlRecipientInfoRepository(Conn *sql.DB) *PsqlRecipientInfoRepository {
	return &PsqlRecipientInfoRepository{conn: Conn}
}

func (pr *PsqlRecipientInfoRepository) InsertRecipientInfo(ri models.RecipientInfo, re models.Recipient) error {

	err := pr.conn.QueryRow("INSERT INTO recipientinfo(image,description,attachment,submitteddate,accountno,goal,approval,recipient_id) VALUES($1, $2, $3, $4,$5,$6,$7,$8) returning id", ri.Image, ri.Description, ri.Attachment, ri.Date, ri.BankAccount, ri.Goal, ri.Approval, re.RecipientNo).Scan(&ri.ID)
	fmt.Println("bnkkkkkk", ri.BankAccount)
	print("\n")
	if err != nil {
		fmt.Println("hereeeeeeeeeeee", err)
		return err
	}
	return nil
}

func (pr *PsqlRecipientInfoRepository) SelectRecipientInfo(recipientNo int) (recipientInfo models.RecipientInfo, err error) {
	//var bankAccount models.BankAccount
	err = pr.conn.QueryRow("SELECT id, image, description,attachment, submitteddate,accountno,goal,approval FROM recipientinfo WHERE recipient_id=$1", recipientNo).Scan(&recipientInfo.ID, &recipientInfo.Image, &recipientInfo.Description, &recipientInfo.Attachment, &recipientInfo.Date, &recipientInfo.BankAccount, &recipientInfo.Goal, &recipientInfo.Approval)
	//	recipientInfo.BankAccount = bankAccount
	if err != nil {
		return recipientInfo, errors.New("")
	}
	return recipientInfo, nil

}

func (pr *PsqlRecipientInfoRepository) SelectAllRecipientInfo() (recipientinfos []models.DonationInfo, err error) {
	selRec, err := pr.conn.Query("SELECT recipient_id,firstname,lastname,address,phone,email,image,description,attachment,submitteddate,recipientinfo.accountno,goal,balance, approval FROM recipientinfo INNER JOIN recipient ON recipientinfo.recipient_id = recipient.id INNER JOIN bankinfo ON recipientinfo.accountno = bankinfo.accountno")
	if err != nil {
		return recipientinfos, errors.New("something")
	}
	recp := models.DonationInfo{}
	//var bankAccount models.BankAccount
	for selRec.Next() {
		err := selRec.Scan(&recp.RecipientNo, &recp.FirstName, &recp.LastName, &recp.Address, &recp.PhoneNumber, &recp.EmailAddress, &recp.Image, &recp.Description, &recp.Attachment, &recp.Date, &recp.AccountNo, &recp.Goal, &recp.Balance)
		//	recp.BankAccount = bankAccount
		if recp.Approval == "yes" {
			recp.Current = checkAmount(recp.Balance, recp.Goal)
		} else {
			recp.Current = 0.0
		}
		if err != nil {
			return recipientinfos, errors.New("Couldnot")
		}
		recipientinfos = append(recipientinfos, recp)
	}
	return recipientinfos, nil
}

func (pr *PsqlRecipientInfoRepository) UpdateRecipientInfo(recipientInfoNo int) (err error) {
	_, err = pr.conn.Exec("UPDATE recipientinfo SET approval = 'yes' WHERE recipient_id = $1", recipientInfoNo)
	if err != nil {
		return errors.New("Could not approve Recipient Info")
	}
	return nil

}
func (pr *PsqlRecipientInfoRepository) AccountExistsInfo(account string) bool {

	err := pr.conn.QueryRow("SELECT * FROM recipientinfo WHERE accountno=$1", account)

	if err != nil {
		return false
	}

	return true
}

func (pr *PsqlRecipientInfoRepository) SelectApproved() ([]models.DonationInfo, error) {
	donations := []models.DonationInfo{}
	donation := models.DonationInfo{}
	selRec, err := pr.conn.Query("SELECT recipient_id,firstname,lastname,address,phone,email,image,description,attachment,submitteddate,recipientinfo.accountno,goal,balance,approval FROM recipientinfo INNER JOIN recipient ON recipientinfo.recipient_id = recipient.id INNER JOIN bankinfo ON recipientinfo.accountno = bankinfo.accountno")
	if err != nil {
		fmt.Println(err)
		return donations, err
	}

	for selRec.Next() {
		err := selRec.Scan(&donation.RecipientNo, &donation.FirstName, &donation.LastName, &donation.Address, &donation.PhoneNumber, &donation.EmailAddress, &donation.Image, &donation.Description, &donation.Attachment, &donation.Date, &donation.AccountNo, &donation.Goal, &donation.Balance, &donation.Approval)
		donation.Current = checkAmount(donation.Balance, donation.Goal)

		if err != nil {
			fmt.Println(err)
			return donations, errors.New("Couldnot")
		}
		donations = append(donations, donation)

	}
	fmt.Println("recp", donations)
	return donations, nil
}

func (pr *PsqlRecipientInfoRepository) SelectIndividualById(id int) (models.DonationInfo, error) {

	donation := models.DonationInfo{}
	selRec := pr.conn.QueryRow("SELECT recipient_id,firstname,lastname,address,phone,email,image,description,attachment,submitteddate,recipientinfo.accountno,goal,balance FROM recipientinfo INNER JOIN recipient ON recipientinfo.recipient_id = recipient.id INNER JOIN bankinfo ON recipientinfo.accountno = bankinfo.accountno WHERE recipientinfo.approval = 'yes' AND recipientinfo.recipient_id=$1", id)

	err := selRec.Scan(&donation.RecipientNo, &donation.FirstName, &donation.LastName, &donation.Address, &donation.PhoneNumber, &donation.EmailAddress, &donation.Image, &donation.Description, &donation.Attachment, &donation.Date, &donation.AccountNo, &donation.Goal, &donation.Balance)
	donation.Current = checkAmount(donation.Balance, donation.Goal)
	if err != nil {
		fmt.Println(err)
		return donation, errors.New("Couldtno")
	}

	return donation, nil
}
func (pr *PsqlRecipientInfoRepository) DeleteRecipientInfoById(id int) error {

	_, err := pr.conn.Exec("DELETE FROM recipientinfo where recipient_id=$1", id)

	if err != nil {
		fmt.Println(err)
		return err
	}

	return nil
}

func checkAmount(currentAmount, goal float64) float64 {
	percent := (currentAmount / goal) * 100
	return percent
}
