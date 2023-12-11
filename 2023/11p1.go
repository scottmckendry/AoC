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

	stars := parseStars(lines)
	stars = expandUniverse(stars, 2, len(lines[0]), len(lines))

	starPairs := pairStars(stars)
	fmt.Printf("Sum of all star pair distances: %d\n", getSumDistancesBetweenStarPairs(starPairs))
}

func expandUniverse(
	stars []star,
	expansionFactor int,
	originalWidth int,
	originalHeight int,
) []star {
	expandedRows := []star{}
	expandedRows = append(expandedRows, stars...)

	for y := 0; y < originalHeight; y++ {
		starInRow := false
		for _, star := range stars {
			if star.skyPosition.Y == y {
				starInRow = true
				break
			}
		}

		// Update Y coordinate of all stars displaced by expansion
		if !starInRow {
			for i, star := range stars {
				if star.skyPosition.Y > y {
					expandedRows[i].skyPosition.Y += expansionFactor - 1
				}
			}
		}
	}

	// Repeat for columns
	expandedColumns := []star{}
	expandedColumns = append(expandedColumns, expandedRows...)
	for x := 0; x < originalWidth; x++ {
		starInColumn := false
		for _, star := range expandedRows {
			if star.skyPosition.X == x {
				starInColumn = true
				break
			}
		}

		// Update X coordinate of all stars displaced by expansion
		if !starInColumn {
			for i, star := range expandedRows {
				if star.skyPosition.X > x {
					expandedColumns[i].skyPosition.X += expansionFactor - 1
				}
			}
		}
	}

	return expandedColumns
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

func getSumDistancesBetweenStarPairs(starPairs []starPair) int {
	manhattanSum := 0
	for _, starPair := range starPairs {
		starPair.distance = utils.GetManhattanDistance(
			starPair.starA.skyPosition,
			starPair.starB.skyPosition,
		)
		manhattanSum += starPair.distance
	}

	return manhattanSum
}
