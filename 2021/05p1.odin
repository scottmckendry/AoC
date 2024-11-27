package main

import "core:fmt"
import "core:strconv"
import "core:strings"

VentLine :: struct {
	start: Vec2,
	end:   Vec2,
}

Vec2 :: struct {
	x: int,
	y: int,
}

D05P1 :: proc() {
	input_string := #load("./inputs/05.txt", string)
	lines := strings.split(input_string, "\n", context.temp_allocator)

	num_overlapping_points := get_overlapping_points(lines)
	fmt.printfln("Overlapping points: %v", num_overlapping_points)
}

get_overlapping_points :: proc(input: []string) -> int {
	vent_lines := parse_vent_lines(input)
	vents := map[Vec2]int{}
	defer delete(vents)
	defer delete(vent_lines)

	overlapping_points := 0
	for &line in vent_lines {
		if line.start.x == line.end.x || line.start.y == line.end.y {
			if line.start.x > line.end.x || line.start.y > line.end.y {
				line.start, line.end = line.end, line.start
			}
			for i in 0 ..= max(abs(line.end.x - line.start.x), abs(line.end.y - line.start.y)) {
				pos := Vec2 {
					line.start.x + i * sign(line.end.x - line.start.x),
					line.start.y + i * sign(line.end.y - line.start.y),
				}
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
	}

	return overlapping_points
}

sign :: proc(x: int) -> int {
	if x < 0 {
		return -1
	} else if x > 0 {
		return 1
	}
	return 0
}

parse_vent_lines :: proc(input: []string) -> (vent_lines: [dynamic]VentLine) {
	for line in input {
		if line == "" {
			continue
		}

		parts := strings.split(line, " ", context.temp_allocator)
		start_parts := strings.split(parts[0], ",", context.temp_allocator)
		end_parts := strings.split(parts[2], ",", context.temp_allocator)

		start_x := strconv.atoi(start_parts[0])
		start_y := strconv.atoi(start_parts[1])
		end_x := strconv.atoi(end_parts[0])
		end_y := strconv.atoi(end_parts[1])

		start := Vec2{start_x, start_y}
		end := Vec2{end_x, end_y}
		append(&vent_lines, VentLine{start, end})
	}
	return
}
