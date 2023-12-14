package main

import (
	"fmt"

	"aoc2023/utils"
)

func D13P2() {
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
		oldPatternScore := getPatternScore(pattern, 0)
		patternScore := oldPatternScore

		x, y := 0, 0
		for patternScore == oldPatternScore {
			pattern, x, y = getNextPattern(pattern, x, y)
			patternScore = getPatternScore(pattern, oldPatternScore)
			if patternScore == 0 {
				patternScore = oldPatternScore
			}
		}
		patternScoreSum += patternScore
	}

	fmt.Printf("Total pattern score: %d\n", patternScoreSum)
}

func getNextPattern(pattern []string, x, y int) ([]string, int, int) {
	previosCharX, previousCharY := x, y
	if x == len(pattern[0]) {
		x = 0
		y++
	}

	if x == 0 && y > 0 {
		previosCharX = len(pattern[0]) - 1
		previousCharY = y - 1
	} else if x > 0 {
		previosCharX = x - 1
	}

	if y == len(pattern) {
		return pattern, x, y
	}

	newPattern := make([]string, len(pattern))
	if pattern[previousCharY][previosCharX] == '.' {
		// Replace with a #
		copy(newPattern, pattern)
		newPattern[previousCharY] = newPattern[previousCharY][:previosCharX] + "#" + newPattern[previousCharY][previosCharX+1:]
	} else if pattern[previousCharY][previosCharX] == '#' {
		// Replace with a .
		copy(newPattern, pattern)
		newPattern[previousCharY] = newPattern[previousCharY][:previosCharX] + "." + newPattern[previousCharY][previosCharX+1:]
	}

	if pattern[y][x] == '.' {
		// Replace with a #
		newPattern[y] = newPattern[y][:x] + "#" + newPattern[y][x+1:]
		return newPattern, x + 1, y
	} else if pattern[y][x] == '#' {
		// Replace with a .
		newPattern[y] = newPattern[y][:x] + "." + newPattern[y][x+1:]
		return newPattern, x + 1, y
	}

	return pattern, x + 1, y
}
