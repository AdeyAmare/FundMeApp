package disaster


import "github.com/FundStation2/models"

type DisasterRepository interface {
	SelectDisaster() ([]models.Disaster, error)
	SelectEvent() ([]models.Event, error)
}
