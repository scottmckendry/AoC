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
	"01P1:Trebuchet?!":                     D01P1,
	"01P2:Trebuchet?!":                     D01P2,
	"02P1:Cube Conundrum":                  D02P1,
	"02P2:Cube Conundrum":                  D02P2,
	"03P1:Gear Ratios":                     D03P1,
	"03P2:Gear Ratios":                     D03P2,
	"04P1:Scratchcards":                    D04P1,
	"04P2:Scratchcards":                    D04P2,
	"05P1:If You Give a Seed A Fertilizer": D05P1,
	"05P2:If You Give a Seed A Fertilizer": D05P2,
	"06P1:Wait For It":                     D06P1,
	"06P2:Wait For It":                     D06P2,
	"07P1:Camel Cards":                     D07P1,
	"07P2:Camel Cards":                     D07P2,
	"08P1:Haunted Wasteland":               D08P1,
	"08P2:Haunted Wasteland":               D08P2,
	"09P1:Mirage Maintenance":              D09P1,
	"09P2:Mirage Maintenance":              D09P2,
	"10P1:Pipe Maze":                       D10P1,
	"10P2:Pipe Maze":                       D10P2,
	"11P1:Cosmic Expansion":                D11P1,
	"11P2:Cosmic Expansion":                D11P2,
	"12P1:Hot Springs":                     D12P1,
	"12P2:Hot Springs":                     D12P2,
	"13P1:Point of Incidence":              D13P1,
	"13P2:Point of Incidence":              D13P2,
	"14P1:Parabolic Reflector Dish":        D14P1,
	"14P2:Parabolic Reflector Dish":        D14P2,
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
				"| [Day %d: %s](https://adventofcode.com/2023/day/%d) | [%s](2023/%s.go) | ",
				dayInt,
				statistic.Name,
				dayInt,
				statistic.ExecutionTime,
				statistic.Day+"p1",
			)
		} else {
			readmeTable += fmt.Sprintf(
				"[%s](2023/%s.go) | ⭐⭐ |\n",
				statistic.ExecutionTime,
				statistic.Day+"p2",
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
