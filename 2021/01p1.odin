package main

import "core:fmt"
import "core:strconv"
import "utils"

D01P1 :: proc() {
	lines := utils.read_lines("./inputs/01p1.txt")
	depth_increase_count := get_depth_increase_count(lines)

	fmt.printfln("Depth increasd %v times.", depth_increase_count)
}

get_depth_increase_count :: proc(input: [dynamic]string) -> int {
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
