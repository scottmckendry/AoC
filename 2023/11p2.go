package main

import (
	"fmt"

	"aoc2023/utils"
)

func D11P2() {
	lines := utils.ReadLines("inputs/11.txt")

	stars := parseStars(lines)
	stars = expandUniverse(stars, 1000000, len(lines[0]), len(lines))

	starPairs := pairStars(stars)
	fmt.Printf("Sum of all star pair distances: %d\n", getSumDistancesBetweenStarPairs(starPairs))
}
