package models

type Category struct {
	Name        string `json:"name"`
	CatType     string `json:"type"`
	Description string `json:"description"`
	Image       string `json:"image"`
	BankAccount string `json:"account"`
}
