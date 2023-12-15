package main

import (
	"fmt"
	"strconv"
	"strings"

	"aoc2023/utils"
)

type step struct {
	label     string
	labelHash int
	operator  rune
	value     int
}

func D15P2() {
	lines := utils.ReadLines("inputs/15.txt")
	steps := parseSteps(lines[0])

	lensBoxes := map[int][]step{}
	for _, step := range steps {
		currentBox := lensBoxes[step.labelHash]
		if step.operator == '=' {
			boxContainsStep := false
			for i, lens := range currentBox {
				if lens.label == step.label {
					boxContainsStep = true
					currentBox[i] = step
					break
				}
			}

			if !boxContainsStep {
				currentBox = append(currentBox, step)
				lensBoxes[step.labelHash] = currentBox
				continue
			}
		}

		if step.operator == '-' {
			for i, lens := range currentBox {
				if lens.label == step.label {
					currentBox = append(currentBox[:i], currentBox[i+1:]...)
					lensBoxes[step.labelHash] = currentBox
					break
				}
			}
		}
		continue
	}

	focussingPower := 0
	for key, value := range lensBoxes {
		for i, step := range value {
			focussingPower += (key + 1) * (i + 1) * step.value
		}
	}

	fmt.Printf("The focussing power of the lens array is %d\n", focussingPower)
}

func parseSteps(line string) []step {
	steps := []step{}
	stepStrings := strings.Split(line, ",")

	for _, stepString := range stepStrings {
		step := step{}

		parsingLabel := true
		for i := 0; i < len(stepString) && parsingLabel; i++ {
			char := rune(stepString[i])
			switch char {
			case '=':
				step.operator = char
				step.value, _ = strconv.Atoi(stepString[i+1:])
				parsingLabel = false
			case '-':
				step.operator = char
				parsingLabel = false
			default:
				step.label += string(char)
			}
		}
		step.labelHash = getStringHashValue(step.label)
		steps = append(steps, step)
	}

	return steps
}
