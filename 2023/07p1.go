package main

import (
	"fmt"
	"math/rand"
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

	// Quick sort the cards by score
	cards = quickSortCardHands(cards)

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

	matchScore := 0
	for _, count := range cardMatches {
		switch count {
		case 5:
			matchScore += 10
		case 4:
			matchScore += 8
		case 3:
			matchScore += 5
		case 2:
			matchScore += 2
		}
	}

	// Score the cards in the hand individually
	totalScoreString := strconv.Itoa(matchScore)
	for _, card := range card.cards {
		if card > 9 {
			totalScoreString += strconv.Itoa(card)
		} else {
			totalScoreString += "0" + strconv.Itoa(card)
		}
	}

	totalScore, _ := strconv.Atoi(totalScoreString)

	return totalScore
}

func quickSortCardHands(hands []cardHand) []cardHand {
	if len(hands) < 2 {
		return hands
	}

	left, right := 0, len(hands)-1
	pivot := rand.Int() % len(hands)

	hands[pivot], hands[right] = hands[right], hands[pivot]

	for i := range hands {
		if hands[i].score < hands[right].score {
			hands[left], hands[i] = hands[i], hands[left]
			left++
		}
	}

	hands[left], hands[right] = hands[right], hands[left]

	quickSortCardHands(hands[:left])
	quickSortCardHands(hands[left+1:])

	return hands
}
