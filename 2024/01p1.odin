package main

import "core:fmt"
import "core:slice"
import "core:strconv"
import "core:strings"

D01P1 :: proc() {
	input_string := #load("inputs/01.txt", string)
	lines := strings.split(input_string, "\n", context.temp_allocator)

	total_distance := get_total_distance_between_pairs(lines)
	fmt.printf("Total distance between pairs: %d\n", total_distance)
}

get_total_distance_between_pairs :: proc(lines: []string) -> int {
	left, right := parse_number_pairs(lines)
	defer delete(left)
	defer delete(right)

	slice.sort(left[:])
	slice.sort(right[:])

	sum_distances := 0
	for num, i in left {
		sum_distances += abs(num - right[i])
	}

	return sum_distances
}

parse_number_pairs :: proc(lines: []string) -> (left: [dynamic]int, right: [dynamic]int) {
	for line in lines {
		if line == "" {
			continue
		}

		parts := strings.split(line, " ", context.temp_allocator)

		append(&left, strconv.atoi(parts[0]))
		append(&right, strconv.atoi(parts[3]))
	}

	return
}
