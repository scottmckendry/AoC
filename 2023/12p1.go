package main

import (
	"fmt"
	"strconv"
	"strings"

	"aoc2023/utils"
)

type springRow struct {
	validPermutations []int
	springs           []rune
	permutationsCount int
}

func D12P1() {
	lines := utils.ReadLines("inputs/12.txt")
	springRows := parseSpringRows(lines)

	for i := 0; i < len(springRows); i++ {
		springRows[i].permutationsCount = calculatePermutations(
			springRows[i].springs,
			springRows[i].validPermutations,
			0,
		)
	}

	permutationTotal := 0
	for _, springRow := range springRows {
		permutationTotal += springRow.permutationsCount
	}

	fmt.Printf("There are %d permutations\n", permutationTotal)
}

func parseSpringRows(lines []string) []springRow {
	springRows := make([]springRow, len(lines))
	for i, line := range lines {
		springRows[i] = parseSpringRow(line)
	}
	return springRows
}

func parseSpringRow(line string) springRow {
	springRow := springRow{}
	springsString := strings.Split(line, " ")[0]
	for _, char := range springsString {
		springRow.springs = append(springRow.springs, char)
	}

	validPermutationString := strings.Split(line, " ")[1]
	validPermutations := strings.Split(validPermutationString, ",")

	for _, permutation := range validPermutations {
		permutationInt, _ := strconv.Atoi(permutation)
		springRow.validPermutations = append(springRow.validPermutations, permutationInt)
	}
	return springRow
}

func calculatePermutations(springs []rune, validPermutations []int, start int) int {
	for i := start; i < len(springs); i++ {
		if springs[i] == '?' {
			springs[i] = '#'
			permutationsCount := calculatePermutations(springs, validPermutations, i+1)
			springs[i] = '.'
			permutationsCount += calculatePermutations(springs, validPermutations, i+1)
			springs[i] = '?'
			return permutationsCount
		}
	}
	if isValidPermutation(springs, validPermutations) {
		return 1
	}
	return 0
}

func isValidPermutation(springs []rune, validPermutations []int) bool {
	permutationIndex := 0
	for i := 0; i < len(springs); i++ {
		if springs[i] == '#' {
			springStart := i
			for i < len(springs) && springs[i] == '#' {
				i++
			}
			if permutationIndex < len(validPermutations) &&
				i-springStart != validPermutations[permutationIndex] {
				return false
			} else {
				permutationIndex++
			}
		}
	}
	return permutationIndex == len(validPermutations)
}
