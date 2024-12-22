package main

import (
	"bufio"
	"fmt"
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

// type Node struct {
// 	v      int
// 	after  []*Node
// 	before []*Node
// }

// Checks if the current node is after the passed node
// 3 | 4
// 4.IsAfter(3) == true
// func (n *Node) IsAfter(node *Node) bool {
// 	for _, e := range node.after {
// 		if n.v == val {
// 			return true
// 		}
// 	}

// 	return false
// }

// Checks if the current node is before the passed node
// 3 | 4
// 3.IsBefore(4) == true
// func (n *Node) IsBefore(node *Node) bool {
// 	for _, e := range node.before {
// 		if e.v == val {
// 			return true
// 		}
// 	}

// 	return false
// }

// func (n *Node) AddBefore(node *Node) {
// 	n.before = append(n.before, node)
// }

// func (n *Node) AddAfter(node *Node) {
// 	n.after = append(n.after, node)
// }

// type Index struct {
// 	c []*Node
// }

// func NewIndex() *Index {
// 	return &Index{c: make([]*Node, 0)}
// }

// func (i *Index) Exists(val int) bool {
// 	for _, i := range i.c {
// 		if i.v == val {
// 			return true
// 		}
// 	}

// 	return false
// }

// func (i *Index) Add(val int) *Node {
// 	n := Node{v: val}
// 	i.c = append(i.c, &n)

// 	return &n
// }

// func (i *Index) Get(val int) *Node {
// 	for _, i := range i.c {
// 		if i.v == val {
// 			return i
// 		}
// 	}

// 	return nil
// }

// func CheckBefore(x string, arr []string, idx *Index) bool {
// 	for _, a := range arr {
// 		ia, err := strconv.Atoi(a)
// 		if err != nil {
// 			panic(err)
// 		}
// 		ix, err := strconv.Atoi(x)
// 		if err != nil {
// 			panic(err)
// 		}
// 		node := idx.Get(ix)
// 		target := idx.Get(ia)

// 		if !node.IsBefore(target) {
// 			return false
// 		}
// 	}
// 	return true
// }

// func CheckAfter(x string, arr []string, idx *Index) bool {
// 	for _, a := range arr {
// 		ia, err := strconv.Atoi(a)
// 		if err != nil {
// 			panic(err)
// 		}
// 		ix, err := strconv.Atoi(x)
// 		if err != nil {
// 			panic(err)
// 		}
// 		node := idx.Get(ix)
// 		target := idx.Get(ia)

// 		if !node.IsAfter(target) {
// 			return false
// 		}
// 	}
// 	return true
// }

// func ParseRules(rule string, idx *Index) int {
// 	r := strings.Split(rule, ",")
// 	for i, n := range r {
// 		before := false
// 		after := false

// 		if i == 0 {
// 			// check only is before
// 			after = true
// 			rest := r[i+1:]
// 			before = CheckBefore(n, rest, idx)

// 			if !after || !before {
// 				return 0
// 			}

// 		}

// 		if i == len(r)-1 {
// 			// check only is after
// 			before = true
// 			rest := r[0 : i-1]
// 			after = CheckAfter(n, rest, idx)
// 			if !after || !before {
// 				return 0
// 			}

// 		}

// 		previous := r[0 : i-1]
// 		forwards := r[i+1:]

// 		// check both
// 		if !CheckAfter(n, previous, idx) || !CheckBefore(n, forwards, idx) {
// 			return 0
// 		}
// 	}
// 	return 1
// }

type Rule struct {
	prev  string
	after string
}

type Rules []Rule

func check(a string, b string, rules Rules) bool {
	for _, r := range rules {
		if r.prev == a && r.after == b {
			return true
		}
	}

	return false
}

func fixEls(els []string, rules Rules) []string {
	sort.Slice(els, func(i, j int) bool {
		return check(els[i], els[j], rules)
	})
	return els
}

func checkUpdate(update string, rules Rules) int {
	els := strings.Split(update, ",")

	mid := 0
	valid := false
	preValid := false
	forValid := false

	// Check if the elements are according to the rules
	for i, e := range els {
		if i == 0 {
			preValid = true
		} else {
			for j := 0; j < i; j++ {
				preValid = check(els[j], e, rules)
				if !preValid {
					break
				}
			}
		}

		if !preValid {
			break
		}

		for j := i + 1; j < len(els); j++ {
			forValid = check(e, els[j], rules)
			if !forValid {
				break
			}
		}

		if !preValid {
			break
		}

	}

	if preValid && forValid {
		valid = true
	}

	if valid {
		mid = getMid(els)
	}

	return mid
}

func fixUpdate(update string, rules Rules) int {
	els := strings.Split(update, ",")

	mid := 0
	valid := false
	preValid := false
	forValid := false

	// Check if the elements are according to the rules
	for i, e := range els {
		if i == 0 {
			preValid = true
		} else {
			for j := 0; j < i; j++ {
				preValid = check(els[j], e, rules)
				// fmt.Printf("%s %s %t\n", e, els[j], preValid)
				if !preValid {
					break
				}
			}
		}

		if !preValid {
			break
		}

		for j := i + 1; j < len(els); j++ {
			forValid = check(e, els[j], rules)
			// fmt.Printf("%s %s %t\n", e, els[j], forValid)
			if !forValid {
				break
			}
		}

		if !preValid {
			break
		}

	}

	if preValid && forValid {
		valid = true
	}
	// fmt.Printf("%s valid: %t\n", update, valid)

	if !valid {
		els = fixEls(els, rules)
		mid = getMid(els)
	}

	return mid
}

func getMid(els []string) int {
	mid := 0
	if len(els)%2 == 0 {
		x := els[(len(els)/2)+1]
		y, err := strconv.Atoi(x)
		if err != nil {
			panic(err)
		}
		mid = y
	} else {
		x := els[len(els)/2]
		y, err := strconv.Atoi(x)
		if err != nil {
			panic(err)
		}
		mid = y
	}

	return mid
}

func part01(name string) int {
	f, err := os.Open(name)
	fail(err)
	defer f.Close()

	// using scanner
	fsc := bufio.NewScanner(f)
	fsc.Split(bufio.ScanLines)

	update := false
	result := 0
	var rules Rules
	var mid []int
	for fsc.Scan() {
		line := fsc.Text()

		if line == "\n" || line == "" {
			update = true
			continue
		}

		if update {
			mid = append(mid, checkUpdate(line, rules))
		} else {
			els := strings.Split(line, "|")
			rule := Rule{prev: els[0], after: els[1]}
			rules = append(rules, rule)
		}

	}

	for _, m := range mid {
		result += m
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

	update := false
	result := 0
	var rules Rules
	var mid []int
	for fsc.Scan() {
		line := fsc.Text()

		if line == "\n" || line == "" {
			update = true
			continue
		}

		if update {
			mid = append(mid, fixUpdate(line, rules))
		} else {
			els := strings.Split(line, "|")
			rule := Rule{prev: els[0], after: els[1]}
			rules = append(rules, rule)
		}

	}

	for _, m := range mid {
		result += m
	}

	return result
}

func main() {
	fmt.Println(part01("inp.txt"))
	fmt.Println(part02("inp.txt"))
}
