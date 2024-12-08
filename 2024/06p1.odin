package main

import "core:fmt"
import "core:strings"

vec2 :: struct {
	x, y: int,
}

lab_map_coord :: struct {
	is_obstacle: bool,
	visited:     bool,
}

D06P1 :: proc() {
	input_string := #load("inputs/06.txt", string)
	lines := strings.split(input_string, "\n", context.temp_allocator)

	unique_guard_positions, throw_away := get_unique_guard_positions(lines[:len(lines) - 1])
	delete(throw_away)
	fmt.printf("Unique guard positions: %d\n", unique_guard_positions)
}

get_unique_guard_positions :: proc(
	lines: []string,
) -> (
	visited_count: int,
	unique_positions: [dynamic]vec2,
) {
	lab_map, guard_position, max_x, max_y := parse_lab_map(lines)
	defer delete(lab_map)

	guard_direction := vec2{0, -1}

	visited_count = 1

	on_map := true
	for on_map {
		// walk in direction until obstacle, then turn 90 degrees
		for {
			next_position: vec2
			next_position.x, next_position.y =
				guard_position.x + guard_direction.x, guard_position.y + guard_direction.y
			if lab_map[next_position].is_obstacle {
				break
			}

			if next_position.x < 0 ||
			   next_position.x >= max_x ||
			   next_position.y < 0 ||
			   next_position.y >= max_y {
				on_map = false
				break
			}

			guard_position = next_position
			if !lab_map[guard_position].visited {
				visited_count += 1
				append(&unique_positions, guard_position)
				guard_map_coord := lab_map[guard_position]
				guard_map_coord.visited = true
				lab_map[guard_position] = guard_map_coord
			}
		}

		// turn 90 degrees
		if guard_direction.x == 0 {
			if guard_direction.y == 1 {
				guard_direction = vec2{-1, 0}
			} else {
				guard_direction = vec2{1, 0}
			}
		} else {
			if guard_direction.x == 1 {
				guard_direction = vec2{0, 1}
			} else {
				guard_direction = vec2{0, -1}
			}
		}
	}

	return
}

parse_lab_map :: proc(
	lines: []string,
) -> (
	lab_map: map[vec2]lab_map_coord,
	guard_position: vec2,
	max_x: int,
	max_y: int,
) {
	for line, y in lines {
		for char, x in line {
			switch char {
			case '^':
				guard_position = vec2{x, y}
				lab_map[vec2{x, y}] = lab_map_coord {
					visited = true,
				}
			case '#':
				lab_map[vec2{x, y}] = lab_map_coord {
					is_obstacle = true,
				}
			case:
				lab_map[vec2{x, y}] = lab_map_coord{}
			}
		}
	}

	max_x = len(lines[0])
	max_y = len(lines)
	return
}
