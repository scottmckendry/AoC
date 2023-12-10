package main

import (
	"fmt"
	"strconv"
	"strings"

	"aoc2023/utils"
)

func D05P2() {
	lines := utils.ReadLines("./inputs/05.txt")

	seeds, ranges := parseAlmanacSeedsPartTwo(lines)
	maps := parseAlmanacMaps(lines)

	for _, almanacMap := range maps {
		mappedSeeds := []int{}
		mappedRanges := []int{}
		for i, seed := range seeds {
			newSeeds, newRanges := applyAlmanacMap(seed, ranges[i], almanacMap)
			mappedSeeds = append(mappedSeeds, newSeeds...)
			mappedRanges = append(mappedRanges, newRanges...)
		}

		seeds = mappedSeeds
		ranges = mappedRanges
	}

	lowestLocationNumber := int(^uint(0) >> 1)
	for _, seed := range seeds {
		if seed < lowestLocationNumber {
			lowestLocationNumber = seed
		}
	}

	fmt.Printf("Lowest location number: %d\n", lowestLocationNumber)
}

func parseAlmanacSeedsPartTwo(lines []string) ([]int, []int) {
	seedNumbers := []int{}
	seedRanges := []int{}

	seedListString := strings.Split(lines[0], ": ")[1]
	for i, seedString := range strings.Split(seedListString, " ") {
		if i%2 == 1 {
			seedRange, _ := strconv.Atoi(seedString)
			seedRanges = append(seedRanges, seedRange)
			continue

		}
		seedNumber, _ := strconv.Atoi(seedString)
		seedNumbers = append(seedNumbers, seedNumber)
	}

	return seedNumbers, seedRanges
}
