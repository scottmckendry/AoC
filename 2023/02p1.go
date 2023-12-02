package main

import (
	"fmt"
	"strconv"
	"strings"

	"aoc2023/utils"
)

type cubeGame struct {
	id           int
	minimumRed   int
	minimumGreen int
	minimumBlue  int
	possible     bool
}

func D02P1() {
	lines := utils.ReadLines("inputs/02.txt")
	games := []cubeGame{}

	idTotal := 0

	for i, line := range lines {
		games = append(games, parseCubeGameLine(line))
		games[i].possible = checkGamePossibility(games[i], 12, 13, 14)

		if games[i].possible {
			idTotal += games[i].id
		}
	}
	fmt.Printf("Total of possible games: %d\n", idTotal)
}

func parseCubeGameLine(line string) cubeGame {
	currentGame := cubeGame{}

	// Parse the game ID
	identityString := strings.Split(line, ":")[0]
	currentGame.id, _ = strconv.Atoi(strings.Split(identityString, " ")[1])

	gameOutcome := line[7:]
	handfulls := strings.Split(gameOutcome, ";")

	// Split the handfulls into colours and counts
	for _, handfull := range handfulls {
		colours := strings.Split(handfull, ",")
		for _, colour := range colours {
			count, _ := strconv.Atoi(strings.Split(colour, " ")[1])
			colourName := strings.Split(colour, " ")[2]

			switch colourName {
			case "red":
				if count > currentGame.minimumRed {
					currentGame.minimumRed = count
				}
			case "green":
				if count > currentGame.minimumGreen {
					currentGame.minimumGreen = count
				}
			case "blue":
				if count > currentGame.minimumBlue {
					currentGame.minimumBlue = count
				}

			}
		}
	}
	return currentGame
}

func checkGamePossibility(game cubeGame, red, green, blue int) bool {
	redPossible := game.minimumRed <= red
	greenPossible := game.minimumGreen <= green
	bluePossible := game.minimumBlue <= blue

	return redPossible && greenPossible && bluePossible
}
