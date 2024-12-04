package main

import "core:flags"
import "core:fmt"
import "core:mem"
import "core:os"
import "core:strconv"
import "core:strings"
import "utils"

year :: "2024"

solutions: map[string]proc() = {
	"01P1:Historian Hysteria" = D01P1,
	"01P2:Historian Hysteria" = D01P2,
	"02P1:Red-Nosed Reports"  = D02P1,
	"02P2:Red-Nosed Reports"  = D02P2,
	"03P1:Mull It Over"       = D03P1,
	"03P2:Mull It Over"       = D03P2,
	"04P1:Ceres Search"       = D04P1,
	"04P2:Ceres Search"       = D04P2,
}

main :: proc() {
	track: mem.Tracking_Allocator
	mem.tracking_allocator_init(&track, context.allocator)
	context.allocator = mem.tracking_allocator(&track)
	defer {
		if len(track.allocation_map) > 0 {
			fmt.eprintf("=== %v allocations not freed: ===\n", len(track.allocation_map))
			for _, entry in track.allocation_map {
				fmt.eprintf("- %v bytes @ %v\n", entry.size, entry.location)
			}
		}
		if len(track.bad_free_array) > 0 {
			fmt.eprintf("=== %v incorrect frees: ===\n", len(track.bad_free_array))
			for entry in track.bad_free_array {
				fmt.eprintf("- %p @ %v\n", entry.memory, entry.location)
			}
		}
		mem.tracking_allocator_destroy(&track)
	}

	options :: struct {
		benchmark: bool `args:"name=benchmark" usage:"run benchmarks for all solutions"`,
		solution:  string `args:"name=solution" usage:"run a specific solution"`,
	}
	opt: options
	flags.parse_or_exit(&opt, os.args)

	// if no flags are set, exit
	if !opt.benchmark && opt.solution == "" {
		fmt.println("No flags set. Exiting.")
		return
	}

	if opt.benchmark && opt.solution == "" {
		update_readme()
		return
	}

	selected_solution: proc()
	for name, solution in solutions {
		if strings.contains(name, opt.solution) {
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
	defer delete(stats)

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
					fmt.tprintf(
						"| [Day %v: %v](https://adventofcode.com/2024/day/%v) | [%v](%v/%vp1.odin) | ",
						dayInt,
						stat.name,
						dayInt,
						stat.execution_time,
						year,
						stat.day,
					),
				},
				context.temp_allocator,
			)
		} else {
			readme_table = strings.concatenate(
				{
					readme_table,
					fmt.tprintf(
						"[%s](%v/%vp2.odin) | ⭐⭐ |\n",
						stat.execution_time,
						year,
						stat.day,
					),
				},
				context.temp_allocator,
			)
		}
	}

	// remove final newline
	readme_table = readme_table[:len(readme_table) - 1]

	readme, backing := utils.read_lines("../README.md")
	defer delete(readme)
	defer delete(backing)

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
	defer delete(new_content)

	append(&new_content, ..readme[:start + 1])
	append(&new_content, readme_table)
	append(&new_content, ..readme[end:])

	utils.write_lines("../README.md", new_content)
}
