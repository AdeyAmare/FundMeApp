package models

type Recipient struct {
	//RecipientNo  int
	//Image        string
	RecipientNo  int  		`json:"id"`
	FirstName    string		`json:"firstname"`
	LastName     string		`json:"lastname"`
	Address      string		`json:"address"`
	Occupation   string		`json:"occupation"`
	Username     string		`json:"username"`
	Password     string		`json:"password"`
	PhoneNumber  string		`json:"phone"`
	EmailAddress string		`json:"email"`
	RoleID uint				`json:"role_id"`
}

