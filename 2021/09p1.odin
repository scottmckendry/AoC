package main

import "core:fmt"
import "core:strings"

D09P1 :: proc() {
	input_string := #load("./inputs/09.txt", string)
	lines := strings.split(input_string, "\n", context.temp_allocator)
	lines = lines[:len(lines) - 1]

	sum_risk_levels := get_risk_levels(lines)
	fmt.printfln("The sum of risk levels is: %v", sum_risk_levels)
}

get_risk_levels :: proc(input: []string) -> int {
	heightmap := parse_heightmap(input)
	low_points := get_low_points(heightmap, len(input), len(input[0]))
	defer delete(heightmap)
	defer delete(low_points)

	sum_risk_levels := 0
	for low_point in low_points {
		sum_risk_levels += heightmap[low_point] + 1
	}

	return sum_risk_levels
}

parse_heightmap :: proc(input: []string) -> (heightmap: [dynamic]int) {
	for line in input {
		if line == "" {
			continue
		}

		for j in 0 ..< len(line) {
			append(&heightmap, cast(int)((line[j]) - '0'))
		}
	}
	return
}

get_low_points :: proc(
	heightmap: [dynamic]int,
	dimension_x: int,
	dimension_y: int,
) -> (
	low_points: [dynamic]int,
) {
	for i in 0 ..< dimension_x {
		for j in 0 ..< dimension_y {
			north := heightmap[(i - 1) * dimension_y + j] if i > 0 else 10
			east := heightmap[i * dimension_y + (j + 1)] if j < dimension_y - 1 else 10
			south := heightmap[(i + 1) * dimension_y + j] if i < dimension_x - 1 else 10
			west := heightmap[i * dimension_y + (j - 1)] if j > 0 else 10

			if heightmap[i * dimension_y + j] < north &&
			   heightmap[i * dimension_y + j] < east &&
			   heightmap[i * dimension_y + j] < south &&
			   heightmap[i * dimension_y + j] < west {
				append(&low_points, i * dimension_y + j)
			}
		}
	}
	return low_points
}
