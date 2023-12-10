package main

import (
	"fmt"

	"aoc2023/utils"
)

func D10P2() {
	lines := utils.ReadLines("inputs/10.txt")
	pipeMap, start := parsePipes(lines)

	if startingPipe, ok := pipeMap[start]; ok {
		startingPipe.distanceFromStart = 0
		pipeMap[start] = startingPipe
	}

	travelThroughPipes(pipeMap, start)

	pipesInsideLoop := findPipesInsideLoop(pipeMap, len(lines[0])-1, len(lines)-1)

	fmt.Printf("Pipes inside loop: %d\n", pipesInsideLoop)
}

func findPipesInsideLoop(pipeMap map[coordinate]pipe, maxX int, maxY int) int {
	pipesInsideLoop := 0

	for y := 0; y <= maxY; y++ {
		verticalPipeCount := 0
		countingInnerChars := false
		previousCorner := ' '
		for x := 0; x <= maxX; x++ {
			if pipe, ok := pipeMap[coordinate{x, y}]; ok {
				if (pipe.connectionType == '|' || pipe.connectionType == 'S') && pipe.visited {
					countingInnerChars = !countingInnerChars
					verticalPipeCount++
					continue
				}

				if pipe.connectionType == 'F' && pipe.visited {
					previousCorner = pipe.connectionType
					continue
				}

				if pipe.connectionType == 'L' && pipe.visited {
					previousCorner = pipe.connectionType
					continue
				}

				if pipe.connectionType == 'J' && pipe.visited && previousCorner == 'F' {
					countingInnerChars = !countingInnerChars
					previousCorner = pipe.connectionType
					verticalPipeCount++
					continue
				}

				if pipe.connectionType == '7' && pipe.visited && previousCorner == 'L' {
					countingInnerChars = !countingInnerChars
					previousCorner = pipe.connectionType
					verticalPipeCount++
					continue
				}

				switch pipe.connectionType {
				case 'F', 'L', 'J', '7':
					if pipe.visited {
						previousCorner = pipe.connectionType
						continue
					}
				}

				if countingInnerChars && !pipe.visited && verticalPipeCount%2 == 1 {
					pipesInsideLoop++
					continue
				}
				continue
			}

			if countingInnerChars && verticalPipeCount%2 == 1 {
				pipesInsideLoop++
			}
		}
	}

	return pipesInsideLoop
}
