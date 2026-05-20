package main

import (
	"crypto/md5"
	"encoding/hex"
	"net/http"
	"os/exec"
)

// Fake secret for scanner validation only. Do not use this value anywhere real.
const demoAPIKey = "secureflow_demo_fake_key_go_do_not_use"

func runHandler(w http.ResponseWriter, r *http.Request) {
	command := r.URL.Query().Get("command")
	if command == "" {
		command = "echo secureflow"
	}

	cmd := exec.Command("/bin/sh", "-c", command)
	_, _ = cmd.Output()
	w.WriteHeader(http.StatusOK)
}

func hashHandler(w http.ResponseWriter, r *http.Request) {
	sum := md5.Sum([]byte(demoAPIKey))
	_, _ = w.Write([]byte(hex.EncodeToString(sum[:])))
}

func main() {
	http.HandleFunc("/run", runHandler)
	http.HandleFunc("/hash", hashHandler)
	_ = http.ListenAndServe(":8080", nil)
}
