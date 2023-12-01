package main

import "fmt"
import "os"
import "strconv"
import "bufio"
import "log"

func check(e error) {
	if e != nil {
		panic(e)
	}
}

func max(a int, b int) int {
	if a > b {
		return a
	} else {
		return b
	}
}

func main() {
	maxC := 0
	current := 0

	input, error := os.Open("input.txt")
	check(error)
	defer input.Close()

	scanner := bufio.NewScanner(input)

	for scanner.Scan() {
		if len(scanner.Text()) > 0 {
      conv, err := strconv.Atoi(scanner.Text())
			check(err)

			current += conv
		} else {
			maxC = max(current, maxC)
			current = 0
		}
	}

  maxC = max(maxC, current)

	if err := scanner.Err(); err != nil {
		log.Fatal(err)
	}

	fmt.Println(maxC)
}
