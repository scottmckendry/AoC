package main

import (
	"fmt"
	"strconv"
	"strings"

	"aoc2023/utils"
)

type alamanacMap struct {
	mapName string
	ranges  []almanacMapRange
}

type almanacMapRange struct {
	destinationRangeStart int
	sourceRangeStart      int
	rangeLength           int
}

func D05P1() {
	lines := utils.ReadLines("./inputs/05.txt")

	seeds := parseAlmanacSeeds(lines)
	maps := parseAlmanacMaps(lines)

	for _, almanacMap := range maps {
		seeds = applyAlmanacMap(seeds, almanacMap)
	}

	lowestLocationNumber := int(^uint(0) >> 1)
	for _, seed := range seeds {
		if seed[len(seed)-1] < lowestLocationNumber && lowestLocationNumber != 0 {
			lowestLocationNumber = seed[len(seed)-1]
		}
	}

	fmt.Printf("Lowest location number: %d\n", lowestLocationNumber)
}

func parseAlmanacSeeds(lines []string) [][]int {
	var seeds [][]int

	seedListString := strings.Split(lines[0], ": ")[1]
	for _, seedString := range strings.Split(seedListString, " ") {
		currentSeed := []int{}
		seedNumber, _ := strconv.Atoi(seedString)

		currentSeed = append(currentSeed, seedNumber)
		seeds = append(seeds, currentSeed)
	}

	return seeds
}

func parseAlmanacMaps(lines []string) []alamanacMap {
	almanacMaps := []alamanacMap{}

	currentMap := alamanacMap{}
	for _, line := range lines[2:] {
		if line == "" {
			almanacMaps = append(almanacMaps, currentMap)
			currentMap = alamanacMap{}
			continue
		}

		if strings.Contains(line, ":") {
			currentMap.mapName = strings.Split(line, " ")[0]
			continue
		}

		almanacMapRange := almanacMapRange{}

		fmt.Sscanf(
			line,
			"%d %d %d",
			&almanacMapRange.destinationRangeStart,
			&almanacMapRange.sourceRangeStart,
			&almanacMapRange.rangeLength,
		)

		currentMap.ranges = append(currentMap.ranges, almanacMapRange)
	}

	almanacMaps = append(almanacMaps, currentMap)
	return almanacMaps
}

func applyAlmanacMap(seeds [][]int, almanacMap alamanacMap) [][]int {
	fmt.Printf("Applying map %s...\n", almanacMap.mapName)
	startingLength := len(seeds[0])
	for i, seed := range seeds {
		for _, almanacMapRange := range almanacMap.ranges {
			sourceValue := seed[len(seed)-1]

			if sourceValue >= almanacMapRange.sourceRangeStart &&
				sourceValue < almanacMapRange.sourceRangeStart+almanacMapRange.rangeLength {
				diff := almanacMapRange.sourceRangeStart - almanacMapRange.destinationRangeStart
				seeds[i] = append(seed, sourceValue-diff)
			}
		}

		// If no match is found, append the last value
		if len(seeds[i]) < startingLength+1 {
			seeds[i] = append(seed, seed[len(seed)-1])
		}
	}

	return seeds
}
