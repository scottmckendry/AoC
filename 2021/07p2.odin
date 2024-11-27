package main

import "core:fmt"
import "core:strings"

D07P2 :: proc() {
	input_string := #load("./inputs/07.txt", string)
	lines := strings.split(input_string, "\n", context.temp_allocator)

	least_fuel := least_fuel_crab_alignment(lines[0], true)
	fmt.printfln("Least fuel required to align crabs: %v", least_fuel)
}
