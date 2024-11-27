package main

import "core:fmt"
import "core:strconv"
import "core:strings"

Coordinate :: struct {
	x, y: int,
}

D02P1 :: proc() {
	input_string := #load("./inputs/02.txt", string)
	lines := strings.split(input_string, "\n", context.temp_allocator)

	depth_increase_count := parse_directions(lines)
	fmt.printfln("Product of final position: %v", depth_increase_count)
}

parse_directions :: proc(input: []string) -> int {
	pos := Coordinate{0, 0}
	for instruc in input {
		if instruc == "" {
			continue
		}

		direction := strings.split(instruc, " ", context.temp_allocator)[0]
		distance := strconv.atoi(strings.split(instruc, " ", context.temp_allocator)[1])

		switch direction {
		case "forward":
			pos.x += distance
		case "up":
			pos.y -= distance
		case "down":
			pos.y += distance
		}
	}

	return pos.x * pos.y
}
