package main

import (
	"fmt"
	"math/rand"

	"aoc2022/utils"
)

type node struct {
	x              int
	y              int
	value          int
	letter         string
	visited        bool
	start          bool
	end            bool
	movesFromStart int
}

func D12P1() {
	lines := utils.ReadLines("./inputs/12.txt")
	hills := parseHills(lines)

	path := []*node{}

	currentPosition := findStart(&hills)

	for !currentPosition.end {
		neighbours := findNeighbours(&hills, currentPosition, false)
		for _, n := range neighbours {
			updateMovesFromStart(n, currentPosition)
		}

		currentPosition.visited = true
		path = append(path, currentPosition)
		previousPosition := currentPosition
		currentPosition = selectNextNode(neighbours, currentPosition)

		stepBack := 1
		for currentPosition == previousPosition {
			// fmt.Println("No more valid moves, returning to a visited node")
			currentPosition = path[len(path)-stepBack]
			previousPosition = currentPosition
			currentPosition = selectNextNode(
				findNeighbours(&hills, currentPosition, false),
				currentPosition,
			)
			stepBack++
		}
	}

	fmt.Printf("Moves from start: %d\n", currentPosition.movesFromStart)
}

func parseHills(lines []string) []node {
	var hills []node
	maxIntValue := int(^uint(0) >> 1)
	for y, line := range lines {
		for x, char := range line {
			movesFromStart := maxIntValue
			start, end := false, false

			if string(char) == "S" {
				char = 'a'
				start = true
				movesFromStart = 0
			}
			if string(char) == "E" {
				char = 'z'
				end = true
			}

			hills = append(
				hills,
				node{x, y, int(char), string(char), false, start, end, movesFromStart},
			)
		}
	}
	return hills
}

func findStart(hills *[]node) *node {
	for i, hill := range *hills {
		if hill.start {
			return &(*hills)[i]
		}
	}
	return nil
}

func findNeighbours(hills *[]node, hill *node, visited bool) []*node {
	var neighbours []*node
	for i, n := range *hills {
		if !visited && n.visited {
			continue
		}
		if n.value-hill.value > 1 {
			continue
		}
		if len(neighbours) == 4 {
			break
		}
		if hill.x+1 == n.x && hill.y == n.y {
			neighbours = append(neighbours, &(*hills)[i])
		}

		if hill.x-1 == n.x && hill.y == n.y {
			neighbours = append(neighbours, &(*hills)[i])
		}

		if hill.x == n.x && hill.y+1 == n.y {
			neighbours = append(neighbours, &(*hills)[i])
		}

		if hill.x == n.x && hill.y-1 == n.y {
			neighbours = append(neighbours, &(*hills)[i])
		}
	}
	return neighbours
}

func updateMovesFromStart(hill *node, currentPosition *node) {
	// Hill is too high to climb
	if hill.value > currentPosition.value+1 {
		return
	}

	if hill.movesFromStart > currentPosition.movesFromStart+1 {
		hill.movesFromStart = currentPosition.movesFromStart + 1
	}
}

func selectNextNode(neighbours []*node, currentPosition *node) *node {
	previousPosition := currentPosition

	currentPosition = nil

	// fmt.Printf(
	// 	"Previous position %d, %d, %s\n",
	// 	previousPosition.x,
	// 	previousPosition.y,
	// 	previousPosition.letter,
	// )

	if len(neighbours) == 0 {
		return previousPosition
	}

	for i, n := range neighbours {
		// Can only climb one letter/number at a time - if the value is more than 1 higher than the previous position, it's too high to climb
		if n.value > previousPosition.value+1 {
			continue
		}

		_ = i

		// Ideal move is to step up 1 from the previous position - the end is the highest point on the map
		// if previousPosition.value == n.value-1 {
		// currentPosition = neighbours[i]
		// break
		// }
	}

	if currentPosition == nil {
		currentPosition = neighbours[rand.Intn(len(neighbours))]
	}

	// fmt.Printf(
	// 	"New position %d, %d, %s is %d from start\n",
	// 	currentPosition.x,
	// 	currentPosition.y,
	// 	currentPosition.letter,
	// 	currentPosition.movesFromStart,
	// )

	return currentPosition
}
