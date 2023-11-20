package main

import (
	"fmt"
	"strconv"

	"aoc2022/utils"
)

func D10P2() {
	instructions := utils.ReadLines("inputs/10.txt")
	registerValue := 1
	cycleNumber := 1

	screen := []string{}

	for _, instruction := range instructions {
		if instruction[0] == 'a' {
			drawPixel(&screen, cycleNumber, registerValue)
			cycleNumber++
			drawPixel(&screen, cycleNumber, registerValue)
			cycleNumber++

			instructionValue, _ := strconv.Atoi(instruction[5:])
			registerValue += instructionValue
			continue
		}

		drawPixel(&screen, cycleNumber, registerValue)
		cycleNumber++
	}

	for _, line := range screen {
		fmt.Println(line)
	}
}

func drawPixel(screen *[]string, cycleNumber int, registerValue int) {
	screenX := cycleNumber % 40
	pixelValue := "."

	if screenX == 0 {
		screenX = 40
	}

	// Check if sprite position collides with the current pixel
	switch screenX {
	case registerValue, registerValue + 1, registerValue + 2:
		pixelValue = "#"
	}

	// If starting a new line, add a new line to the screen
	if screenX == 1 {
		*screen = append(*screen, pixelValue)
		return
	}

	// Otherwise, add the pixel to the end of the current line
	(*screen)[len(*screen)-1] += pixelValue
}
