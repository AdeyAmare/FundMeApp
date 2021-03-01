package disaster_service

import(
	"github.com/FundStation2/disaster"
	"github.com/FundStation2/models"
)
type DisasterService struct {
	dRepo disaster.DisasterRepository
}

func NewDisasterService(disRepo disaster.DisasterRepository) *DisasterService {
	return &DisasterService{dRepo: disRepo}
}

func (ds *DisasterService) ViewDisaster() (disaster []models.Disaster, err error) {

	disaster, err = ds.dRepo.SelectDisaster()

	if err != nil {
		return disaster, err
	}

	return disaster, nil
}

func (ds *DisasterService) ViewEvent() (event []models.Event, err error) {

	event, err = ds.dRepo.SelectEvent()

	if err != nil {
		return event, err
	}

	return event, nil
}