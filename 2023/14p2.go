package main

import (
	"fmt"

	"aoc2023/utils"
)

func D14P2() {
	lines := utils.ReadLines("inputs/14.txt")
	rocks := parseRocks(lines)

	cycles := 1
	directions := []rune{'N', 'W', 'S', 'E'}

	cycles = 160
	for i := 0; i < cycles; i++ {
		for _, direction := range directions {
			rocks = rollRocks(rocks, len(lines[0]), len(lines), direction)
		}
	}

	totalLoad := calculateRockLoad(rocks, len(lines))
	fmt.Println("Total load:", totalLoad)
}

func compareRocks(rocks1 map[utils.Coordinate]rock, rocks2 map[utils.Coordinate]rock) bool {
	for coordinate, rock1 := range rocks1 {
		rock2, ok := rocks2[coordinate]
		if !ok {
			return false
		}
		if rock1.square != rock2.square {
			return false
		}
	}
	return true
}
