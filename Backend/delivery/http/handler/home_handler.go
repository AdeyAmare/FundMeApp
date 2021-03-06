package handler

import (
	"html/template"
	"net/http"
)



type HomeHandler struct {
	tmpl        *template.Template
}


func NewHomeHandler(T *template.Template) *HomeHandler {
	return &HomeHandler{tmpl: T}
}
func (hh *HomeHandler) Home(w http.ResponseWriter, r *http.Request) {
	if r.URL.Path != "/home" {
		http.NotFound(w, r)
		return
	}
	 hh.tmpl.ExecuteTemplate(w,"home.layout",nil)
}

