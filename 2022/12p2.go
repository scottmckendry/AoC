package main

import (
	"fmt"

	"aoc2022/utils"
)

func D12P2() {
	lines := utils.ReadLines("./inputs/12.txt")
	hills := parseHills(lines)

	queue := []nodeCoordinate{}

	end := findStart(hills, true)
	value, exists := hills[end]
	if exists {
		value.movesFromStart = 0
	}
	hills[end] = value
	queue = append(queue, end)

	bestRoute := int(^uint(0) >> 1)

	for len(queue) > 0 {
		if hills[queue[0]].visited {
			queue = queue[1:]
			continue
		}

		if hills[queue[0]].letter == "a" {
			if hills[queue[0]].movesFromStart < bestRoute {
				bestRoute = hills[queue[0]].movesFromStart
			}
		}

		neighbours := findNeighbours(&hills, queue[0], true)

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

	fmt.Printf("Best route: %d\n", bestRoute)
}
