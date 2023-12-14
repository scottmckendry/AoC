package main

import (
	"fmt"

	"aoc2023/utils"
)

type rock struct {
	position utils.Coordinate
	square   bool
}

func D14P1() {
	lines := utils.ReadLines("inputs/14.txt")
	rocks := parseRocks(lines)

	// fmt.Println("Before:")
	// drawRocks(rocks, len(lines[0]), len(lines))
	// fmt.Println()

	rocks = rollRocks(rocks, len(lines[0]), len(lines))
	// fmt.Println("After:")
	// drawRocks(rocks, len(lines[0]), len(lines))

	totalLoad := calculateRockLoad(rocks, len(lines))
	fmt.Println("Total load:", totalLoad)
}

func parseRocks(lines []string) map[utils.Coordinate]rock {
	rocks := map[utils.Coordinate]rock{}
	for y, line := range lines {
		for x, char := range line {
			if char == '#' {
				rocks[utils.Coordinate{X: x, Y: y}] = rock{utils.Coordinate{X: x, Y: y}, true}
			}
			if char == 'O' {
				rocks[utils.Coordinate{X: x, Y: y}] = rock{utils.Coordinate{X: x, Y: y}, false}
			}
		}
	}
	return rocks
}

func drawRocks(rocks map[utils.Coordinate]rock, width int, height int) {
	for y := 0; y < height; y++ {
		for x := 0; x < width; x++ {
			rock, ok := rocks[utils.Coordinate{X: x, Y: y}]
			if ok {
				if rock.square {
					fmt.Print("#")
				} else {
					fmt.Print("O")
				}
			} else {
				fmt.Print(".")
			}
		}
		fmt.Println()
	}
}

func rollRocks(rocks map[utils.Coordinate]rock, width int, height int) map[utils.Coordinate]rock {
	for y := 0; y < height; y++ {
		for x := 0; x < width; x++ {
			rock, ok := rocks[utils.Coordinate{X: x, Y: y}]
			if !ok || rock.square {
				continue
			}

			yPosition := y - 1
			for yPosition >= 0 {
				_, ok := rocks[utils.Coordinate{X: x, Y: yPosition}]
				if ok {
					newRock := rock
					newRock.position = utils.Coordinate{X: x, Y: yPosition + 1}
					rocks[utils.Coordinate{X: x, Y: yPosition + 1}] = newRock
					if yPosition+1 != y {
						delete(rocks, utils.Coordinate{X: x, Y: y})
					}
					break
				}

				if yPosition == 0 {
					newRock := rock
					newRock.position = utils.Coordinate{X: x, Y: yPosition}
					rocks[utils.Coordinate{X: x, Y: yPosition}] = newRock
					if yPosition != y {
						delete(rocks, utils.Coordinate{X: x, Y: y})
					}
				}

				yPosition--
			}
		}
	}
	return rocks
}

func calculateRockLoad(rocks map[utils.Coordinate]rock, rowMultiplier int) int {
	totalLoad := 0
	currentRow := 0
	for rowMultiplier > 0 {
		for _, rock := range rocks {
			if rock.position.Y == currentRow && !rock.square {
				totalLoad += rowMultiplier
			}
		}
		rowMultiplier--
		currentRow++
	}
	return totalLoad
}
