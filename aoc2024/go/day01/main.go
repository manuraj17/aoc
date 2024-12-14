package main

import (
	"bufio"
	"fmt"
	"math"
	"os"
	"sort"
	"strconv"
	"strings"
)

func fail(err error) {
	if err != nil {
		panic(err)
	}
}

func part01(name string) int {
	f, err := os.Open(name)
	fail(err)
	defer f.Close()

	// using scanner
	fsc := bufio.NewScanner(f)
	fsc.Split(bufio.ScanLines)

	var first []int
	var second []int

	// var lines []string
	for fsc.Scan() {
		line := fsc.Text()
		parts := strings.Split(line, " ")
		a, err := strconv.Atoi(parts[0])
		fail(err)
		b, err := strconv.Atoi(parts[len(parts)-1])
		fail(err)

		first = append(first, a)
		second = append(second, b)
	}

	sort.Ints(first[:])
	sort.Ints(second[:])

	sum := 0
	for i := 0; i < len(first); i++ {
		x := (second[i] - first[i])
		if x < 0 {
			x = int(math.Abs(float64(x)))
		}
		sum += x

	}

	return sum
}

func part02(name string) int {
	f, err := os.Open(name)
	fail(err)
	defer f.Close()

	// using scanner
	fsc := bufio.NewScanner(f)
	fsc.Split(bufio.ScanLines)

	var first []int
	var second []int

	// var lines []string
	for fsc.Scan() {
		line := fsc.Text()
		parts := strings.Split(line, " ")
		a, err := strconv.Atoi(parts[0])
		fail(err)
		b, err := strconv.Atoi(parts[len(parts)-1])
		fail(err)

		first = append(first, a)
		second = append(second, b)
	}

	sort.Ints(first[:])
	sort.Ints(second[:])

	sim := 0
	curr := 0

	i := 0
	j := 0
	for i < len(first) {
		if first[i] == second[j] {
			curr += 1
			j++
		} else {
			j++

			if j >= len(first) {
				x := first[i] * curr
				sim += x
				i++
				curr = 0
				j = 0
			}
		}
	}

	return sim
}

func main() {
	fmt.Println(part01("inp1.txt"))
	fmt.Println(part02("inp1.txt"))
}
