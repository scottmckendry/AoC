package main

import (
	"fmt"

	"aoc2023/utils"
)

func D12P2() {
	lines := utils.ReadLines("inputs/12.txt")
	springs, groups := parseSprings(lines, true)

	permutationTotal := 0
	for i := 0; i < len(springs); i++ {
		permutationTotal += calculatePermutations(springs[i], groups[i])
	}

	fmt.Printf("Total possible spring arrangements: %d\n", permutationTotal)
}
