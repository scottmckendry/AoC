package main

import "core:fmt"
import "core:strings"

position_state :: struct {
	position, direction: vec2,
}

D06P2 :: proc() {
	input_string := #load("inputs/06.txt", string)
	lines := strings.split(input_string, "\n", context.temp_allocator)

	loop_causing_obstacles := get_loop_causing_obstacles(lines[:len(lines) - 1])
	fmt.printf("Number of loop-causing obstacle positions: %d\n", loop_causing_obstacles)
}

get_loop_causing_obstacles :: proc(lines: []string) -> int {
	original_map, guard_position, max_x, max_y := parse_lab_map(lines)
	_, positions_to_check := get_unique_guard_positions(lines)
	defer delete(original_map)
	defer delete(positions_to_check)

	loop_count := 0

	// place a obstable at each possible position, and check if it causes a loop
	for position in positions_to_check {
		if (position.x == guard_position.x && position.y == guard_position.y) {
			continue
		}

		// create a new map and copy all entries
		lab_map := make(map[vec2]lab_map_coord)
		for k, v in original_map {
			lab_map[k] = v
		}
		defer delete(lab_map)

		// update the new position
		coord_to_update := lab_map[position]
		coord_to_update.is_obstacle = true
		lab_map[position] = coord_to_update

		if check_for_loop(lab_map, guard_position, max_x, max_y) {
			loop_count += 1
		}
	}

	return loop_count
}

check_for_loop :: proc(
	lab_map: map[vec2]lab_map_coord,
	guard_position: vec2,
	max_x, max_y: int,
) -> bool {
	guard_direction := vec2{0, -1}
	guard_pos := guard_position

	visited_states := make(map[position_state]bool)
	defer delete(visited_states)

	on_map := true

	for on_map {
		current_state := position_state{guard_pos, guard_direction}
		if visited_states[current_state] {
			return true
		}

		visited_states[current_state] = true

		for {
			next_position: vec2
			next_position.x, next_position.y =
				guard_pos.x + guard_direction.x, guard_pos.y + guard_direction.y
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

			guard_pos = next_position
		}

		// turn 90 degrees (same as before)
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

	return false
}
