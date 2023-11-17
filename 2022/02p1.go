package main

import (
	"fmt"
    "aoc2022/utils"
)

func D02P1() {
	lines := utils.ReadLines("./inputs/02.txt")
	score := 0

	outcomes := make(map[string]int)

	// Losses
	outcomes["A Z"] = 3
	outcomes["B X"] = 1
	outcomes["C Y"] = 2

	// Draws
	outcomes["A X"] = 4
	outcomes["B Y"] = 5
	outcomes["C Z"] = 6

	// Wins
	outcomes["A Y"] = 8
	outcomes["B Z"] = 9
	outcomes["C X"] = 7

	for _, line := range lines {
		score += outcomes[line]
	}

	fmt.Printf("Score: %d\n", score)
}
