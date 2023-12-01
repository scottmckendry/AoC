package main

import (
	"fmt"
	"strconv"

	"aoc2023/utils"
)

func D01P1() {
	lines := utils.ReadLines("inputs/01.txt")

	calibrationTotal := 0
	for _, line := range lines {
		numbers := []rune{}
		for _, char := range line {
			if char >= '0' && char <= '9' {
				numbers = append(numbers, char)
			}
		}

		combinedNumString := fmt.Sprintf(
			"%s%s",
			string(numbers[0]),
			string(numbers[len(numbers)-1]),
		)

		intVal, err := strconv.Atoi(combinedNumString)
		if err != nil {
			fmt.Println(err)
		}
		calibrationTotal += intVal
	}

	fmt.Println("Sum of all calibration values:", calibrationTotal)
}
