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

	rocks = rollRocks(rocks, len(lines[0]), len(lines), 'N')

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

// TODO: Lots of repeated code here, need to come back and refactor
func rollRocks(
	rocks map[utils.Coordinate]rock,
	width int,
	height int,
	direction rune,
) map[utils.Coordinate]rock {
	if direction == 'N' {
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
	} else if direction == 'S' {
		for y := height - 1; y >= 0; y-- {
			for x := 0; x < width; x++ {
				rock, ok := rocks[utils.Coordinate{X: x, Y: y}]
				if !ok || rock.square {
					continue
				}

				yPosition := y + 1
				for yPosition < height {
					_, ok := rocks[utils.Coordinate{X: x, Y: yPosition}]
					if ok {
						newRock := rock
						newRock.position = utils.Coordinate{X: x, Y: yPosition - 1}
						rocks[utils.Coordinate{X: x, Y: yPosition - 1}] = newRock
						if yPosition-1 != y {
							delete(rocks, utils.Coordinate{X: x, Y: y})
						}
						break
					}

					if yPosition == height-1 {
						newRock := rock
						newRock.position = utils.Coordinate{X: x, Y: yPosition}
						rocks[utils.Coordinate{X: x, Y: yPosition}] = newRock
						if yPosition != y {
							delete(rocks, utils.Coordinate{X: x, Y: y})
						}
					}

					yPosition++
				}
			}
		}
	} else if direction == 'E' {
		for x := width - 1; x >= 0; x-- {
			for y := 0; y < height; y++ {
				rock, ok := rocks[utils.Coordinate{X: x, Y: y}]
				if !ok || rock.square {
					continue
				}

				xPosition := x + 1
				for xPosition < width {
					_, ok := rocks[utils.Coordinate{X: xPosition, Y: y}]
					if ok {
						newRock := rock
						newRock.position = utils.Coordinate{X: xPosition - 1, Y: y}
						rocks[utils.Coordinate{X: xPosition - 1, Y: y}] = newRock
						if xPosition-1 != x {
							delete(rocks, utils.Coordinate{X: x, Y: y})
						}
						break
					}

					if xPosition == width-1 {
						newRock := rock
						newRock.position = utils.Coordinate{X: xPosition, Y: y}
						rocks[utils.Coordinate{X: xPosition, Y: y}] = newRock
						if xPosition != x {
							delete(rocks, utils.Coordinate{X: x, Y: y})
						}
					}

					xPosition++
				}
			}
		}
	} else if direction == 'W' {
		for x := 0; x < width; x++ {
			for y := 0; y < height; y++ {
				rock, ok := rocks[utils.Coordinate{X: x, Y: y}]
				if !ok || rock.square {
					continue
				}

				xPosition := x - 1
				for xPosition >= 0 {
					_, ok := rocks[utils.Coordinate{X: xPosition, Y: y}]
					if ok {
						newRock := rock
						newRock.position = utils.Coordinate{X: xPosition + 1, Y: y}
						rocks[utils.Coordinate{X: xPosition + 1, Y: y}] = newRock
						if xPosition+1 != x {
							delete(rocks, utils.Coordinate{X: x, Y: y})
						}
						break
					}

					if xPosition == 0 {
						newRock := rock
						newRock.position = utils.Coordinate{X: xPosition, Y: y}
						rocks[utils.Coordinate{X: xPosition, Y: y}] = newRock
						if xPosition != x {
							delete(rocks, utils.Coordinate{X: x, Y: y})
						}
					}

					xPosition--
				}
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
