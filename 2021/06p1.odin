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
	defer delete(fish)

	for _ in 1 ..= days {
		simulate_lanternfish_day(&fish)
	}
	return len(fish)
}

parse_lanterfish :: proc(input: string) -> (fish: [dynamic]int) {
	fish_strs := strings.split(input, ",", context.temp_allocator)
	for fish_str in fish_strs {
		append(&fish, strconv.atoi(fish_str))
	}
	return
}

simulate_lanternfish_day :: proc(fish: ^[dynamic]int) {
	for i in 0 ..< len(fish) {
		switch fish[i] {
		case 0:
			fish[i] = 6
			append(fish, 9) // append 9 instead of 8 because this fish will always be processed in this day
		case:
			fish[i] -= 1
		}
	}
}
