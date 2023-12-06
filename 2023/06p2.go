package main

import (
	"fmt"
	"strconv"

	"aoc2023/utils"
)

func D06P2() {
	lines := utils.ReadLines("inputs/06.txt")

	boatRace := parseBoatRacesPartTwo(lines)

	possibleWinningScenarios := findBoatRaceWins(boatRace)

	fmt.Printf("Possible winning scenarios: %d\n", possibleWinningScenarios)
}

func parseBoatRacesPartTwo(lines []string) boatRace {

	race := boatRace{}
	timeDigitString := ""
	for _, timeDigit := range lines[0] {
		if timeDigit >= '0' && timeDigit <= '9' {
			timeDigitString += string(timeDigit)
		}
	}

	race.time, _ = strconv.Atoi(timeDigitString)

	distanceDigitString := ""
	for _, distanceDigit := range lines[1] {
		if distanceDigit >= '0' && distanceDigit <= '9' {
			distanceDigitString += string(distanceDigit)
		}
	}

	race.distanceRecord, _ = strconv.Atoi(distanceDigitString)
	return race
}
