package main

import (
	"fmt"

	"aoc2023/utils"
)

func D07P2() {
	lines := utils.ReadLines("./inputs/07.txt")
	cards := []cardHand{}

	for _, line := range lines {
		cards = append(cards, parseCardHand(line, true))
	}

	cards = rankCardHands(cards, true)

	totalWinnings := 0
	for i := len(cards) - 1; i >= 0; i-- {
		totalWinnings += cards[i].bid * (i + 1)
	}

	fmt.Printf("Total winnings: %d\n", totalWinnings)
}
