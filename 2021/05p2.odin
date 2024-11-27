package main

import "core:fmt"
import "core:strings"

D05P2 :: proc() {
	input_string := #load("./inputs/05.txt", string)
	lines := strings.split(input_string, "\n", context.temp_allocator)

	num_overlapping_points := get_overlapping_points_with_diagonals(lines)
	fmt.printfln("Overlapping points: %v", num_overlapping_points)
}

get_overlapping_points_with_diagonals :: proc(input: []string) -> int {
	vent_lines := parse_vent_lines(input)
	vents := map[Vec2]int{}
	defer delete(vents)
	defer delete(vent_lines)

	overlapping_points := 0
	for &line in vent_lines {
		x_step := sign(line.end.x - line.start.x)
		y_step := sign(line.end.y - line.start.y)
		length := max(abs(line.end.x - line.start.x), abs(line.end.y - line.start.y))

		for i in 0 ..= length {
			pos := Vec2{line.start.x + i * x_step, line.start.y + i * y_step}
			vent, ok := vents[pos]
			if !ok {
				vents[pos] = 1
			} else {
				vents[pos] = vent + 1
				if vents[pos] == 2 {
					overlapping_points += 1
				}
			}
		}
	}

	return overlapping_points
}
