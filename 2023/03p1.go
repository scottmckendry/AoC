package main

import (
	"fmt"
	"strconv"

	"aoc2023/utils"
)

type enginePart struct {
	number             int
	isPart             bool
	partIdentifier     rune
	identifierPosition coordinate
}

type coordinate struct {
	x int
	y int
}

func D03P1() {
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

	sumOfParts := 0
	for _, part := range engineParts {
		if part.isPart {
			sumOfParts += part.number
		}
	}

	fmt.Printf("Sum of parts: %d\n", sumOfParts)
}

func checkIfPartIsPart(position coordinate, grid [][]rune, currentPart *enginePart) {
	neighbouringGridPoisitions := []coordinate{
		{position.x + 1, position.y + 1},
		{position.x + 1, position.y - 1},
		{position.x + 1, position.y},
		{position.x - 1, position.y + 1},
		{position.x - 1, position.y - 1},
		{position.x - 1, position.y},
		{position.x, position.y + 1},
		{position.x, position.y - 1},
	}
	for _, neighbour := range neighbouringGridPoisitions {
		//Check if coordinate is in grid
		if neighbour.x < 0 || neighbour.y < 0 || neighbour.x >= len(grid) ||
			neighbour.y >= len(grid[0]) {
			continue
		}

		// Check if the neighbour is a number
		if grid[neighbour.y][neighbour.x] >= '0' && grid[neighbour.y][neighbour.x] <= '9' {
			continue
		}

		// Check if the neighbour is a full stop
		if grid[neighbour.y][neighbour.x] == '.' {
			continue
		}

		currentPart.partIdentifier = grid[neighbour.y][neighbour.x]
		currentPart.identifierPosition = neighbour
		currentPart.isPart = true
		return
	}
}
