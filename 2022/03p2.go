package main

import (
	"fmt"

	"aoc2022/utils"
)

func D03P2() {
	lines := utils.ReadLines("./inputs/03.txt")
	priorityTotal := 0
	numGroups := len(lines) / 3

	var elfGroups []map[string]string

	for i := 0; i < numGroups; i++ {
		elfGroup := make(map[string]string)
		elfGroup["ElfOne"] = lines[i*3]
		elfGroup["ElfTwo"] = lines[i*3+1]
		elfGroup["ElfThree"] = lines[i*3+2]

		sharedItem := compareElves(elfGroup["ElfOne"], elfGroup["ElfTwo"], elfGroup["ElfThree"])

		elfGroup["SharedItem"] = string(sharedItem)

		// Print Items numberic value
		itemPriority := sharedItem - 96

		// Check if item is uppercase
		if itemPriority < 0 {
			itemPriority = itemPriority + 58
		}

		priorityTotal += int(itemPriority)
		elfGroup["SharedItemPriority"] = fmt.Sprintf("%v", itemPriority)

		elfGroups = append(elfGroups, elfGroup)
	}

	fmt.Printf("Priority Total: %v\n", priorityTotal)
}

func compareElves(elfOne string, elfTwo string, elfThree string) rune {
	for _, elfOneItem := range elfOne {
		for _, elfTwoItem := range elfTwo {
			if elfOneItem == elfTwoItem {
				for _, elfThreeItem := range elfThree {
					if elfOneItem == elfThreeItem {
						return elfOneItem
					}
				}
			}
		}
	}

	return 0
}
