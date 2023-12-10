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

	ranges := []int{}
	for i := 0; i < len(seeds); i++ {
		ranges = append(ranges, 1)
	}

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

func parseAlmanacSeeds(lines []string) []int {
	var seeds []int

	seedListString := strings.Split(lines[0], ": ")[1]
	for _, seedString := range strings.Split(seedListString, " ") {
		seedNumber, _ := strconv.Atoi(seedString)
		seeds = append(seeds, seedNumber)
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

func applyAlmanacMap(seedStart int, seedRange int, almanacMap alamanacMap) ([]int, []int) {
	newSeedStarts := []int{}
	newSeedRanges := []int{}

	for _, almanacMapRange := range almanacMap.ranges {
		if seedStart >= almanacMapRange.sourceRangeStart &&
			seedStart < almanacMapRange.sourceRangeStart+almanacMapRange.rangeLength {
			difference := almanacMapRange.sourceRangeStart - almanacMapRange.destinationRangeStart
			newSeedStart := seedStart - difference
			newSeedStarts = append(newSeedStarts, newSeedStart)

			// If the full range of seeds is not contained within the current map range, we need to split the range
			if seedStart+seedRange > almanacMapRange.sourceRangeStart+almanacMapRange.rangeLength {
				// Append the range of seeds that is contained within the current map range
				newSeedRanges = append(
					newSeedRanges,
					almanacMapRange.sourceRangeStart+almanacMapRange.rangeLength-newSeedStart,
				)

				// Check what seeds are not contained within the current map range and map them recursively
				unmappedSeedStart := almanacMapRange.sourceRangeStart + almanacMapRange.rangeLength
				unmappedSeedRange := seedStart + seedRange - unmappedSeedStart

				mappedSeeds, mappedSeedRanges := applyAlmanacMap(
					unmappedSeedStart,
					unmappedSeedRange,
					almanacMap,
				)
				newSeedStarts = append(newSeedStarts, mappedSeeds...)
				newSeedRanges = append(newSeedRanges, mappedSeedRanges...)
				continue
			}

			newSeedRanges = append(newSeedRanges, seedRange)
		}
	}

	if len(newSeedStarts) == 0 {
		newSeedStarts = append(newSeedStarts, seedStart)
		newSeedRanges = append(newSeedRanges, seedRange)
	}

	return newSeedStarts, newSeedRanges
}
