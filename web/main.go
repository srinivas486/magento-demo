package main

import (
	"bytes"
	"fmt"
	"html/template"
	"log"
	"net/http"
	"os"
	"os/exec"
	"strings"
)

func sayhelloName(w http.ResponseWriter, r *http.Request) {
	r.ParseForm() //Parse url parameters passed, then parse the response packet for the POST body (request body)
	// attention: If you do not call ParseForm method, the following data can not be obtained form
	fmt.Println(r.Form) // print information on server side.
	fmt.Println("path", r.URL.Path)
	fmt.Println("scheme", r.URL.Scheme)
	fmt.Println(r.Form["url_long"])
	for k, v := range r.Form {
		fmt.Println("key:", k)
		fmt.Println("val:", strings.Join(v, ""))
	}
	fmt.Fprintf(w, "Hello astaxie!") // write data to response
}

func provision(w http.ResponseWriter, r *http.Request) {
	fmt.Println("method:", r.Method) //get request method
	if r.Method == "GET" {
		t, _ := template.ParseFiles("login.gtpl")
		t.Execute(w, nil)
	} else {
		r.ParseForm()
		for k, v := range r.Form {
			fmt.Println("key:", k)
			fmt.Println("val:", strings.Join(v, ""))
		}
		cmd := exec.Command("/usr/bin/make", "deploy")
		//cmd := exec.Command("sleep", "1000 && ls -ltrh")
		cmd.Dir = "../"
		cmd.Env = os.Environ()
		cmd.Env = append(cmd.Env, "CUSTOMER_NAME="+r.Form["name"][0])
		cmd.Env = append(cmd.Env, "ADMIN_FIRST_NAME="+r.Form["adminfname"][0])
		cmd.Env = append(cmd.Env, "ADMIN_LAST_NAME="+r.Form["adminlname"][0])
		cmd.Env = append(cmd.Env, "ADMIN_USERNAME="+r.Form["adminuname"][0])
		cmd.Env = append(cmd.Env, "ADMIN_PASSWORD="+r.Form["adminpwd"][0])
		cmd.Env = append(cmd.Env, "ADMIN_EMAIL="+r.Form["email"][0])
		cmd.Env = append(cmd.Env, "CURRENCY="+r.Form["currency"][0])
		cmd.Env = append(cmd.Env, "LANGUAGE="+r.Form["language"][0])
		cmd.Env = append(cmd.Env, "TIMEZONE="+r.Form["timezone"][0])
		cmd.Env = append(cmd.Env, "REPLICAS="+r.Form["from-value"][0])
		cust := r.Form["name"][0]
		var stdout, stderr bytes.Buffer
		cmd.Stdout = &stdout
		cmd.Stderr = &stderr
		err := cmd.Run()
		if err != nil {
			log.Fatalf("cmd.Run() failed with %s\n", err)
		}
		outStr, errStr := string(stdout.Bytes()), string(stderr.Bytes())
		fmt.Printf("out:\n%s\nerr:\n%s\n", outStr, errStr)
		w.Write([]byte("<H2>Site Provisioned..</H2><a target='_blank' href='https://" + cust + ".magento.com'><H3>https://" + cust + ".magento.com</H3></a>"))
		// logic part of log in
		//	fmt.Println("username:", r.Form["username"])
		//	fmt.Println("password:", r.Form["password"])
	}
}

func main() {
	fs := http.FileServer(http.Dir("./"))
	http.Handle("/", fs)
	//	http.Handle("/css/", http.StripPrefix("/css/", fs))
	//	http.Handle("/vendor/", fs)
	//	http.Handle("/fonts/", http.StripPrefix("/static/", fs))

	//http.HandleFunc("/", sayhelloName) // setting router rule
	http.HandleFunc("/provision", provision)
	err := http.ListenAndServe(":9090", nil) // setting listening port
	if err != nil {
		log.Fatal("ListenAndServe: ", err)
	}
}
