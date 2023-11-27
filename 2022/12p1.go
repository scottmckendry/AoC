package main

import (
	"fmt"

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

	queue := []*node{}

	// Append start node to queue
	start := findStart(&hills)
	queue = append(queue, start)

	for queue != nil {
		if queue[0].visited {
			queue = queue[1:]
			continue
		}

		if queue[0].end {
			fmt.Printf("Reached end in %d moves\n", queue[0].movesFromStart)
			break
		}

		neighbours := findNeighbours(&hills, queue[0])

		for _, n := range neighbours {
			updateMovesFromStart(n, queue[0])
			queue = append(queue, n)
		}

		queue[0].visited = true
		queue = queue[1:]
	}
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

func findNeighbours(hills *[]node, hill *node) []*node {
	var neighbours []*node
	for i, n := range *hills {
		if n.visited {
			continue
		} else if n.value-hill.value > 1 {
			continue
		}
		if len(neighbours) == 3 {
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
	if hill.movesFromStart > currentPosition.movesFromStart+1 {
		hill.movesFromStart = currentPosition.movesFromStart + 1
	}
}
