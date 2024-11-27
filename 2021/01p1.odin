package main

import "core:fmt"
import "core:strconv"
import "core:strings"

D01P1 :: proc() {
	input_string := #load("inputs/01.txt", string)
	lines := strings.split(input_string, "\n", context.temp_allocator)

	depth_increase_count := get_depth_increase_count(lines)
	fmt.printfln("Depth increasd %v times.", depth_increase_count)
}

get_depth_increase_count :: proc(input: []string) -> int {
	depth_increase_count := 0
	prev_depth := strconv.atoi(input[0])

	for line in input {
		depth := strconv.atoi(line)

		if prev_depth < depth {
			depth_increase_count += 1
		}
		prev_depth = depth
	}
	return depth_increase_count
}
