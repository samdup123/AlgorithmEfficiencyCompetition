package main

import (
  "net/http"
  "github.com/antonholmquist/jason"
  "github.com/gorilla/mux"
  "fmt"
)

func HandleRequest(w http.ResponseWriter, request *http.Request) {
  submission, err := jason.NewObjectFromReader(request.Body)
  if err != nil { fmt.Println("blarg") }
  code, err := submission.GetString("code")
  w.Write([]byte(code))
}

func main() {
  router := mux.NewRouter()
  router.HandleFunc("/submission", HandleRequest).Methods("POST")
  http.ListenAndServe(":8080", router)
}
