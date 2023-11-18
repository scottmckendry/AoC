package main

import (
	"flag"
	"fmt"
	"os"
	"strconv"
	"strings"

	"aoc2023/utils"
)

var solutions = map[string]func(){
	"01P1:Placeholder": D01P1,
	"01P2:Placeholder": D01P2,
}

func main() {
	benchmark := flag.Bool(
		"benchmark",
		false,
		"Run benchmarks. When used with the -solution flag, it will only run the benchmark for that solution. If no solution is specified, it will run all benchmarks and update the README.md",
	)
	solution := flag.String("solution", "", "Run a specific solution (e.g. 01P1)")
	flag.Parse()

	// If no flags are set, print the usage and exit
	if !*benchmark && *solution == "" {
		flag.Usage()
		os.Exit(1)
	}

	// If the benchmark flag is set, run all solutions and update the readme
	if *benchmark && *solution == "" {
		updateReadme()
		os.Exit(0)
	}

	var selectedSolution func()
	for name, solutionFunc := range solutions {
		if strings.ToUpper(*solution) == strings.Split(name, ":")[0] {
			selectedSolution = solutionFunc
			break
		}
	}

	if selectedSolution == nil {
		fmt.Printf("Solution %s not found\n", *solution)
		os.Exit(1)
	}

	// If the benchmark flag is set, wrap the solution in a benchmark
	if *benchmark {
		utils.Benchmark(selectedSolution)
		os.Exit(0)
	}

	// Finally, run the solution on it's own
	selectedSolution()
	os.Exit(0)
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