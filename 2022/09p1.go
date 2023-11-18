package main

import (
	"fmt"
	"math"
	"strconv"
	"strings"

	"aoc2022/utils"
)

func D09P1() {
	lines := utils.ReadLines("./inputs/09.txt")
	headPositions := []string{"0,0"}
	tailPositions := []string{"0,0"}

	for _, line := range lines {
		currentHeadPositionX, currentHeadPositionY := getCurrentPosition(headPositions)

		moves, _ := strconv.Atoi(line[2:])

		switch line[0] {
		case 'U':
			for i := 0; i < moves; i++ {
				currentHeadPositionY++
				headPositions = append(
					headPositions,
					fmt.Sprintf("%d,%d", currentHeadPositionX, currentHeadPositionY),
				)
				tailPositions = updateTailPosition(headPositions, tailPositions)
			}
		case 'D':
			for i := 0; i < moves; i++ {
				currentHeadPositionY--
				headPositions = append(
					headPositions,
					fmt.Sprintf("%d,%d", currentHeadPositionX, currentHeadPositionY),
				)
				tailPositions = updateTailPosition(headPositions, tailPositions)
			}
		case 'L':
			for i := 0; i < moves; i++ {
				currentHeadPositionX--
				headPositions = append(
					headPositions,
					fmt.Sprintf("%d,%d", currentHeadPositionX, currentHeadPositionY),
				)
				tailPositions = updateTailPosition(headPositions, tailPositions)
			}
		case 'R':
			for i := 0; i < moves; i++ {
				currentHeadPositionX++
				headPositions = append(
					headPositions,
					fmt.Sprintf("%d,%d", currentHeadPositionX, currentHeadPositionY),
				)
				tailPositions = updateTailPosition(headPositions, tailPositions)
			}
		}
	}

	fmt.Printf("Tail visited %d unique positions\n", getUniquePositions(tailPositions))
}

func getCurrentPosition(positions []string) (int, int) {
	currentPosition := positions[len(positions)-1]
	currentPositionX, _ := strconv.Atoi(strings.Split(currentPosition, ",")[0])
	currentPositionY, _ := strconv.Atoi(strings.Split(currentPosition, ",")[1])

	return currentPositionX, currentPositionY

}

func getPreviousPosition(positions []string) (int, int) {
	if len(positions) >= 2 {
		previousPosition := positions[len(positions)-2]
		previousPositionX, _ := strconv.Atoi(strings.Split(previousPosition, ",")[0])
		previousPositionY, _ := strconv.Atoi(strings.Split(previousPosition, ",")[1])

		return previousPositionX, previousPositionY
	}

	return 0, 0
}

func updateTailPosition(headPositions []string, tailPositions []string) []string {
	currentHeadPositionX, currentHeadPositionY := getCurrentPosition(headPositions)
	currentTailPositionX, currentTailPositionY := getCurrentPosition(tailPositions)
	previousHeadPositionX, previousHeadPositionY := getPreviousPosition(headPositions)

	headDeltaX := int(math.Abs(float64(currentHeadPositionX - currentTailPositionX)))
	headDeltaY := int(math.Abs(float64(currentHeadPositionY - currentTailPositionY)))

	// No change to tail position if the head and tail are in the same position
	if currentHeadPositionX == currentTailPositionX &&
		currentHeadPositionY == currentTailPositionY {
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
			fmt.Sprintf("%d,%d", previousHeadPositionX, previousHeadPositionY),
		)
	}
	return tailPositions
}

func getUniquePositions(positions []string) int {
	uniquePositions := make(map[string]bool)
	for _, position := range positions {
		uniquePositions[position] = true
	}
	return len(uniquePositions)
}
