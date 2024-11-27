package main

import "core:fmt"
import "core:strings"

D11P2 :: proc() {
	input_string := #load("./inputs/11.txt", string)
	lines := strings.split(input_string, "\n", context.temp_allocator)

	all_flash_at_step := get_all_octopi_flash_step(lines)
	fmt.printfln("All Octopi flash at step: %v", all_flash_at_step)
}

get_all_octopi_flash_step :: proc(lines: []string) -> int {
	energy_levels := parse_octopi_energy_levels(lines)
	flashes := 0
	steps := 0
	for flashes != 100 {
		flashes = simulate_octopus_step(&energy_levels)
		steps += 1
	}
	return steps
}
