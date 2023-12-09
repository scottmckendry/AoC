package main

import (
	"fmt"

	"aoc2023/utils"
)

type wasteLandLocation struct {
	locationId string
	moveLeft   string
	moveRight  string
}

func D08P1() {
	input := utils.ReadLines("inputs/08.txt")
	moveList, locations := parseWasteland(input)

	currentLocation := locations["AAA"]
	moveIndex := 0

	for currentLocation.locationId != "ZZZ" {
		currentMove := moveList[moveIndex%len(moveList)]
		if currentMove == 'L' {
			currentLocation = locations[currentLocation.moveLeft]
		}
		if currentMove == 'R' {
			currentLocation = locations[currentLocation.moveRight]
		}
		moveIndex++
	}

	fmt.Printf("Found ZZZ at %d moves\n", moveIndex)
}

func parseWasteland(input []string) ([]rune, map[string]wasteLandLocation) {
	moveList := []rune{}

	for _, move := range input[0] {
		moveList = append(moveList, move)
	}

	locations := map[string]wasteLandLocation{}
	for _, location := range input[2:] {
		parsedLocation := wasteLandLocation{
			locationId: string(location[0:3]),
			moveLeft:   string(location[7:10]),
			moveRight:  string(location[12:15]),
		}

		locations[parsedLocation.locationId] = parsedLocation
	}

	return moveList, locations
}
