package main

import (
	"fmt"
	"strings"

	"aoc/utils"
)

func D05P1() {
	lines := utils.ReadLines("./inputs/05.txt")

	type move struct {
		count int
		from  int
		to    int
	}

	totalStacks := (len(lines[0]) + 1) / 4

	var moves []move
	var stacks [][]byte

	for i := 0; i < totalStacks; i++ {
		stacks = append(stacks, []byte{})
	}

	for i := len(lines) - 1; i >= 0; i-- {
		currentLine := lines[i]

		// Skip empty lines and stack indexes
		if currentLine == "" {
			continue
		}
		if currentLine[1] == '1' {
			continue
		}

		// Parse moves
		if strings.Contains(lines[i], "move") {
			var currentMove move
			fmt.Sscanf(
				lines[i],
				"move %d from %d to %d",
				&currentMove.count,
				&currentMove.from,
				&currentMove.to,
			)
			moves = append(moves, currentMove)
			continue
		}

		// Parse crates
		for j := 0; j < totalStacks; j++ {
			crate := currentLine[(j+1)*4-3]
			if crate != ' ' {
				stacks[j] = append(stacks[j], crate)
			}
		}
	}

	// Loop through moves (in reverse order)
	for i := len(moves) - 1; i >= 0; i-- {
		currentMove := moves[i]

		for i := 0; i < currentMove.count; i++ {
			// Pop crate from stack
			crate := stacks[currentMove.from-1][len(stacks[currentMove.from-1])-1]
			stacks[currentMove.from-1] = stacks[currentMove.from-1][:len(stacks[currentMove.from-1])-1]

			// Push crate to stack
			stacks[currentMove.to-1] = append(stacks[currentMove.to-1], crate)
		}
	}

	// Get top crates
	topCrates := []byte{}
	for i := 0; i < totalStacks; i++ {
		topCrates = append(topCrates, stacks[i][len(stacks[i])-1])
	}

	fmt.Println(string(topCrates))
}
