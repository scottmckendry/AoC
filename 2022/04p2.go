package main

import (
	"fmt"
	"strconv"
	"strings"

	"aoc/utils"
)

func D04P2() {
	lines := utils.ReadLines("./inputs/04.txt")

	totalOverlaps := 0

	var assignmentPairs []map[string]int

	for _, line := range lines {
		assignmentPair := make(map[string]int)

		assignments := strings.Split(line, ",")
		for index, assignment := range assignments {
			assignmentRange := strings.Split(assignment, "-")
			assignmentPair["elf"+strconv.Itoa(index+1)+"RangeStart"], _ = strconv.Atoi(
				assignmentRange[0],
			)
			assignmentPair["elf"+strconv.Itoa(index+1)+"RangeEnd"], _ = strconv.Atoi(
				assignmentRange[1],
			)
		}
		assignmentPairs = append(assignmentPairs, assignmentPair)
	}

	for _, assignmentPair := range assignmentPairs {
		if assignmentPair["elf1RangeStart"] <= assignmentPair["elf2RangeEnd"] &&
			assignmentPair["elf1RangeEnd"] >= assignmentPair["elf2RangeStart"] {
			totalOverlaps++
		} else if assignmentPair["elf2RangeStart"] <= assignmentPair["elf1RangeEnd"] && assignmentPair["elf2RangeEnd"] >= assignmentPair["elf1RangeStart"] {
			totalOverlaps++
		}
	}

	fmt.Println("Total Overlaps:", totalOverlaps)
}
