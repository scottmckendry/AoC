package main

import (
	"fmt"
	"strconv"

	"aoc2022/utils"
)

func D10P1() {
	instructions := utils.ReadLines("inputs/10.txt")
	registerValue := 1
	signalStrengthTotal := 0
	cycleNumber := 1

	for _, instruction := range instructions {
		if instruction[0] == 'a' {
			updateSignalStrength(&signalStrengthTotal, cycleNumber, registerValue)
			cycleNumber++
			updateSignalStrength(&signalStrengthTotal, cycleNumber, registerValue)
			cycleNumber++

			instructionValue, _ := strconv.Atoi(instruction[5:])
			registerValue += instructionValue
			continue
		}

		updateSignalStrength(&signalStrengthTotal, cycleNumber, registerValue)
		cycleNumber++
	}

	fmt.Printf("Signal strength: %d\n", signalStrengthTotal)
}

func updateSignalStrength(signalStrengthTotal *int, cycleNumber int, registerValue int) {
	switch cycleNumber {
	case 20, 60, 100, 140, 180, 220:
		*signalStrengthTotal += cycleNumber * registerValue
	}
}
