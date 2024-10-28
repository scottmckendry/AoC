package main

import "core:flags"
import "core:fmt"
import "core:os"
import "core:strconv"
import "core:strings"
import "utils"

year :: "2021"

solutions: map[string]proc() = {
	"01P1:Sonar Sweep" = D01P1,
	"01P2:Sonar Sweep" = D01P2,
}

main :: proc() {
	options :: struct {
		benchmark: bool `args:"name=benchmark" usage:"run benchmarks for all solutions"`,
		solution:  string `args:"name=solution" usage:"run a specific solution"`,
	}
	opt: options
	flags.parse_or_exit(&opt, os.args)

	// if no flags are set, exit
	if !opt.benchmark && opt.solution == "" {
		fmt.println("No flags set. Exiting.")
		os.exit(1)
	}

	if opt.benchmark && opt.solution == "" {
		update_readme()
		os.exit(0)
	}

	selected_solution: proc()
	for name, solution in solutions {
		if strings.contains(name, strings.to_upper(opt.solution)) {
			selected_solution = solution
			break
		}
	}

	if selected_solution == nil {
		fmt.println("Solution not found. Exiting.")
		os.exit(1)
	}

	if opt.benchmark {
		utils.benchmark(selected_solution)
	} else {
		selected_solution()
	}
}

update_readme :: proc() {
	stats := utils.get_solution_stats(solutions)
	for stat, _ in stats {
		fmt.printfln("%v - Part %s: %v", stat.day, stat.part, stat.execution_time)
	}

	readme_table := "| Day | Part 1 | Part 2 | Stars |\n| --- | --- | --- | --- |\n"
	for stat, _ in stats {
		dayInt := strconv.atoi(stat.day)
		if stat.part == "1" {
			readme_table = strings.concatenate(
				{
					readme_table,
					fmt.aprintf(
						"| [Day %v: %v](https://adventofcode.com/2023/day/%v) | [%v](%v/%vp1.odin) | ",
						dayInt,
						stat.name,
						dayInt,
						stat.execution_time,
						year,
						stat.day,
					),
				},
			)
		} else {
			readme_table = strings.concatenate(
				{
					readme_table,
					fmt.aprintf(
						"[%s](%v/%vp2.odin) | ⭐⭐ |\n",
						stat.execution_time,
						year,
						stat.day,
					),
				},
			)
		}
	}

	// remove final newline
	readme_table = readme_table[:len(readme_table) - 1]

	readme := utils.read_lines("../README.md")
	start: int
	end: int
	for line, i in readme {
		if line == "<!-- " + year + "TableStart -->" {
			start = i
		} else if line == "<!-- " + year + "TableEnd -->" {
			end = i
		}
	}

	// remove the existing table and add the new one
	new_content: [dynamic]string
	append(&new_content, ..readme[:start + 1])
	append(&new_content, readme_table)
	append(&new_content, ..readme[end:])

	utils.write_lines("../README.md", new_content)
}
