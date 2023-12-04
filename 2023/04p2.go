package main

import (
	"fmt"

	"aoc2023/utils"
)

func D04P2() {
	lines := utils.ReadLines("inputs/04.txt")
	cards := []scratchCard{}

	// Parse the cards
	for _, line := range lines {
		currentCard := parseScratchCard(line)
		cards = append(cards, currentCard)
	}

	for i := 0; i < len(cards); i++ {
		// Loop each cards copies
		for j := 0; j < cards[i].cardCopies; j++ {
			copyIndex := 1
			card := cards[i]
			for i := 0; i < card.matchingNumbers; i++ {
				if card.cardId+copyIndex <= len(cards) {
					cards[card.cardId+copyIndex-1].cardCopies++
				}
				copyIndex++
			}
		}
	}

	totalCopies := 0
	for _, card := range cards {
		totalCopies += card.cardCopies
	}
	fmt.Printf("Total copies: %d\n", totalCopies)
}
