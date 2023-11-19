package main

import (
	"fmt"
	"strconv"

	"aoc2022/utils"
)

func D09P2() {
	lines := utils.ReadLines("./inputs/09.txt")
	tailVisited := make(map[position]bool)
	rope := make([]position, 10)

	for _, line := range lines {
		moves, _ := strconv.Atoi(line[2:])

		for moves > 0 {
			switch line[0] {
			case 'U':
				rope[0].y++
			case 'D':
				rope[0].y--
			case 'L':
				rope[0].x--
			case 'R':
				rope[0].x++
			}

			for i := range rope[:len(rope)-1] {
				rope[i+1] = moveTail(rope[i+1], rope[i])
			}
			moves--
			tailVisited[rope[9]] = true
		}
	}

	fmt.Printf("Tail visited %d unique positions\n", len(tailVisited))
}
