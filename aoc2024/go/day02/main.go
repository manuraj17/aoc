package main

import (
	"bufio"
	"fmt"
	"math"
	"os"
	"strconv"
	"strings"
)

func fail(err error) {
	if err != nil {
		panic(err)
	}
}

func isSafeThreshold(a, b, threshold int) bool {
	diff := int(math.Abs(float64(b - a)))
	if diff >= 1 && diff <= threshold {
		return true
	}

	return false
}

func isInc(a, b int) bool {
	return b >= a
}

func isDec(a, b int) bool {
	return a >= b
}

func isSafeSequence(vals []string, dt int) bool {
	// Your existing safety check logic, but working with a slice of strings
	inc := false
	dec := false

	for i := 1; i < len(vals); i++ {
		x, _ := strconv.Atoi(vals[i-1])
		y, _ := strconv.Atoi(vals[i])

		if !inc && !dec {
			if x < y {
				inc = true
			} else {
				dec = true
			}
			if !isSafeThreshold(x, y, dt) {
				return false
			}
			continue
		}

		if inc && (isDec(x, y) || !isSafeThreshold(x, y, dt)) {
			return false
		}

		if dec && (isInc(x, y) || !isSafeThreshold(x, y, dt)) {
			return false
		}
	}
	return true
}

func part01(name string) int {
	f, err := os.Open(name)
	fail(err)
	defer f.Close()

	// Set up scanner for reading file line by line
	fsc := bufio.NewScanner(f)
	fsc.Split(bufio.ScanLines)

	dt := 3 // Maximum allowed difference between adjacent numbers
	safe := 0

	// Process each line in the input file
	for fsc.Scan() {
		line := fsc.Text()
		vals := strings.Split(line, " ")

		// If the sequence is safe, increment our counter
		if isSafeSequence(vals, dt) {
			safe++
		}
	}

	return safe
}

func part02(name string) int {
	f, err := os.Open(name)
	fail(err)
	defer f.Close()

	fsc := bufio.NewScanner(f)
	safe := 0
	dt := 3

	for fsc.Scan() {
		line := fsc.Text()
		vals := strings.Split(line, " ")

		// First check if it's already safe
		if isSafeSequence(vals, dt) {
			safe++
			continue
		}

		// Try removing each number one at a time
		for i := 0; i < len(vals); i++ {
			// Create a new slice without the current number
			tempVals := make([]string, 0, len(vals)-1)
			tempVals = append(tempVals, vals[:i]...)
			tempVals = append(tempVals, vals[i+1:]...)

			if isSafeSequence(tempVals, dt) {
				safe++
				break // We found a valid solution, no need to check other removals
			}
		}
	}

	return safe
}
func main() {
	fmt.Println(part01("input.txt"))
	fmt.Println(part02("input.txt"))
}
