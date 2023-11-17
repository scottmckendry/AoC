package main

import (
	"fmt"

	"aoc2022/utils"
)

type tree struct {
	height            int
	visible           bool
	scenicScore       int
	northernNeighbour *tree
	southernNeighbour *tree
	easternNeighbour  *tree
	westernNeighbour  *tree
}

func D08P1() {
	visibleTrees := 0

	rows := utils.ReadLines("./inputs/08.txt")
	forest := make([][]tree, len(rows))

	columnTallestTrees := make([]int, len(rows[0]))

	for i, row := range rows {
		forest[i] = make([]tree, len(row))

		rowTallestTree := 0
		for j, char := range row {
			currentTree := tree{height: int(char - '0' + 1), visible: false}

			if currentTree.height > rowTallestTree {
				rowTallestTree = currentTree.height
				if !currentTree.visible {
					currentTree.visible = true
					visibleTrees++
				}
			}

			if currentTree.height > columnTallestTrees[j] {
				columnTallestTrees[j] = currentTree.height
				if !currentTree.visible {
					currentTree.visible = true
					visibleTrees++
				}
			}
			forest[i][j] = currentTree
		}
	}

	// Reset columnTallestTrees
	columnTallestTrees = make([]int, len(rows[0]))

	// Reverse seach through forest to find trees that are visible from the bottom & right
	for i := len(forest) - 1; i >= 0; i-- {

		rowTallestTree := 0
		for j := len(forest[i]) - 1; j >= 0; j-- {
			currentTree := forest[i][j]

			if currentTree.height > rowTallestTree {
				rowTallestTree = currentTree.height
				if !currentTree.visible {
					currentTree.visible = true
					visibleTrees++
				}
			}

			if currentTree.height > columnTallestTrees[j] {
				columnTallestTrees[j] = currentTree.height
				if !currentTree.visible {
					currentTree.visible = true
					visibleTrees++
				}
			}
			forest[i][j] = currentTree
		}
	}

	fmt.Printf("Number of visible trees: %d\n", visibleTrees)
}
