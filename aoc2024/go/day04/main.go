package main

import (
	"bufio"
	"fmt"
	"os"
	"strings"
)

func fail(err error) {
	if err != nil {
		panic(err)
	}
}

func nextChar(x string) string {
	switch x {
	case "x":
		return "m"
	case "m":
		return "a"
	case "a":
		return "s"
	case "s":
		return "done"
	default:
		return ""
	}
}

func findXmas(mat [][]rune, i, j, imax, jmax int, c string, direction string) int {
	result := 0

	// Outside matrix boundary
	if i >= imax || j >= jmax || i < 0 || j < 0 {
		return result
	}

	// The current position does not have the value we need
	val := strings.ToLower(string(mat[i][j]))
	if val != c {
		return result
	}

	nextC := nextChar(c)
	// We found "xmas"
	if nextC == "done" {
		return 1
	}

	// Not "xmas"
	if nextC == "" {
		return 0
	}

	// If direction == "" means we are starting
	// Search all positions for the next value
	// If we are in a specific direction we will only continue on that direction
	switch direction {
	case "":
		result = result + findXmas(mat, i+1, j, imax, jmax, nextC, "top")
		result = result + findXmas(mat, i+1, j+1, imax, jmax, nextC, "top-right")
		result = result + findXmas(mat, i, j+1, imax, jmax, nextC, "right")
		result = result + findXmas(mat, i-1, j+1, imax, jmax, nextC, "bottom-right")
		result = result + findXmas(mat, i-1, j, imax, jmax, nextC, "bottom")
		result = result + findXmas(mat, i-1, j-1, imax, jmax, nextC, "bottom-left")
		result = result + findXmas(mat, i, j-1, imax, jmax, nextC, "left")
		result = result + findXmas(mat, i+1, j-1, imax, jmax, nextC, "top-left")
	case "top":
		result += findXmas(mat, i+1, j, imax, jmax, nextC, direction)
	case "top-right":
		result += findXmas(mat, i+1, j+1, imax, jmax, nextC, direction)
	case "right":
		result += findXmas(mat, i, j+1, imax, jmax, nextC, direction)
	case "bottom-right":
		result += findXmas(mat, i-1, j+1, imax, jmax, nextC, direction)
	case "bottom":
		result += findXmas(mat, i-1, j, imax, jmax, nextC, direction)
	case "bottom-left":
		result += findXmas(mat, i-1, j-1, imax, jmax, nextC, direction)
	case "left":
		result += findXmas(mat, i, j-1, imax, jmax, nextC, direction)
	case "top-left":
		result += findXmas(mat, i+1, j-1, imax, jmax, nextC, direction)
	}

	return result
}

func nextCharMas(c string) string {
	switch c {
	case "m":
		return "done"
	case "s":
		return "done"
	default:
		return ""
	}
}

func findMas(mat [][]rune, i, j, imax, jmax int, c string) int {
	result := 0

	// Outside matrix boundary
	if i+1 >= imax || j+1 >= jmax || i-1 < 0 || j-1 < 0 {
		return result
	}

	// The current position does not have the value we need
	val := strings.ToLower(string(mat[i][j]))

	// We don't have the starting char
	if val != c {
		return result
	}

	// TODO: Check for the "X" shape
	// i-1, j-1
	bottom_left := string(mat[i-1][j-1])
	top_right := string(mat[i+1][j+1])
	bottom_right := string(mat[i-1][j+1])
	top_left := string(mat[i+1][j-1])

	if bottom_left == "M" && top_right == "S" || bottom_left == "S" && top_right == "M" {
		// Check other side
		if bottom_right == "M" && top_left == "S" || bottom_right == "S" && top_left == "M" {
			return 1
		}
	}

	return result
}

func part01(name string) int {
	f, err := os.Open(name)
	fail(err)
	defer f.Close()

	// using scanner
	fsc := bufio.NewScanner(f)
	fsc.Split(bufio.ScanLines)

	var mat [][]rune

	for fsc.Scan() {
		line := fsc.Text()
		s := []rune(line)
		mat = append(mat, s)
	}

	imax := len(mat)
	jmax := len(mat[0])

	result := 0
	for i, x := range mat {
		for j := range x {
			result += findXmas(mat, i, j, imax, jmax, "x", "")
		}
	}
	return result
}

func part02(name string) int {
	f, err := os.Open(name)
	fail(err)
	defer f.Close()

	// using scanner
	fsc := bufio.NewScanner(f)
	fsc.Split(bufio.ScanLines)

	var mat [][]rune

	for fsc.Scan() {
		line := fsc.Text()
		s := []rune(line)
		mat = append(mat, s)
	}

	imax := len(mat)
	jmax := len(mat[0])

	result := 0
	for i, x := range mat {
		for j := range x {
			result += findMas(mat, i, j, imax, jmax, "a")
		}
	}
	return result
}

func main() {
	fmt.Println(part01("inp1.txt"))
	fmt.Println(part02("inp1.txt"))
}
