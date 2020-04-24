package main

import (
	"bufio"
	"bytes"
	"encoding/json"
	"flag"
	"fmt"
	"net/http"
	"os"
	"path/filepath"
	"strings"
)

func main() {
	var err error
	defer func() {
		if err != nil {
			fmt.Print(err)
			os.Exit(1)
		}
	}()

	searchDir := flag.String("folder", ".", "Directory with source code")
	serverEndpoint := flag.String("endpoint", "", "ServiceGraph http endpoint")
	service := flag.String("service", "", "Service name")

	fileList := []string{}

	flag.Parse()

	filepath.Walk(*searchDir, func(path string, f os.FileInfo, err error) error {
		fileList = append(fileList, path)
		return nil
	})

	lines := []string{}

	for _, file := range fileList {
		read_file(file, &lines)
	}

	post_request(*serverEndpoint, *service, &lines)
}

func post_request(endpoint string, service string, lines *[]string) {
	reqBody, err := json.Marshal(map[string][]string{
		"definitions": *lines})

	if err != nil {
		return
	}

	http.Post(endpoint+"/api/relations/"+service+"/bulk_definition", "application/json", bytes.NewBuffer(reqBody))
}

func read_file(file string, lines *[]string) {
	f, err := os.Open(file)

	defer f.Close()

	if err != nil {
		return
	}
	// Splits on newlines by default.
	scanner := bufio.NewScanner(f)
	// https://golang.org/pkg/bufio/#Scanner.Scan
	for scanner.Scan() {
		str := scanner.Text()

		// SG_tag: uses Service#action
		// SG_tag:    implements bulk

		if strings.Contains(str, "SG_tag"+": ") {
			*lines = append(*lines, str)
		}
	}

	if err := scanner.Err(); err != nil {
		return
	}
}
