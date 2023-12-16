package main

import (
	"fmt"

	"aoc2023/utils"
)

type tile struct {
	coordinate utils.Coordinate
	char       rune
	energised  bool
}

type lightBeam struct {
	coordinate utils.Coordinate
	direction  utils.Coordinate
}

func D16P1() {
	lines := utils.ReadLines("inputs/16.txt")
	tileMap := parseContraption(lines)

	tileMap = traceBeamPath(
		tileMap,
		lightBeam{
			coordinate: utils.Coordinate{X: 0, Y: 0},
			direction:  utils.Coordinate{X: 1, Y: 0},
		},
		len(lines[0]),
		len(lines),
	)

	// drawContraption(tileMap, len(lines[0]), len(lines), false)
	// fmt.Println()
	// drawContraption(tileMap, len(lines[0]), len(lines), true)

	energisedTiles := 0
	for _, tile := range tileMap {
		if tile.energised {
			energisedTiles++
		}
	}

	fmt.Printf("Total energised tiles: %d\n", energisedTiles)
}

func parseContraption(lines []string) map[utils.Coordinate]tile {
	grid := make(map[utils.Coordinate]tile)

	for y, line := range lines {
		for x, char := range line {
			grid[utils.Coordinate{X: x, Y: y}] = tile{
				coordinate: utils.Coordinate{X: x, Y: y},
				char:       char,
				energised:  false,
			}
		}
	}

	return grid
}

func traceBeamPath(
	grid map[utils.Coordinate]tile,
	start lightBeam,
	maxX int,
	maxY int,
) map[utils.Coordinate]tile {
	visited := make(map[lightBeam]bool)
	queue := []lightBeam{start}

	for len(queue) > 0 {
		current := queue[0]

		if current.coordinate.X < 0 || current.coordinate.X >= maxX || current.coordinate.Y < 0 ||
			current.coordinate.Y >= maxY {
			queue = queue[1:]
			continue
		}

		if visited[current] {
			queue = queue[1:]
			continue
		}

		gridValue := grid[current.coordinate]
		gridValue.energised = true
		grid[current.coordinate] = gridValue

		switch grid[current.coordinate].char {
		case '.':
			queue = append(queue, lightBeam{
				coordinate: utils.Coordinate{
					X: current.coordinate.X + current.direction.X,
					Y: current.coordinate.Y + current.direction.Y,
				},
				direction: utils.Coordinate{
					X: current.direction.X,
					Y: current.direction.Y,
				},
			})
		case '/':
			newBeam := lightBeam{
				coordinate: utils.Coordinate{
					X: current.coordinate.X,
					Y: current.coordinate.Y,
				},
				direction: utils.Coordinate{},
			}

			if current.direction.X == 1 {
				newBeam.coordinate.Y -= 1
				newBeam.direction.Y = -1
			} else if current.direction.X == -1 {
				newBeam.coordinate.Y += 1
				newBeam.direction.Y = 1
			} else if current.direction.Y == 1 {
				newBeam.coordinate.X -= 1
				newBeam.direction.X = -1
			} else if current.direction.Y == -1 {
				newBeam.coordinate.X += 1
				newBeam.direction.X = 1
			}

			queue = append(queue, newBeam)
		case '\\':
			newBeam := lightBeam{
				coordinate: utils.Coordinate{
					X: current.coordinate.X,
					Y: current.coordinate.Y,
				},
				direction: utils.Coordinate{},
			}

			if current.direction.X == 1 {
				newBeam.coordinate.Y += 1
				newBeam.direction.Y = 1
			} else if current.direction.X == -1 {
				newBeam.coordinate.Y -= 1
				newBeam.direction.Y = -1
			} else if current.direction.Y == 1 {
				newBeam.coordinate.X += 1
				newBeam.direction.X = 1
			} else if current.direction.Y == -1 {
				newBeam.coordinate.X -= 1
				newBeam.direction.X = -1
			}

			queue = append(queue, newBeam)
		case '-':
			if current.direction.X == 1 || current.direction.X == -1 {
				queue = append(queue, lightBeam{
					coordinate: utils.Coordinate{
						X: current.coordinate.X + current.direction.X,
						Y: current.coordinate.Y + current.direction.Y,
					},
					direction: utils.Coordinate{
						X: current.direction.X,
						Y: current.direction.Y,
					},
				})
			} else {
				// Split the beam into two
				queue = append(queue, lightBeam{
					coordinate: utils.Coordinate{
						X: current.coordinate.X + 1,
						Y: current.coordinate.Y,
					},
					direction: utils.Coordinate{
						X: 1,
						Y: 0,
					},
				})
				queue = append(queue, lightBeam{
					coordinate: utils.Coordinate{
						X: current.coordinate.X - 1,
						Y: current.coordinate.Y,
					},
					direction: utils.Coordinate{
						X: -1,
						Y: 0,
					},
				})
			}
		case '|':
			if current.direction.Y == 1 || current.direction.Y == -1 {
				queue = append(queue, lightBeam{
					coordinate: utils.Coordinate{
						X: current.coordinate.X + current.direction.X,
						Y: current.coordinate.Y + current.direction.Y,
					},
					direction: utils.Coordinate{
						X: current.direction.X,
						Y: current.direction.Y,
					},
				})
			} else {
				// Split the beam into two
				queue = append(queue, lightBeam{
					coordinate: utils.Coordinate{
						X: current.coordinate.X,
						Y: current.coordinate.Y + 1,
					},
					direction: utils.Coordinate{
						X: 0,
						Y: 1,
					},
				})
				queue = append(queue, lightBeam{
					coordinate: utils.Coordinate{
						X: current.coordinate.X,
						Y: current.coordinate.Y - 1,
					},
					direction: utils.Coordinate{
						X: 0,
						Y: -1,
					},
				})
			}
		}
		queue = queue[1:]
		visited[current] = true
	}
	return grid
}

func drawContraption(grid map[utils.Coordinate]tile, maxX int, maxY int, energised bool) {
	for y := 0; y < maxY; y++ {
		for x := 0; x < maxX; x++ {
			if energised {
				if grid[utils.Coordinate{X: x, Y: y}].energised == energised {
					fmt.Print("#")
				} else {
					fmt.Printf(".")
				}
			}
			if !energised {
				fmt.Printf("%c", grid[utils.Coordinate{X: x, Y: y}].char)
			}
		}
		fmt.Println()
	}
}
