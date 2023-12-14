package main

import (
	"fmt"
	"strconv"
	"strings"

	"aoc2023/utils"
)

var springCache = make(map[string]int)

func D12P1() {
	lines := utils.ReadLines("inputs/12.txt")
	springs, groups := parseSprings(lines, false)

	permutationTotal := 0
	for i := 0; i < len(springs); i++ {
		permutationTotal += calculatePermutations(springs[i], groups[i])
	}

	fmt.Printf("Total possible spring arrangements: %d\n", permutationTotal)
}

func parseSprings(lines []string, unfold bool) ([]string, [][]int) {
	springs := make([]string, len(lines))
	groups := make([][]int, len(lines))
	for i, line := range lines {
		springs[i], groups[i] = parseSpringRow(line, unfold)
	}
	return springs, groups
}

func parseSpringRow(line string, unfold bool) (string, []int) {
	spring := strings.Split(line, " ")[0]
	groupsString := strings.Split(line, " ")[1]
	groupsStringValues := strings.Split(groupsString, ",")

	groups := make([]int, len(groupsStringValues))
	for i := 0; i < len(groups); i++ {
		groups[i], _ = strconv.Atoi(groupsStringValues[i])
	}

	newSpring := ""
	newGroups := []int{}
	if unfold {
		for i := 0; i < 5; i++ {
			newSpring += spring + "?"
			newGroups = append(newGroups, groups...)
		}
	} else {
		newSpring = spring
		newGroups = groups
	}

	// remove the last ? from the row
	newSpring = newSpring[:len(newSpring)-1]

	return newSpring, newGroups
}

func calculatePermutations(springRow string, groups []int) int {
	key := springRow
	for _, group := range groups {
		key += strconv.Itoa(group) + ","
	}

	if v, ok := springCache[key]; ok {
		return v
	}

	if len(springRow) == 0 {
		if len(groups) == 0 {
			return 1
		} else {
			return 0
		}
	}

	if strings.HasPrefix(springRow, "?") {
		return calculatePermutations(strings.Replace(springRow, "?", ".", 1), groups) +
			calculatePermutations(strings.Replace(springRow, "?", "#", 1), groups)
	}
	if strings.HasPrefix(springRow, ".") {
		res := calculatePermutations(strings.TrimPrefix(springRow, "."), groups)
		springCache[key] = res
		return res
	}

	if strings.HasPrefix(springRow, "#") {
		if len(groups) == 0 {
			springCache[key] = 0
			return 0
		}
		if len(springRow) < groups[0] {
			springCache[key] = 0
			return 0
		}
		if strings.Contains(springRow[0:groups[0]], ".") {
			springCache[key] = 0
			return 0
		}
		if len(groups) > 1 {
			if len(springRow) < groups[0]+1 || string(springRow[groups[0]]) == "#" {
				springCache[key] = 0
				return 0
			}
			res := calculatePermutations(springRow[groups[0]+1:], groups[1:])
			springCache[key] = res
			return res
		} else {
			res := calculatePermutations(springRow[groups[0]:], groups[1:])
			springCache[key] = res
			return res
		}
	}

	return 0
}
