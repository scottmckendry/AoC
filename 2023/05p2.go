package main

import (
	"fmt"
	"strconv"
	"strings"

	"aoc2023/utils"
)

func D05P2() {
	lines := utils.ReadLines("./inputs/05.txt")

	seedNumbers, seedRanges := parseAlmanacSeedsPartTwo(lines)
	maps := parseAlmanacMaps(lines)

	lowestLocationNumber := int(^uint(0) >> 1)
	for i, seedNumber := range seedNumbers {
		fmt.Printf("Processing seed %d\n", i)
		seeds := []int{}
		for j := 0; j < seedRanges[i]; j++ {
			seeds = append(seeds, seedNumber+j)
		}
		for _, almanacMap := range maps {
			seeds = applyAlmanacMap(seeds, almanacMap)
		}

		for _, seed := range seeds {
			if seed < lowestLocationNumber {
				lowestLocationNumber = seed
			}
		}
	}

	fmt.Printf("Lowest location number: %d\n", lowestLocationNumber)
}

func parseAlmanacSeedsPartTwo(lines []string) ([]int, []int) {
	fmt.Println("Parsing seeds...")

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
