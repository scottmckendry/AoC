package main

import (
	"fmt"

	"aoc2022/utils"
)

type node struct {
	value          int
	letter         string
	visited        bool
	start          bool
	end            bool
	movesFromStart int
}

type nodeCoordinate struct {
	x int
	y int
}

func D12P1() {
	lines := utils.ReadLines("./inputs/12.txt")
	hills := parseHills(lines)

	queue := []nodeCoordinate{}

	// Append start node to queue
	start := findStart(hills, false)
	value, exists := hills[start]
	if exists {
		value.movesFromStart = 0
	}
	queue = append(queue, start)

	for queue != nil {
		if hills[queue[0]].visited {
			queue = queue[1:]
			continue
		}

		if hills[queue[0]].end {
			fmt.Printf("Reached end in %d moves\n", hills[queue[0]].movesFromStart)
			break
		}

		neighbours := findNeighbours(&hills, queue[0], false)

		for _, n := range neighbours {
			value, exists := hills[n]

			if exists {
				value.movesFromStart = updateMovesFromStart(value, hills[queue[0]])
				hills[n] = value
			}

			queue = append(queue, n)
		}

		value, exists := hills[queue[0]]
		if exists {
			value.visited = true
			hills[queue[0]] = value
		}
		queue = queue[1:]
	}
}

func parseHills(lines []string) map[nodeCoordinate]node {
	hills := map[nodeCoordinate]node{}
	maxIntValue := int(^uint(0) >> 1)
	for y, line := range lines {
		for x, char := range line {
			movesFromStart := maxIntValue
			start, end := false, false

			if string(char) == "S" {
				char = 'a'
				start = true
			}
			if string(char) == "E" {
				char = 'z'
				end = true
			}

			hills[nodeCoordinate{x, y}] = node{
				value:          int(char),
				letter:         string(char),
				visited:        false,
				start:          start,
				end:            end,
				movesFromStart: movesFromStart,
			}
		}
	}

	return hills
}

func findStart(hills map[nodeCoordinate]node, reverse bool) nodeCoordinate {
	for coordinate, hill := range hills {
		if hill.start && !reverse {
			return coordinate
		}
		if hill.end && reverse {
			return coordinate
		}
	}
	return nodeCoordinate{}
}

func findNeighbours(
	hills *map[nodeCoordinate]node,
	coordinate nodeCoordinate,
	reverse bool,
) []nodeCoordinate {
	neighbours := []nodeCoordinate{}
	posibleNeighbours := []nodeCoordinate{
		{coordinate.x + 1, coordinate.y},
		{coordinate.x - 1, coordinate.y},
		{coordinate.x, coordinate.y + 1},
		{coordinate.x, coordinate.y - 1},
	}

	currentHillValue := (*hills)[coordinate].value

	for _, possibleNeighbour := range posibleNeighbours {
		value, exists := (*hills)[possibleNeighbour]
		if exists && value.value-currentHillValue > 1 && !reverse {
			continue
		}

		if exists && currentHillValue-value.value > 1 && reverse {
			continue
		}

		if exists && !value.visited {
			neighbours = append(neighbours, possibleNeighbour)
		}
	}

	return neighbours
}

func updateMovesFromStart(hill node, currentPosition node) int {
	if hill.movesFromStart > currentPosition.movesFromStart+1 {
		return currentPosition.movesFromStart + 1
	}
	return hill.movesFromStart
}
