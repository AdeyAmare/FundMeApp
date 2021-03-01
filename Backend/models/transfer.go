package models

type Transfer struct {
	DonorAcct string `json:"dAcct"`
	RecAcct   string `json:"rAcct"`
	TransAmt  string `json:"transAmt"`
}
