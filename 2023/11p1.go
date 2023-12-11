package main

import (
	"fmt"

	"aoc2023/utils"
)

type star struct {
	id          int
	skyPosition utils.Coordinate
}

type starPair struct {
	starA    star
	starB    star
	distance int
}

func D11P1() {
	lines := utils.ReadLines("inputs/11.txt")
	lines = expandUniverse(lines, 1)

	stars := parseStars(lines)
	starPairs := pairStars(stars)

	manhattanSum := 0
	for _, starPair := range starPairs {
		starPair.distance = utils.GetManhattanDistance(
			starPair.starA.skyPosition,
			starPair.starB.skyPosition,
		)

		manhattanSum += starPair.distance
	}

	fmt.Printf("Sum of all star pair distances: %d\n", manhattanSum)
}

func expandUniverse(lines []string, age int) []string {
	expandedRows := []string{}
	for _, line := range lines {
		for i, char := range line {
			if char == '#' {
				break
			}

			if i == len(line)-1 {
				for i := 0; i < age; i++ {
					expandedRows = append(expandedRows, line)
				}
			}
		}
		expandedRows = append(expandedRows, line)
	}

	expandedRowsAndColumns := make([]string, len(expandedRows))
	for i := 0; i < len(expandedRows[0]); i++ {
		appendCol := true
		for j, line := range expandedRows {
			char := line[i]
			expandedRowsAndColumns[j] += string(char)
			if char == '#' {
				appendCol = false
				continue
			}
			if j == len(expandedRows)-1 && appendCol {
				for k := 0; k < len(expandedRows); k++ {
					for i := 0; i < age; i++ {
						expandedRowsAndColumns[k] += "."
					}
				}
			}
		}
	}

	return expandedRowsAndColumns
}

func parseStars(lines []string) []star {
	stars := []star{}
	for y, line := range lines {
		for x, char := range line {
			if char == '#' {
				stars = append(stars, star{
					id: len(stars),
					skyPosition: utils.Coordinate{
						X: x,
						Y: y,
					},
				})
			}
		}
	}

	return stars
}

func pairStars(stars []star) []starPair {
	pairs := []starPair{}
	for i, starA := range stars {
		for j, starB := range stars {
			if i == j {
				continue
			}
			// Prevent duplicate pairs
			if i > j {
				continue
			}
			pairs = append(pairs, starPair{
				starA: starA,
				starB: starB,
			})
		}
	}

	return pairs
}
