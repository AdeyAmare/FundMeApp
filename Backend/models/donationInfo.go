package models

import "time"

type DonationInfo struct {
	RecipientNo  int       `json:"recipient_id"`
	FirstName    string    `json:"firstname"`
	LastName     string    `json:"lastname"`
	Address      string    `json:"address"`
	PhoneNumber  string    `json:"phone"`
	EmailAddress string    `json:"email"`
	Image        string    `json:"image"`
	Description  string    `json:"description"`
	Attachment   string    `json:"attachment"`
	Date         time.Time `json:"submitteddate"`
	AccountNo    string    `json:"account"`
	Goal         float64   `json:"goal"`
	Balance      float64   `json:"balance"`
	Current      float64   `json:"current"`
	Approval     string    `json:"approval"`
}
