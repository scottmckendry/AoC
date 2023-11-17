package main

import (
	"flag"
	"fmt"
	"os"
	"strconv"

	"aoc2023/utils"
)

var solutions = map[string]func(){
	"01P1:Placeholder": D01P1,
	"01P2:Placeholder": D01P2,
}

func main() {
	benchmark := flag.Bool("benchmark", false, "Run benchmarks")
	flag.Parse()

	if !*benchmark {
		for _, solution := range solutions {
			utils.Benchmark(solution)
		}
		os.Exit(0)
	}

	// Run the full benchark suite and update the README
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
				"| [Day %d: %s](https://adventofcode.com/2023/day/%d) | %s | ",
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
		case "<!-- 2023TableStart -->":
			start = i
		case "<!-- 2023TableEnd -->":
			end = i
		}
	}

	// Remove the table and add the new one
	readme = append(readme[:start+1], readme[end:]...)
	readme = append(readme[:start+1], append([]string{readmeTable}, readme[start+1:]...)...)

	utils.WriteLines(readme, "../README.md")
}
