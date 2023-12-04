package main

import (
	"fmt"
	"strings"

	"aoc2023/utils"
)

type scratchCard struct {
	cardId          int
	matchingNumbers int
	cardPoints      int
	cardCopies      int
}

func D04P1() {
	lines := utils.ReadLines("inputs/04.txt")
	cards := []scratchCard{}
	for _, line := range lines {
		currentCard := parseScratchCard(line)

		for i := 0; i < currentCard.matchingNumbers; i++ {
			if currentCard.cardPoints == 0 {
				currentCard.cardPoints = 1
				continue
			}
			// Double the points if the number is a winning number
			currentCard.cardPoints *= 2
		}

		cards = append(cards, currentCard)
	}

	// Sum the points of all the cards
	totalPoints := 0
	for _, card := range cards {
		totalPoints += card.cardPoints
	}
	fmt.Printf("Total points: %d\n", totalPoints)
}

func parseScratchCard(line string) scratchCard {
	card := scratchCard{}
	fmt.Sscanf(line, "Card %d:", &card.cardId)

	// Break the line into the winning numbers and the card numbers
	cardNumbersString := strings.Split(line, ":")[1]
	winningNumbersString := strings.Split(cardNumbersString, "|")[0]
	actualNumbersString := strings.Split(cardNumbersString, "|")[1]

	numberOfWinningNumbers := len(winningNumbersString) / 3
	numberOfActualNumbers := len(actualNumbersString) / 3
	winningNumbers := []int{}
	actualNumbers := []int{}

	// Parse the winning numbers
	for i := 0; i < numberOfWinningNumbers; i++ {
		winningNumber := 0
		fmt.Sscanf(winningNumbersString[i*3+1:i*3+3], "%d", &winningNumber)
		winningNumbers = append(winningNumbers, winningNumber)
	}

	// Repeat for the actual numbers
	for i := 0; i < numberOfActualNumbers; i++ {
		actualNumber := 0
		fmt.Sscanf(actualNumbersString[i*3+1:i*3+3], "%d", &actualNumber)
		actualNumbers = append(actualNumbers, actualNumber)
	}

	card.matchingNumbers = countWinningMatches(actualNumbers, winningNumbers)
	card.cardCopies = 1
	return card
}

func countWinningMatches(numbers []int, winningNumbers []int) int {
	matches := 0
	for _, actualNumber := range numbers {
		for _, winningNumber := range winningNumbers {
			if actualNumber == winningNumber {
				matches++
			}
		}
	}
	return matches
}
