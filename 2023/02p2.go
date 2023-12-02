package main

import (
	"fmt"

	"aoc2023/utils"
)

func D02P2() {
	lines := utils.ReadLines("inputs/02.txt")
	games := []cubeGame{}

	powerLevelSum := 0

	for i, line := range lines {
		games = append(games, parseCubeGameLine(line))
		gamePowerLevel := games[i].minimumRed * games[i].minimumGreen * games[i].minimumBlue
		powerLevelSum += gamePowerLevel
	}
	fmt.Printf("Total Power Level: %d\n", powerLevelSum)
}
