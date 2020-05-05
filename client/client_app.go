package main

import (
	"bufio"
	"bytes"
	"encoding/json"
	"flag"
	"fmt"
	"log"
	"net/http"
	"os"
	"os/exec"
	"path/filepath"
	"strings"
)

type Message struct {
		Gitstats string
		Definitions []string
}

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

	gitstats := git_stats(*searchDir)

	filepath.Walk(*searchDir, func(path string, f os.FileInfo, err error) error {
		fileList = append(fileList, path)
		return nil
	})

	lines := []string{}

	for _, file := range fileList {
		read_file(file, &lines)
	}

	post_request(*serverEndpoint, *service, gitstats, &lines)
}

func post_request(endpoint string, service string, gitstats string, lines *[]string) {
	var jsonData []byte

	m := Message{Gitstats: gitstats,
		Definitions: (*lines)}

	jsonData, err := json.Marshal(m)

	if err != nil {
		return
	}

	http.Post(endpoint+"/api/relations/"+service+"/bulk_definition", "application/json", bytes.NewBuffer(jsonData))
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

func git_stats(path string) string {
	script := `
		if [[ "$OSTYPE" == "darwin"* ]]; then
			since=${PARAMS[0]:-$(date -v-30d '+%d %m %Y')}
		else
			since=${PARAMS[0]:-$(date -d '30 days' '+%d %m %Y')}
		fi

		authors=$(git -C ` + path + ` log --no-merges --format='%aN' --since="$since" | sort -u)
	
		IFS=$'\n' read -d '' -r -a authors < <(printf '%s\n' "$authors")
		IFS=' '

		gitlog='git -C `  + path +  ` log --shortstat --no-merges --diff-filter=ACDM'

		author_stats() {
  		awk -v author="$author" \
    	'{files+=$1; inserted+=$4; deleted+=$6; delta+=$4-$6} END {
				printf "\n%s, %s, %s, %s, %s", 
				author, 
				files, 
				inserted, 
				deleted, 
				delta
			}'
		}

		stats=''
		for author in "${authors[@]}"; do
			stats+=$($gitlog --author="$author" --since="$since" |
				grep -E "fil(e|es) changed" | author_stats "$author")
		done

		printf "%s\n" "$stats"
	`

	err, out, errout := Shellout(script)
	if err != nil {
		log.Printf("error: %v\n", err)
	}
	fmt.Println("--- stdout ---")
	fmt.Println(out)
	fmt.Println("--- stderr ---")
	fmt.Println(errout)

	return out
}

const ShellToUse = "bash"

func Shellout(command string) (error, string, string) {
	var stdout bytes.Buffer
	var stderr bytes.Buffer
	cmd := exec.Command(ShellToUse, "-c", command)
	cmd.Stdout = &stdout
	cmd.Stderr = &stderr
	err := cmd.Run()
	return err, stdout.String(), stderr.String()
}
