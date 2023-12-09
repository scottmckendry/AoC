package main

import (
	"fmt"
	"strconv"
	"strings"

	"aoc2023/utils"
)

func D09P1() {
	lines := utils.ReadLines("./inputs/09.txt")
	oasisHistory := parseOasisHistory(lines)

	nextValueSum := 0
	for _, line := range oasisHistory {
		nextValue := predictNextOasisValue(line)
		nextValueSum += nextValue
	}

	fmt.Printf("The sum of predicted next OASIS values is %d\n", nextValueSum)
}

func parseOasisHistory(lines []string) [][]int {
	oasisHistory := [][]int{}
	for _, line := range lines {
		lineHistory := []int{}
		historyValues := strings.Split(line, " ")
		for _, historyValue := range historyValues {
			value, _ := strconv.Atoi(historyValue)
			lineHistory = append(lineHistory, value)
		}
		oasisHistory = append(oasisHistory, lineHistory)
	}
	return oasisHistory
}

func predictNextOasisValue(history []int) int {
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
		return history[len(history)-1]
	}

	return predictNextOasisValue(historyDiffs) + history[len(history)-1]
}
