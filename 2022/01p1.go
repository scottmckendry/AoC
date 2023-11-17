package main

import (
	"fmt"
	"strconv"

	"aoc2022/utils"
)

func D01P1() {
	currentElf := 0
	bestElf := 0

	lines := utils.ReadLines("./inputs/01.txt")

	for _, line := range lines {
		if line == "" {
			if currentElf > bestElf {
				bestElf = currentElf
			}
			currentElf = 0
		} else {
			lineInt, err := strconv.Atoi(line)
			if err != nil {
				fmt.Println("Error converting line to int:", err)
			}

			currentElf += lineInt
		}
	}

	fmt.Printf("Best Elf: %v\n", bestElf)
}
