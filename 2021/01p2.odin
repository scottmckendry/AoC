package main

import "core:fmt"
import "core:strconv"
import "utils"

D01P2 :: proc() {
	lines := utils.read_lines("./inputs/01p1.txt")
	depth_increase_count := get_depth_increase_count_windowed(lines)
	fmt.printfln("Depth increasd %v times.", depth_increase_count)
}

get_depth_increase_count_windowed :: proc(lines: [dynamic]string) -> int {
	depth_increase_count := 0

	prev_depth := 0
	// set the initial depth to the first window 
	for i := 0; i < 3 && i < len(lines); i += 1 {
		prev_depth += strconv.atoi(lines[i])
	}

	for i := 0; i < len(lines) - 2; i += 1 {
		depth := 0
		for j := i; j < i + 3; j += 1 {
			depth += strconv.atoi(lines[j])
		}

		if prev_depth < depth {
			depth_increase_count += 1
		}
		prev_depth = depth
	}

	return depth_increase_count
}