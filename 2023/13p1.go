package main

import (
	"fmt"

	"aoc2023/utils"
)

func D13P1() {
	lines := utils.ReadLines("inputs/13.txt")
	patterns := [][]string{}
	currentPattern := []string{}
	for _, line := range lines {
		if line == "" {
			patterns = append(patterns, currentPattern)
			currentPattern = []string{}
			continue
		}
		currentPattern = append(currentPattern, line)
	}

	patterns = append(patterns, currentPattern)

	patternScoreSum := 0
	for _, pattern := range patterns {
		patternScoreSum += getPatternScore(pattern, 0)
	}

	fmt.Printf("Total pattern score: %d\n", patternScoreSum)
}

func getPatternScore(pattern []string, answerToIgnore int) int {
	for i := 0; i < len(pattern); i++ {
		if i == 0 {
			continue
		}

		before := i - 1
		after := i

		isMatch := true
		for before >= 0 && after < len(pattern) {
			if pattern[before] == pattern[after] {
				before--
				after++
				continue
			}
			isMatch = false
			break
		}

		if isMatch {
			if i*100 != answerToIgnore {
				return i * 100
			}
		}
	}

	columns := []string{}
	for i := 0; i < len(pattern[0]); i++ {
		column := ""
		for j := 0; j < len(pattern); j++ {
			column += string(pattern[j][i])
		}
		columns = append(columns, column)
	}

	for i := 0; i < len(columns); i++ {
		if i == 0 {
			continue
		}

		before := i - 1
		after := i
		isMatch := true
		for before >= 0 && after < len(columns) {
			if columns[before] == columns[after] {
				before--
				after++
				continue
			}
			isMatch = false
			break
		}

		if isMatch {
			if i != answerToIgnore {
				return i
			}
		}
	}
	return 0
}
