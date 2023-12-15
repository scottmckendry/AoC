package main

import (
	"fmt"

	"aoc2023/utils"
)

func D14P2() {
	var rockCache = map[int]map[utils.Coordinate]rock{}
	lines := utils.ReadLines("inputs/14.txt")
	rocks := parseRocks(lines)

	cycles := 1000000000
	directions := []rune{'N', 'W', 'S', 'E'}

	patternFound := false
	for i := 0; i < cycles; i++ {
		for _, direction := range directions {
			rocks = rollRocks(rocks, len(lines[0]), len(lines), direction)
		}
		if !patternFound {
			for cacheKey, cacheRocks := range rockCache {
				isMatch := compareRocks(rocks, cacheRocks)
				if isMatch {
					patternFound = true
					cycles = cycles % (i + 1 - cacheKey)
				}
			}
		}

		rockCache[i+1] = map[utils.Coordinate]rock{}
		for coordinate, rock := range rocks {
			rockCache[i+1][coordinate] = rock
		}
	}
	rocks = rockCache[cycles]
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
