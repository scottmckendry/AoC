package main

import (
	"fmt"
	"strconv"

	"aoc2022/utils"
)

type position struct {
	x int
	y int
}

func D09P1() {
	lines := utils.ReadLines("./inputs/09.txt")
	head := position{0, 0}
	tail := position{0, 0}
	tailVisited := make(map[position]bool)

	for _, line := range lines {
		moves, _ := strconv.Atoi(line[2:])

		for moves > 0 {
			switch line[0] {
			case 'U':
				head.y++
			case 'D':
				head.y--
			case 'L':
				head.x--
			case 'R':
				head.x++
			}
			moves--
			tail = moveTail(tail, head)
			tailVisited[tail] = true
		}
	}

	fmt.Printf("Tail visited %d unique positions\n", len(tailVisited))
}

func moveTail(tail position, head position) (newTail position) {
	newTail = tail
	delta := position{head.x - tail.x, head.y - tail.y}

	switch delta {
	case
		position{-1, 2},
		position{-2, 1},
		position{-2, 2},
		position{0, 2},
		position{1, 2},
		position{2, 1},
		position{2, 2}:
		newTail.y++
	}

	switch delta {
	case
		position{-1, -2},
		position{-2, -1},
		position{-2, -2},
		position{0, -2},
		position{1, -2},
		position{2, -1},
		position{2, -2}:
		newTail.y--
	}

	switch delta {
	case
		position{-1, -2},
		position{-1, 2},
		position{-2, -0},
		position{-2, -1},
		position{-2, -2},
		position{-2, 1},
		position{-2, 2}:
		newTail.x--
	}

	switch delta {
	case
		position{1, -2},
		position{2, -1},
		position{2, -2},
		position{2, 0},
		position{2, 1},
		position{2, 2},
		position{1, 2}:
		newTail.x++
	}

	return
}
