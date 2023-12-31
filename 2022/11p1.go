package main

import (
	"fmt"
	"strconv"
	"strings"

	"aoc2022/utils"
)

type monkey struct {
	id           int
	items        []int
	operation    mokeyOperation
	test         monkeyTest
	inspectCount int
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

var commonDivisor = 1

func D11P1() {
	const rounds = 20
	lines := utils.ReadLines("./inputs/11.txt")
	monkeys := parseMonkeys(lines)

	for i := 0; i < rounds; i++ {
		simulateRound(&monkeys, true)
	}

	monkeyWithMostInspections := monkeys[0]
	monkeyWithSecondMostInspections := monkeys[0]
	for _, monkey := range monkeys {
		if monkey.inspectCount > monkeyWithMostInspections.inspectCount {
			monkeyWithSecondMostInspections = monkeyWithMostInspections
			monkeyWithMostInspections = monkey
		}
	}

	fmt.Printf(
		"Product of top two monkey inspections: %d\n",
		monkeyWithMostInspections.inspectCount*monkeyWithSecondMostInspections.inspectCount,
	)
}

func parseMonkeys(lines []string) []monkey {
	monkeys := []monkey{}
	currentMonkey := monkey{}

	for _, line := range lines {
		if line == "" {
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

			// Update common divisor
			commonDivisor *= divisibleByInt

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

	// Add last monkey
	monkeys = append(monkeys, currentMonkey)
	return monkeys
}

func simulateRound(monkeys *[]monkey, partOne bool) {
	for i := 0; i < len(*monkeys); i++ {
		monkey := (*monkeys)[i]
		// Check if monkey has items
		if len(monkey.items) == 0 {
			continue
		}
		simulateMonkeyOperations(&monkey, monkeys, partOne)
		// Remove all thrown items
		(*monkeys)[i].items = []int{}
	}
}

func simulateMonkeyOperations(selectedMonkey *monkey, allMonkeys *[]monkey, partOne bool) {
	resetOperationValue := false
	for i, item := range selectedMonkey.items {
		(*allMonkeys)[selectedMonkey.id].inspectCount++
		// If the monkey's operation references the item value, set to the value of the item
		if selectedMonkey.operation.value == 0 {
			selectedMonkey.operation.value = item
			resetOperationValue = true
		}

		if selectedMonkey.operation.operationType == '*' {
			selectedMonkey.items[i] = item * selectedMonkey.operation.value
		} else {
			selectedMonkey.items[i] = item + selectedMonkey.operation.value
		}

		if resetOperationValue {
			selectedMonkey.operation.value = 0
		}

		if partOne {
			selectedMonkey.items[i] = selectedMonkey.items[i] / 3
		} else {
			selectedMonkey.items[i] %= commonDivisor
		}
		simulateMonkeyTest(selectedMonkey, selectedMonkey.items[i], allMonkeys)
	}
}

func simulateMonkeyTest(selectedMonkey *monkey, item int, allMonkeys *[]monkey) {
	if item%selectedMonkey.test.divisibleBy == 0 {
		(*allMonkeys)[selectedMonkey.test.monkeyWhenTrue].items = append(
			(*allMonkeys)[selectedMonkey.test.monkeyWhenTrue].items,
			item,
		)
		return
	}

	(*allMonkeys)[selectedMonkey.test.monkeyWhenFalse].items = append(
		(*allMonkeys)[selectedMonkey.test.monkeyWhenFalse].items,
		item,
	)
}
