package main

import "core:fmt"
import "core:strings"

D06P2 :: proc() {
	input_string := #load("./inputs/06.txt", string)
	lines := strings.split(input_string, "\n", context.temp_allocator)

	days := 256
	total_lanterfish := simulate_lanterfish_growth(lines[0], days)
	fmt.printfln("Number of lanterfish after %v days: %v", days, total_lanterfish)
}
