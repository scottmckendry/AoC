package main

import (
	"fmt"

	"aoc2022/utils"
)

func D03P1() {
	lines := utils.ReadLines("./inputs/03.txt")

	priorityTotal := 0

	var rucksacks []map[string]string

	for _, line := range lines {
		halfLine := len(line) / 2
		rucksack := make(map[string]string)

		rucksack["CompartmentOne"] = line[:halfLine]
		rucksack["CompartmentTwo"] = line[halfLine:]

		for _, compartmentOneItem := range rucksack["CompartmentOne"] {
			if rucksack["SharedItem"] != "" {
				continue
			}

			for _, compartmentTwoItem := range rucksack["CompartmentTwo"] {
				if compartmentOneItem != compartmentTwoItem {
					continue
				}

				rucksack["SharedItem"] = string(compartmentOneItem)
				// Print Items numberic value
				itemPriority := compartmentOneItem - 96

				// Check if item is uppercase
				if itemPriority < 0 {
					itemPriority = itemPriority + 58
				}

				priorityTotal += int(itemPriority)
				rucksack["SharedItemPriority"] = fmt.Sprintf("%v", itemPriority)
				break
			}
		}
		rucksacks = append(rucksacks, rucksack)
	}

	fmt.Printf("Priority Total: %v\n", priorityTotal)
}
