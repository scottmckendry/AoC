package main

import (
	"fmt"
	"math"
	"strconv"

	"aoc2023/utils"
)

type boatRace struct {
	time           int
	distanceRecord int
}

func D06P1() {
	lines := utils.ReadLines("inputs/06.txt")

	boatRaces := parseBoatRaces(lines)
	totalWins := 1
	for _, boatRace := range boatRaces {
		possibleWinningScenarios := findBoatRaceWins(boatRace)
		totalWins *= possibleWinningScenarios
	}

	fmt.Printf("Product of possible winning scenarios: %d\n", totalWins)
}

func parseBoatRaces(lines []string) []boatRace {
	boatRaces := []boatRace{}
	timeDigitString := ""
	currentBoatRace := boatRace{}

	// Parse times
	for _, timeDigit := range lines[0] {
		if timeDigit >= '0' && timeDigit <= '9' {
			timeDigitString += string(timeDigit)
		} else if timeDigit == ' ' && timeDigitString != "" {
			currentBoatRace.time, _ = strconv.Atoi(timeDigitString)
			boatRaces = append(boatRaces, currentBoatRace)
			timeDigitString = ""
			currentBoatRace = boatRace{}
		}
	}

	// Append the last time
	currentBoatRace.time, _ = strconv.Atoi(timeDigitString)
	boatRaces = append(boatRaces, currentBoatRace)

	distanceDigitString := ""
	boatRaceIndex := 0

	// Parse distances
	for _, distanceDigit := range lines[1] {
		if distanceDigit >= '0' && distanceDigit <= '9' {
			distanceDigitString += string(distanceDigit)
		} else if distanceDigit == ' ' && distanceDigitString != "" {
			boatRaces[boatRaceIndex].distanceRecord, _ = strconv.Atoi(distanceDigitString)
			distanceDigitString = ""

			if boatRaceIndex < len(boatRaces)-1 {
				boatRaceIndex++
				currentBoatRace = boatRaces[boatRaceIndex]
			}
		}
	}

	// Append the last distance
	boatRaces[boatRaceIndex].distanceRecord, _ = strconv.Atoi(distanceDigitString)

	return boatRaces
}

func findBoatRaceWins(boatRace boatRace) int {
	t := boatRace.time
	d := boatRace.distanceRecord

	// Get the minimum and maximum hold times to improve upon d (distanceRecord)
	t1 := (t - int(math.Sqrt(float64(t*t-4*d)))) / 2
	t2 := (t + int(math.Sqrt(float64(t*t-4*d)))) / 2

	// the difference between the two represents ALL the possible hold times that result in a win
	return t2 - t1 + 1
}
