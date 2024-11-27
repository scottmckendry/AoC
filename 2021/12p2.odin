package main

import "core:fmt"
import "core:strings"

D12P2 :: proc() {
	input_string := #load("./inputs/12.txt", string)
	lines := strings.split(input_string, "\n", context.temp_allocator)

	small_cave_path_total := traverse_caves(lines, false)
	fmt.printfln("Paths through small caves: %v", small_cave_path_total)
}
