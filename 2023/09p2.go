package main

import (
	"fmt"

	"aoc2023/utils"
)

func D09P2() {
	lines := utils.ReadLines("./inputs/09.txt")
	oasisHistory := parseOasisHistory(lines)

	previousValueSum := 0
	for _, line := range oasisHistory {
		previousValue := predictNextOasisValue(line, true)
		previousValueSum += previousValue
	}

	fmt.Printf("The sum of predicted previous OASIS values is %d\n", previousValueSum)
}
