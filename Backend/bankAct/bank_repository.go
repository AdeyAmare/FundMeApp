package bankAct

import (
	"github.com/FundStation2/models"
)

type BankRepository interface {
	SelectAccountNo(string) (models.BankAccount, error)
	UpdateBalance(string, float64) error
	AccountExists(account string) bool

}
