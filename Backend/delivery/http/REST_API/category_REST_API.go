package REST_API

import (
	"encoding/json"
	"fmt"
	"net/http"

	"github.com/FundStation2/category"
	"github.com/FundStation2/models"
)

type CategoryApiHandler struct {
	categoryApiService category.CategoryService
}

func NewCategoryApiHandler(cs category.CategoryService) *CategoryApiHandler {
	return &CategoryApiHandler{categoryApiService: cs}
}

func (cah *CategoryApiHandler) GetCategories(w http.ResponseWriter, r *http.Request) {
	//id,err := strconv.Atoi(path.Base(r.URL.Path))
	//if err != nil{
	//	return
	//}
	categories, err := cah.categoryApiService.ViewAllCategory()
	fmt.Println("categories", categories)
	if err != nil {
		return
	}

	output, err := json.MarshalIndent(&categories, "", "\t\t")

	if err != nil {
		return
	}
	w.Header().Set("Content-Type", "application/json")
	w.Write(output)
	return
}

func (cah *CategoryApiHandler) PostCategory(w http.ResponseWriter, r *http.Request) {
	len := r.ContentLength
	body := make([]byte, len)
	r.Body.Read(body)
	var category models.Category
	//rId,_:=strconv.Atoi(r.FormValue("role_id"))

	json.Unmarshal(body, &category)

	// if erro != nil {
	// 	return
	// }

	fmt.Println(category)
	//p := fmt.Sprintf("/v1/donor/%d", donor.DonorNo)
	// uexists := dah.donorApiService.UsernameExists(donor.Username)
	// if uexists {
	// 	w.Write([]byte("username exists"))
	// 	w.WriteHeader(http.StatusConflict) //409
	// 	return

	// }
	_, err := cah.categoryApiService.InsertCategory(&category)
	if err != nil {
		fmt.Println("err", err)
		return
	}
	//w.Header().Set("Location", p)

	w.WriteHeader(http.StatusCreated)
	return
}

func (cah *CategoryApiHandler) RecieveImage(w http.ResponseWriter, r *http.Request) {
	//len := r.ContentLength
	//body := make([]byte, len)
	//fmt.Println("image", body)
	//fmt.Println("body", r.Body)
	//json.Unmarshal(body, &recipientInfo)

	w.WriteHeader(http.StatusCreated)
	fmt.Println("status", http.StatusCreated)
	return
}
