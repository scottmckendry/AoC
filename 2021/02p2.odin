package main

import "core:fmt"
import "core:strconv"
import "core:strings"
import "utils"

D02P2 :: proc() {
	lines, backing := utils.read_lines("./inputs/02.txt")
	defer delete(lines)
	defer delete(backing)

	depth_increase_count := parse_submarine_instructions(lines)
	fmt.printfln("Product of final position: %v", depth_increase_count)
}

parse_submarine_instructions :: proc(input: []string) -> int {
	pos := Coordinate{0, 0}
    aim := 0
	for instruc in input {
		direction := strings.split(instruc, " ", context.temp_allocator)[0]
		weight := strconv.atoi(strings.split(instruc, " ", context.temp_allocator)[1])

		switch direction {
		case "forward":
			pos.x += weight
            pos.y += aim * weight
		case "up":
			aim -= weight
		case "down":
			aim += weight
		}
	}

	return pos.x * pos.y
}
