package main

import (
	"fmt"
	"sort"

	"aoc/utils"
)

func D06P1() {
	lines := utils.ReadLines("./inputs/06.txt")

	signal := lines[0]
	markerCheck := signal[0:4]
	markerCharacterIndex := 0

	for i := 4; i < len(signal); i++ {
		splitMarkerCheck := []rune(markerCheck)
		sort.Slice(splitMarkerCheck, func(c, j int) bool {
			return splitMarkerCheck[c] < splitMarkerCheck[j]
		})
		markerCheck = string(splitMarkerCheck)

		isUnique := true
		for j := 1; j < len(markerCheck); j++ {
			if markerCheck[j] != markerCheck[j-1] {
				continue
			} else {
				isUnique = false
				break
			}
		}

		if isUnique {
			markerCharacterIndex = i
			break
		}

		markerCheck = signal[i-3 : i+1]
	}

	fmt.Printf("Marker character index: %v\n", markerCharacterIndex)
}
