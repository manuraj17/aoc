package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"unicode"
)

func fail(err error) {
	if err != nil {
		panic(err)
	}
}

func is3Digit(n int) bool {
	return n >= 0 && n < 1000
}

func isMul(s string) bool {
	return s == "mul"
}

type Expr struct {
	a int
	b int
}

func newExpr(a, b int) *Expr {
	return &Expr{a: a, b: b}
}

func (e *Expr) Calc() int {
	if !is3Digit(e.a) || !is3Digit(e.b) {
		return 0
	}
	return e.a * e.b
}

type ExScanner struct {
	inp  string
	ch   byte
	s    string
	curr int
	next int
}

func NewExScanner(inp string) *ExScanner {
	return &ExScanner{
		inp:  inp,
		ch:   0,
		curr: -1,
		next: -1,
		s:    "",
	}
}

func (e *ExScanner) Next() bool {
	e.curr++
	e.next = e.curr + 1

	if e.curr >= len(e.inp) {
		e.curr = -1
		e.next = -1
		e.inp = "0"
		return false
	}

	e.ch = e.inp[e.curr]
	e.s = string(e.ch)

	return true
}

func (e *ExScanner) Current() byte {
	return e.ch
}

func (e *ExScanner) Peek() byte {
	return e.inp[e.next]
}

func ParseMul(sc *ExScanner) *Expr {
	if sc.Next(); sc.Current() != 'u' {
		return nil
	}

	if sc.Next(); sc.Current() != 'l' {
		return nil
	}

	if sc.Next(); sc.Current() != '(' {
		return nil
	}

	sc.Next()
	// Check if non number
	if !unicode.IsDigit(rune(sc.ch)) {
		return nil
	}

	var xa []byte
	for unicode.IsDigit(rune(sc.ch)) {
		xa = append(xa, sc.ch)
		sc.Next()
	}

	var ex Expr

	a, err := strconv.Atoi(string(xa))
	if err != nil {
		return nil
	}
	ex.a = a

	// We already encountered a character above
	// Check if it's comma
	if sc.Current() != ',' {
		return nil
	}

	// Move one step further
	sc.Next()
	// Check if non number
	if !unicode.IsDigit(rune(sc.ch)) {
		return nil
	}

	var xb []byte
	for unicode.IsDigit(rune(sc.ch)) {
		xb = append(xb, sc.ch)
		sc.Next()
	}

	b, err := strconv.Atoi(string(xb))
	if err != nil {
		return nil
	}
	ex.b = b

	// We already encountered the next char
	// Check if it's closing bracket
	if sc.Current() != ')' {
		return nil
	}

	return &ex
}

type Flag struct {
	val bool
}

func ParseFlag(sc *ExScanner) *Flag {
	if sc.Next(); sc.Current() != 'o' {
		return nil
	}

	// Two branches are possible next,
	// either do complete or don't
	if sc.Next(); sc.Current() == '(' {
		// Chance that it's a do
		sc.Next()
		if sc.Current() == ')' {
			return &Flag{val: true}
		} else {
			// It is not a do, it's nothing
			return nil
		}
	}

	// No bracket found, hence it could possibly be a "don't" branch
	if sc.Current() == 'n' {
		if sc.Next(); sc.Current() != '\'' {
			return nil
		}

		if sc.Next(); sc.Current() != 't' {
			return nil
		}

		if sc.Next(); sc.Current() != '(' {
			return nil
		}

		if sc.Next(); sc.Current() != ')' {
			return nil
		}

		return &Flag{val: false}
	}

	// Neither of the branches
	return nil
}

func part01(name string) int {
	f, err := os.Open(name)
	fail(err)
	defer f.Close()

	// using scanner
	fsc := bufio.NewScanner(f)
	fsc.Split(bufio.ScanLines)

	var result int

	var exprs []*Expr

	for fsc.Scan() {
		line := fsc.Text()
		sc := NewExScanner(line)
		for sc.Next() {
			if sc.Current() == 'm' {
				ex := ParseMul(sc)
				if ex != nil {
					exprs = append(exprs, ex)
				}
			}
		}
	}

	for _, e := range exprs {
		result = result + e.Calc()
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

	var result int

	var exprs []*Expr
	flag := true

	for fsc.Scan() {
		line := fsc.Text()
		sc := NewExScanner(line)
		for sc.Next() {
			if sc.Current() == 'd' {
				f := ParseFlag(sc)
				if f != nil {
					flag = f.val
				}
			}

			if sc.Current() == 'm' {
				ex := ParseMul(sc)
				if ex != nil {
					if flag {
						exprs = append(exprs, ex)
					}
				}
			}
		}
	}

	for _, e := range exprs {
		result = result + e.Calc()
	}

	return result
}

func main() {
	// 168539636
	fmt.Println(part01("inp1.txt"))
	// 97529391
	fmt.Println(part02("inp1.txt"))
}
