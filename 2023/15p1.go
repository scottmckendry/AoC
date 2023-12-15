package main

import (
	"fmt"
	"strings"

	"aoc2023/utils"
)

func D15P1() {
	lines := utils.ReadLines("inputs/15.txt")
	steps := strings.Split(lines[0], ",")

	hashSum := 0
	for _, step := range steps {
		hashSum += getStringHashValue(step)
	}

	fmt.Printf("The sum of all hashed initialisation steps is %d\n", hashSum)
}

func getStringHashValue(step string) int {
	hashValue := 0

	for _, char := range step {
		hashValue += int(char)
		hashValue *= 17
		hashValue %= 256
	}

	return hashValue
}
