package main

import (
	"fmt"

	"aoc2022/utils"
)

func D08P2() {
	rows := utils.ReadLines("./inputs/08.txt")
	forest := make([][]tree, len(rows))

	bestScenicScore := 0

	for i, row := range rows {
		forest[i] = make([]tree, len(row))
		for j, char := range row {
			forest[i][j] = tree{height: int(char - '0')}
		}
	}

	for i, row := range forest {
		for j, currentTree := range row {
			// Set northern neighbour
			if i == 0 {
				currentTree.northernNeighbour = nil
			} else {
				currentTree.northernNeighbour = &forest[i-1][j]
			}

			// Set southern neighbour
			if i == len(forest)-1 {
				currentTree.southernNeighbour = nil
			} else {
				currentTree.southernNeighbour = &forest[i+1][j]
			}

			// Set eastern neighbour
			if j == len(row)-1 {
				currentTree.easternNeighbour = nil
			} else {
				currentTree.easternNeighbour = &forest[i][j+1]
			}

			// Set western neighbour
			if j == 0 {
				currentTree.westernNeighbour = nil
			} else {
				currentTree.westernNeighbour = &forest[i][j-1]
			}

			forest[i][j] = currentTree
		}
	}

	// Calculate Scenic Score
	for i, row := range forest {
		for j, currentTree := range row {
			// If any neighbour is nil, set scenic score to 0
			if currentTree.northernNeighbour == nil || currentTree.southernNeighbour == nil ||
				currentTree.easternNeighbour == nil ||
				currentTree.westernNeighbour == nil {
				currentTree.scenicScore = 0
				continue
			} else {
				distances := make([]int, 4)
				for k, direction := range []string{"north", "south", "east", "west"} {
					distances[k] = getDistanceToTallerTree(currentTree, currentTree.height, direction)
					if distances[k] == 0 {
						distances[k] = 1
					}
				}
				// Multiply distance to taller tree in each direction
				currentTree.scenicScore = distances[0] * distances[1] * distances[2] * distances[3]

				if currentTree.scenicScore > bestScenicScore {
					bestScenicScore = currentTree.scenicScore
				}

				forest[i][j] = currentTree
			}
		}
	}

	fmt.Printf("Best Scenic Score: %v\n", bestScenicScore)
}

func getDistanceToTallerTree(currentTree tree, height int, direction string) int {
	distance := 0

	if direction == "north" && currentTree.northernNeighbour != nil {
		distance = 1
		if currentTree.northernNeighbour.height < height {
			distance = distance + getDistanceToTallerTree(
				*currentTree.northernNeighbour,
				height,
				"north",
			)
		}
	} else if direction == "south" && currentTree.southernNeighbour != nil {
		distance = 1
		if currentTree.southernNeighbour.height < height {
			distance = distance + getDistanceToTallerTree(*currentTree.southernNeighbour, height, "south")
		}
	} else if direction == "east" && currentTree.easternNeighbour != nil {
		distance = 1
		if currentTree.easternNeighbour.height < height {
			distance = distance + getDistanceToTallerTree(*currentTree.easternNeighbour, height, "east")
		}
	} else if direction == "west" && currentTree.westernNeighbour != nil {
		distance = 1
		if currentTree.westernNeighbour.height < height {
			distance = distance + getDistanceToTallerTree(*currentTree.westernNeighbour, height, "west")
		}
	}

	return distance
}
