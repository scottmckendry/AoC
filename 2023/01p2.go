package main

import (
	"fmt"
	"strconv"
	"strings"

	"aoc2023/utils"
)

func D01P2() {
	lines := utils.ReadLines("inputs/01.txt")

	calibrationTotal := 0

	for _, line := range lines {
		numbers := []rune{}
		for i, char := range line {
			// Check for digit
			if char >= '0' && char <= '9' {
				numbers = append(numbers, char)
				continue
			}

			// Check for a string representation of a number
			if i+3 <= len(line) {
				numberString := line[i:]
				if i < len(line)-5 {
					numberString = line[i : i+5]
				}
				stringAsDigit := rune(checkStringForNumber(numberString)[0])

				if stringAsDigit != '0' {
					numbers = append(numbers, stringAsDigit)
				}
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

func checkStringForNumber(stringToCheck string) string {
	numberStrings := []string{
		"one",
		"two",
		"three",
		"four",
		"five",
		"six",
		"seven",
		"eight",
		"nine",
	}

	// check if the second character is a digit
	if stringToCheck[1] >= '0' && stringToCheck[1] <= '9' {
		return "0"
	}

	for i, numberString := range numberStrings {
		if strings.Contains(stringToCheck, numberString) {
			return strconv.Itoa(i + 1)
		}
	}
	return "0"
}
