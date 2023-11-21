package main

import (
	"fmt"
	"strconv"
	"strings"

	"aoc2022/utils"
)

type monkey struct {
	id        int
	items     []int
	operation mokeyOperation
	test      monkeyTest
}

type monkeyTest struct {
	divisibleBy     int
	monkeyWhenTrue  int
	monkeyWhenFalse int
}

type mokeyOperation struct {
	operationType byte
	value         int
}

func D11P1() {
	lines := utils.ReadLines("./inputs/11.txt")
	monkeys := parseMonkeys(lines)

	for _, monkey := range monkeys {
		fmt.Printf(
			"Monkey ID: %d - Items: %v - Operation: %v - Test: %v\n",
			monkey.id,
			monkey.items,
			monkey.operation,
			monkey.test,
		)
	}
}

func parseMonkeys(lines []string) []monkey {
	monkeys := []monkey{}
	currentMonkey := monkey{}

	for i, line := range lines {
		if line == "" || i == len(lines)-1 {
			// Add completed monkey to array
			monkeys = append(monkeys, currentMonkey)
			continue
		}

		if line[0] == 'M' {
			// Set ID
			monkeyId := line[7 : len(line)-1]
			currentMonkey.id, _ = strconv.Atoi(monkeyId)
			continue
		}

		switch line[2] {
		case 'S':
			// Set Items
			currentMonkey.items = []int{}
			itemsString := line[18:]
			itemsArray := strings.Split(itemsString, ", ")

			for _, item := range itemsArray {
				itemInt, _ := strconv.Atoi(item)
				currentMonkey.items = append(currentMonkey.items, itemInt)
			}

		case 'O':
			// Set Operation
			currentMonkey.operation.operationType = line[23]
			valueString := line[25:]
			valueInt, err := strconv.Atoi(valueString)
			if err != nil {
				currentMonkey.operation.value = 0
				continue
			}

			currentMonkey.operation.value = valueInt

		case 'T':
			// Set Test divisibleBy
			divisibleByString := line[21:]
			divisibleByInt, _ := strconv.Atoi(divisibleByString)
			currentMonkey.test.divisibleBy = divisibleByInt

		case ' ':
			testCaseParts := strings.Split(line, " ")
			testCaseMonkeyId, _ := strconv.Atoi(testCaseParts[len(testCaseParts)-1])

			// Set Test monkeyWhenTrue
			if line[7] == 't' {
				currentMonkey.test.monkeyWhenTrue = testCaseMonkeyId
				continue
			}

			// Set Test monkeyWhenFalse
			currentMonkey.test.monkeyWhenFalse = testCaseMonkeyId
		}
	}

	return monkeys
}
