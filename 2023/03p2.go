package main

import (
	"fmt"
	"strconv"

	"aoc2023/utils"
)

func D03P2() {
	lines := utils.ReadLines("inputs/03.txt")
	grid := make([][]rune, len(lines))

	engineParts := []enginePart{}

	for i, line := range lines {
		grid[i] = []rune(line)
	}

	currentPart := enginePart{}
	partNumberString := ""
	for i, line := range grid {
		for j, char := range line {
			if char >= '0' && char <= '9' {
				partNumberString += string(char)

				if !currentPart.isPart {
					checkIfPartIsPart(coordinate{j, i}, grid, &currentPart)
				}

			} else if partNumberString != "" {
				currentPart.number, _ = strconv.Atoi(partNumberString)

				engineParts = append(engineParts, currentPart)
				partNumberString = ""
				currentPart = enginePart{}
			}
		}
	}

	// Using a map prevents duplicate gear ratios
	gearRatios := map[coordinate]int{}

	for _, part := range engineParts {
		if part.partIdentifier == '*' {
			// Check if the other half of the gear ratio is in the list
			for _, otherPart := range engineParts {
				if otherPart.partIdentifier == '*' &&
					otherPart.identifierPosition == part.identifierPosition && otherPart.number != part.number {

					// Add the gear ratio to the map
					gearRatios[part.identifierPosition] = part.number * otherPart.number
				}
			}
		}
	}

	totalSumOfGearRatios := 0
	for _, gearRatio := range gearRatios {
		totalSumOfGearRatios += gearRatio
	}

	fmt.Printf("Sum of gear ratios: %d\n", totalSumOfGearRatios)
}
