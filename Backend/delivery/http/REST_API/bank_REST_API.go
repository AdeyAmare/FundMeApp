package REST_API

import (
	"encoding/json"
	"fmt"

	"net/http"

	"strconv"

	"github.com/FundStation2/bankAct"
	"github.com/FundStation2/models"
)

type BankApiHandler struct {
	bankApiService bankAct.BankService
}

func NewBankApiHandler(bs bankAct.BankService) *BankApiHandler {
	return &BankApiHandler{bankApiService: bs}
}

func (bah *BankApiHandler) Transfer(w http.ResponseWriter, r *http.Request) {
	len := r.ContentLength
	body := make([]byte, len)
	r.Body.Read(body)
	var transfer models.Transfer
	//rId,_:=strconv.Atoi(r.FormValue("role_id"))

	json.Unmarshal(body, &transfer)
	fmt.Println("donorAct", transfer.DonorAcct)
	fmt.Println("recAct", transfer.RecAcct)
	trans, err := strconv.ParseFloat(transfer.TransAmt, 64)
	fmt.Println("trans", transfer.TransAmt)
	if err != nil {
		fmt.Println("err", err)
	}
	err = bah.bankApiService.Transfer(transfer.DonorAcct, transfer.RecAcct, trans)
	//fmt.Println("admin", admin)
	if err != nil {
		fmt.Println("err", err)
	}

	if err != nil {
		return
	}
	//w.Header().Set("Location", p)

	w.WriteHeader(http.StatusCreated)
	return

}
