package main

import (
	"fmt"
	"strconv"

	"aoc2023/utils"
)

type cardHand struct {
	score int
	bid   int
	cards []int
}

func D07P1() {
	lines := utils.ReadLines("./inputs/07.txt")
	cards := []cardHand{}

	for _, line := range lines {
		cards = append(cards, parseCardHand(line, false))
	}

	cards = rankCardHands(cards, false)

	totalWinnings := 0
	for i, card := range cards {
		totalWinnings += card.bid * (i + 1)
	}

	fmt.Printf("Total winnings: %d\n", totalWinnings)
}

func parseCardHand(line string, partTwo bool) cardHand {
	nonIntegerCards := map[rune]int{
		'A': 14,
		'K': 13,
		'Q': 12,
		'J': 11,
		'T': 10,
	}

	if partTwo {
		nonIntegerCards['J'] = 1
	}

	cardHand := cardHand{}
	cardHand.bid, _ = strconv.Atoi(line[6:])

	for _, card := range line[:5] {
		if card >= '0' && card <= '9' {
			cardHand.cards = append(cardHand.cards, int(card-'0'))
		} else {
			cardHand.cards = append(cardHand.cards, nonIntegerCards[card])
		}
	}

	return cardHand
}

func rankCardHands(cards []cardHand, partTwo bool) []cardHand {
	for i, card := range cards {
		cards[i].score = scoreCardHand(card, partTwo)
	}

	// Sort by score, then by cards in the hand
	for i := 0; i < len(cards); i++ {
		for j := i + 1; j < len(cards); j++ {
			if cards[i].score == cards[j].score {
				for k := 0; k < len(cards[i].cards); k++ {
					if cards[i].cards[k] > cards[j].cards[k] {
						cards[i], cards[j] = cards[j], cards[i]
						break
					}

					if cards[i].cards[k] < cards[j].cards[k] {
						break
					}
				}
			}
			if cards[i].score > cards[j].score {
				cards[i], cards[j] = cards[j], cards[i]
			}
		}
	}

	return cards
}

func scoreCardHand(card cardHand, partTwo bool) int {
	cardMatches := map[int]int{}

	for _, card := range card.cards {
		cardMatches[card]++
	}

	if partTwo {
		jacksToUse := cardMatches[1]
		if jacksToUse > 0 && jacksToUse < 5 {
			cardMatches[1] = 0

			bestMatch := cardMatches[1]
			for card, count := range cardMatches {
				if count > cardMatches[bestMatch] {
					bestMatch = card
				}
			}
			cardMatches[bestMatch] += jacksToUse
		}
	}

	totalScore := 0
	for _, count := range cardMatches {
		switch count {
		case 5:
			totalScore += 10
		case 4:
			totalScore += 8
		case 3:
			totalScore += 5
		case 2:
			totalScore += 2
		}
	}

	return totalScore
}
