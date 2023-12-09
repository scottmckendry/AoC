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
		previousValue := predictPreviousOasisValue(line)
		previousValueSum += previousValue
	}

	fmt.Printf("The sum of predicted previous OASIS values is %d\n", previousValueSum)
}

func predictPreviousOasisValue(history []int) int {
	historyDiffs := []int{}
	for i, value := range history {
		if i == 0 {
			continue
		}
		historyDiffs = append(historyDiffs, value-history[i-1])
	}

	historyTotal := 0
	for _, value := range historyDiffs {
		historyTotal += value
	}

	if historyTotal == 0 {
		return history[0]
	}

	return history[0] - predictPreviousOasisValue(historyDiffs)
}
