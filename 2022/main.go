package main

import (
	"fmt"
	"strconv"

	"aoc/utils"
)

var solutions = map[string]func(){
	"01P1:Calorie Counting":        D01P1,
	"01P2:Calorie Counting":        D01P2,
	"02P1:Rock Paper Scissors":     D02P1,
	"02P2:Rock Paper Scissors":     D02P2,
	"03P1:Rucksack Reorganization": D03P1,
	"03P2:Rucksack Reorganization": D03P2,
	"04P1:Camp Cleanup":            D04P1,
	"04P2:Camp Cleanup":            D04P2,
	"05P1:Supply Stacks":           D05P1,
	"05P2:Supply Stacks":           D05P2,
	"06P1:Tuning Trouble":          D06P1,
	"06P2:Tuning Trouble":          D06P2,
	"07P1:No Space Left On Device": D07P1,
	"07P2:No Space Left On Device": D07P2,
	"08P1:Treetop Tree House":      D08P1,
	"08P2:Treetop Tree House":      D08P2,
}

func main() {
	for _, solution := range solutions {
		utils.Benchmark(solution)
	}

	updateReadme()
}

func updateReadme() {
	statistics := utils.GetSolutionStatistics(solutions)

	for _, statistic := range statistics {
		fmt.Printf("%s - Part %s: %v\n", statistic.Day, statistic.Part, statistic.ExecutionTime)
	}

	readmeTable := "| Day | Part 1 | Part 2 | Stars |\n| --- | --- | --- | --- |\n"
	for _, statistic := range statistics {
		dayInt, _ := strconv.Atoi(statistic.Day)
		if statistic.Part == "1" {
			readmeTable += fmt.Sprintf(
				"| [Day %d: %s](https://adventofcode.com/2022/day/%d) | %s | ",
				dayInt,
				statistic.Name,
				dayInt,
				statistic.ExecutionTime,
			)
		} else {
			readmeTable += fmt.Sprintf(
				"%s | ⭐⭐ |\n",
				statistic.ExecutionTime,
			)
		}
	}

	readme := utils.ReadLines("../README.md")
	start := 0
	end := 0
	for i, line := range readme {
		switch line {
		case "<!-- 2022TableStart -->":
			start = i
		case "<!-- 2022TableEnd -->":
			end = i
		}
	}

	// Remove the table and add the new one
	readme = append(readme[:start+1], readme[end:]...)
	readme = append(readme[:start+1], append([]string{readmeTable}, readme[start+1:]...)...)

	utils.WriteLines(readme, "../README.md")
}
