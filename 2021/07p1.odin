package main

import "core:fmt"
import "core:slice"
import "core:strconv"
import "core:strings"
import "utils"

D07P1 :: proc() {
	lines, backing := utils.read_lines("./inputs/07.txt")
	defer delete(lines)
	defer delete(backing)

	least_fuel := least_fuel_crab_alignment(lines[0], false)
	fmt.printfln("Least fuel required to align crabs: %v", least_fuel)
}

least_fuel_crab_alignment :: proc(input: string, increasing_fuel_cost: bool) -> int {
	crabs := parse_crabs(input)
	defer delete(crabs)

	min := crabs[0]
	max := crabs[len(crabs) - 1]
	least_fuel := max * max * len(crabs) // arbitrary large number

	current_fuel := 0
	for i in min ..= max {
		for crab in crabs {
			if increasing_fuel_cost {
				distance := abs(crab - i)
				fuel_used := (distance * (distance + 1)) / 2
				current_fuel += fuel_used
			} else {
				current_fuel += abs(crab - i)
			}
		}
		if current_fuel < least_fuel {
			least_fuel = current_fuel
		}
		current_fuel = 0
	}

	return least_fuel
}

parse_crabs :: proc(input: string) -> (crabs: [dynamic]int) {
	crabs_strs := strings.split(input, ",", context.temp_allocator)
	for crab_str in crabs_strs {
		current_crab := strconv.atoi(crab_str)
		append(&crabs, current_crab)
	}
	slice.sort(crabs[:])
	return
}
