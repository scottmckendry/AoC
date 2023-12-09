package main

import (
	"fmt"

	"aoc2023/utils"
)

func D08P2() {
	input := utils.ReadLines("inputs/08.txt")
	moveList, locations := parseWasteland(input)

	currentLocations := findStartingWaselandLocations(locations)
	paths := []int{}

	for _, location := range currentLocations {
		shortestPath := findWasteLandPathDistance(location, locations, moveList)
		paths = append(paths, shortestPath)
	}

	lcm := utils.FindLowestCommonMultiple(paths)
	fmt.Printf("Found wasteland end after %d moves\n", lcm)
}

func findStartingWaselandLocations(locations map[string]wasteLandLocation) []wasteLandLocation {
	startingLocations := []wasteLandLocation{}
	for _, location := range locations {
		if location.locationId[2] == 'A' {
			startingLocations = append(startingLocations, location)
		}
	}

	return startingLocations
}

func findWasteLandPathDistance(
	startingLocation wasteLandLocation,
	locations map[string]wasteLandLocation,
	moveList []rune,
) int {
	currentLocation := startingLocation
	moveIndex := 0

	for currentLocation.locationId[2] != 'Z' {
		currentMove := moveList[moveIndex%len(moveList)]
		if currentMove == 'L' {
			currentLocation = locations[currentLocation.moveLeft]
		}
		if currentMove == 'R' {
			currentLocation = locations[currentLocation.moveRight]
		}
		moveIndex++
	}

	return moveIndex
}
