package main

import "core:fmt"
import "core:strconv"
import "core:strings"
import "utils"

D06P1 :: proc() {
	lines, backing := utils.read_lines("./inputs/06.txt")
	defer delete(lines)
	defer delete(backing)

	days := 80
	total_lanterfish := simulate_lanterfish_growth(lines[0], days)
	fmt.printfln("Number of lanterfish after %v days: %v", days, total_lanterfish)
}

simulate_lanterfish_growth :: proc(input: string, days: int) -> int {
	fish := parse_lanterfish(input)

	for _ in 1 ..= days {
		simulate_lanternfish_day(&fish)
	}

	total_lanternfish := 0
	for i in 0 ..< len(fish) {
		total_lanternfish += fish[i]
	}
	return total_lanternfish
}

parse_lanterfish :: proc(input: string) -> (fish: [9]int) {
	fish_strs := strings.split(input, ",", context.temp_allocator)
	for fish_str in fish_strs {
		current_fish := strconv.atoi(fish_str)
		fish[current_fish] += 1
	}
	return
}

simulate_lanternfish_day :: proc(fish: ^[9]int) {
	temp_fish := [9]int{}
	// reversing the loop ensures that the fish at index 8 are not overwritten
	for i := 8; i >= 0; i -= 1 {
		switch i {
		case 0:
			temp_fish[6] += fish[i] // fish at index 7 have already been moved, so we can add to them
			temp_fish[8] = fish[i] // newborn fish at index 8
		case:
			temp_fish[i - 1] = fish[i]
		}
	}

	for i := 0; i < 9; i += 1 {
		fish[i] = temp_fish[i]
	}
}
