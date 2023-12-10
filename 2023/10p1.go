package main

import (
	"fmt"

	"aoc2023/utils"
)

type pipe struct {
	connectionType    rune
	connectsTo        []coordinate
	distanceFromStart int
	visited           bool
}

func D10P1() {
	lines := utils.ReadLines("inputs/10.txt")
	pipeMap, start := parsePipes(lines)

	if startingPipe, ok := pipeMap[start]; ok {
		startingPipe.distanceFromStart = 0
		pipeMap[start] = startingPipe
	}

	travelThroughPipes(pipeMap, start)

	maxDistance := 0
	for _, value := range pipeMap {
		if value.distanceFromStart > maxDistance {
			maxDistance = value.distanceFromStart
		}
	}

	fmt.Printf("Max distance: %d\n", maxDistance)
}

func parsePipes(lines []string) (map[coordinate]pipe, coordinate) {
	pipeMap := make(map[coordinate]pipe)
	start := coordinate{}

	for y, line := range lines {
		for x, char := range line {
			switch char {
			case '|', '-', 'S', 'F', '7', 'J', 'L':
				pipeMap[coordinate{x, y}] = pipe{
					connectionType: char,
					connectsTo:     findConnections(coordinate{x, y}, char),
					visited:        false,
				}
				if char == 'S' {
					start = coordinate{x, y}
				}
			}
		}
	}

	return pipeMap, start
}

func findConnections(c coordinate, char rune) []coordinate {
	switch char {
	case '|', 'S':
		return []coordinate{
			{c.x, c.y - 1},
			{c.x, c.y + 1},
		}
	case '-':
		return []coordinate{
			{c.x - 1, c.y},
			{c.x + 1, c.y},
		}
	case 'F':
		return []coordinate{
			{c.x, c.y + 1},
			{c.x + 1, c.y},
		}
	case '7':
		return []coordinate{
			{c.x, c.y + 1},
			{c.x - 1, c.y},
		}
	case 'J':
		return []coordinate{
			{c.x, c.y - 1},
			{c.x - 1, c.y},
		}
	case 'L':
		return []coordinate{
			{c.x, c.y - 1},
			{c.x + 1, c.y},
		}
	}

	return []coordinate{}
}

func travelThroughPipes(pipeMap map[coordinate]pipe, start coordinate) {
	currentPipe := pipeMap[start]
	currentPipe.visited = true
	pipeMap[start] = currentPipe

	queue := []pipe{currentPipe}

	for len(queue) > 0 {
		currentPipe = queue[0]
		queue = queue[1:]

		for _, connection := range currentPipe.connectsTo {
			if pipe, ok := pipeMap[connection]; ok {
				if !pipe.visited {
					pipe.distanceFromStart = currentPipe.distanceFromStart + 1
					pipe.visited = true
					pipeMap[connection] = pipe
					queue = append(queue, pipe)
				}
			}
		}
	}
}
