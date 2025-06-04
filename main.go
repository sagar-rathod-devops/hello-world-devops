package main

import (
	"fmt"
	"net/http"
)

func handler(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "Hello World from Jenkins-ECR-EKS Pipeline!")
}

func main() {
	http.HandleFunc("/", handler)
	http.ListenAndServe(":8000", nil)
}
