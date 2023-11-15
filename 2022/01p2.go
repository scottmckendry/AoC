package main

import (
	"fmt"
	"sort"
	"strconv"

	"aoc/utils"
)

func D01P2() {
	var elves []int
	var currentElf int

	lines := utils.ReadLines("./inputs/01.txt")

	for _, line := range lines {
		if line == "" {
			elves = append(elves, currentElf)
			currentElf = 0
		} else {
			lineInt, err := strconv.Atoi(line)
			if err != nil {
				fmt.Println("Error converting line to int:", err)
			}

			currentElf += lineInt
		}
	}

	sort.Slice(elves, func(i, j int) bool {
		return elves[i] > elves[j]
	})

	sum := elves[0] + elves[1] + elves[2]

	fmt.Println("Sum:", sum)
}
