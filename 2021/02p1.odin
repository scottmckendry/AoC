package main

import "core:fmt"
import "core:strconv"
import "core:strings"
import "utils"

Coordinate :: struct {
	x, y: int,
}

D02P1 :: proc() {
	lines, backing := utils.read_lines("./inputs/02.txt")
	defer delete(lines)
	defer delete(backing)

	depth_increase_count := parse_directions(lines)
	fmt.printfln("Product of final position: %v", depth_increase_count)
}

parse_directions :: proc(input: []string) -> int {
	pos := Coordinate{0, 0}
	for instruc in input {
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
