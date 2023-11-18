package main

import (
	"fmt"
	"math"
	"strconv"

	"aoc2022/utils"
)

type position struct {
	x int
	y int
}

func D09P1() {
	lines := utils.ReadLines("./inputs/09.txt")
	headPositions := []position{
		{0, 0},
	}
	tailPositions := []position{
		{0, 0},
	}

	for _, line := range lines {
		currentHeadPositionX := headPositions[len(headPositions)-1].x
		currentHeadPositionY := headPositions[len(headPositions)-1].y

		moves, _ := strconv.Atoi(line[2:])

		switch line[0] {
		case 'U':
			for i := 0; i < moves; i++ {
				currentHeadPositionY++
				headPositions = append(
					headPositions,
					position{currentHeadPositionX, currentHeadPositionY},
				)
				tailPositions = updateTailPosition(headPositions, tailPositions)
			}
		case 'D':
			for i := 0; i < moves; i++ {
				currentHeadPositionY--
				headPositions = append(
					headPositions,
					position{currentHeadPositionX, currentHeadPositionY},
				)
				tailPositions = updateTailPosition(headPositions, tailPositions)
			}
		case 'L':
			for i := 0; i < moves; i++ {
				currentHeadPositionX--
				headPositions = append(
					headPositions,
					position{currentHeadPositionX, currentHeadPositionY},
				)
				tailPositions = updateTailPosition(headPositions, tailPositions)
			}
		case 'R':
			for i := 0; i < moves; i++ {
				currentHeadPositionX++
				headPositions = append(
					headPositions,
					position{currentHeadPositionX, currentHeadPositionY},
				)
				tailPositions = updateTailPosition(headPositions, tailPositions)
			}
		}
	}

	fmt.Printf("Tail visited %d unique positions\n", getUniquePositions(tailPositions))
}

func updateTailPosition(headPositions []position, tailPositions []position) []position {
	currentHeadPosition := headPositions[len(headPositions)-1]
	currentTailPosition := tailPositions[len(tailPositions)-1]

	previousHeadPosition := headPositions[len(headPositions)-1]
	if len(headPositions) >= 2 {
		previousHeadPosition = headPositions[len(headPositions)-2]
	}

	headDeltaX := int(math.Abs(float64(currentHeadPosition.x - currentTailPosition.x)))
	headDeltaY := int(math.Abs(float64(currentHeadPosition.y - currentTailPosition.y)))

	// No change to tail position if the head and tail are in the same position
	if currentHeadPosition == currentTailPosition {
		return tailPositions
	}

	// If delta X and Y both == 1, then the head and tail are diagonal to each other and still touching (no change to tail position)
	if headDeltaX == 1 && headDeltaY == 1 {
		return tailPositions
	}

	// If the distance between the head and tail is greater than 1 in any direction
	if headDeltaX > 1 || headDeltaY > 1 {
		tailPositions = append(
			tailPositions,
			previousHeadPosition,
		)
	}
	return tailPositions
}

func getUniquePositions(positions []position) int {
	uniquePositions := make(map[position]bool)
	for _, pos := range positions {
		uniquePositions[pos] = true
	}
	return len(uniquePositions)
}
