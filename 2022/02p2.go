package main

import (
	"fmt"

	"aoc/utils"
)

func D02P2() {
	lines := utils.ReadLines("./inputs/02.txt")
	score := 0

	outcomes := make(map[string]int)

	// Losses
	outcomes["A X"] = 3
	outcomes["B X"] = 1
	outcomes["C X"] = 2

	// Draws
	outcomes["A Y"] = 4
	outcomes["B Y"] = 5
	outcomes["C Y"] = 6

	// Wins
	outcomes["A Z"] = 8
	outcomes["B Z"] = 9
	outcomes["C Z"] = 7

	for _, line := range lines {
		score += outcomes[line]
	}

	fmt.Printf("Score: %d\n", score)
}
