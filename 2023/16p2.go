package main

import (
	"fmt"

	"aoc2023/utils"
)

func D16P2() {
	lines := utils.ReadLines("inputs/16.txt")
	tileMap := parseContraption(lines)

	startPoints := []lightBeam{}

	for y, line := range lines {
		startPoints = append(startPoints, lightBeam{
			coordinate: utils.Coordinate{X: 0, Y: y},
			direction:  utils.Coordinate{X: 1, Y: 0},
		})
		startPoints = append(startPoints, lightBeam{
			coordinate: utils.Coordinate{X: len(line) - 1, Y: y},
			direction:  utils.Coordinate{X: -1, Y: 0},
		})
	}

	for x := 0; x < len(lines[0]); x++ {
		startPoints = append(startPoints, lightBeam{
			coordinate: utils.Coordinate{X: x, Y: 0},
			direction:  utils.Coordinate{X: 0, Y: 1},
		})
		startPoints = append(startPoints, lightBeam{
			coordinate: utils.Coordinate{X: x, Y: len(lines) - 1},
			direction:  utils.Coordinate{X: 0, Y: -1},
		})
	}

	mostEnergisedTiles := 0
	for _, startPoint := range startPoints {
		for _, tile := range tileMap {
			tile.energised = false
			tileMap[tile.coordinate] = tile
		}

		tileMap = traceBeamPath(
			tileMap,
			startPoint,
			len(lines[0]),
			len(lines),
		)

		energisedTiles := 0
		for _, tile := range tileMap {
			if tile.energised {
				energisedTiles++
			}
		}

		if energisedTiles > mostEnergisedTiles {
			mostEnergisedTiles = energisedTiles
		}
	}

	fmt.Printf("Total energised tiles: %d\n", mostEnergisedTiles)
}
