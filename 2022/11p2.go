package main

import (
	"fmt"

	"aoc2022/utils"
)

func D11P2() {
	commonDivisor = 1
	const rounds = 10000
	lines := utils.ReadLines("./inputs/11.txt")
	monkeys := parseMonkeys(lines)

	for i := 0; i < rounds; i++ {
		simulateRound(&monkeys, false)
	}

	inspections := []int{}
	for _, monkey := range monkeys {
		inspections = append(inspections, monkey.inspectCount)
	}

	inspections = utils.SortInts(inspections)

	fmt.Printf(
		"Product of top two monkey inspections after %d rounds: %d\n",
		rounds,
		inspections[len(inspections)-1]*inspections[len(inspections)-2],
	)
}
