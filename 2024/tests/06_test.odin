package main

import "core:fmt"
import "core:testing"

@(test)
d06p1 :: proc(t: ^testing.T) {
	lab_map := []string {
		"....#.....",
		".........#",
		"..........",
		"..#.......",
		".......#..",
		"..........",
		".#..^.....",
		"........#.",
		"#.........",
		"......#...",
	}
	want := 41
	got := get_unique_guard_positions(lab_map)
	testing.expect(t, got == want, fmt.aprintf("Got: %v | Want: %v", got, want))

	free_all()
}

@(test)
d06p2 :: proc(t: ^testing.T) {
	lab_map := []string {
		"....#.....",
		".........#",
		"..........",
		"..#.......",
		".......#..",
		"..........",
		".#..^.....",
		"........#.",
		"#.........",
		"......#...",
	}
	want := 6
	got := get_loop_causing_obstacles(lab_map)
	testing.expect(t, got == want, fmt.aprintf("Got: %v | Want: %v", got, want))

	free_all()
}

test_parse_lab_map :: proc(t: ^testing.T) {
	lab_map := []string {
		"....#.....",
		".........#",
		"..........",
		"..#.......",
		".......#..",
		"..........",
		".#..^.....",
		"........#.",
		"#.........",
		"......#...",
	}
	got_lab_map_coords, got_guard_position, _, _ := parse_lab_map(lab_map)
	want_guard_position := vec2{4, 6}
	example_obtacle := vec2{4, 0}

	testing.expect(
		t,
		got_guard_position == want_guard_position,
		fmt.aprintf("Got: %v | Want: %v", got_guard_position, want_guard_position),
	)

	testing.expect(
		t,
		got_lab_map_coords[example_obtacle].is_obstacle,
		fmt.aprintf("Got: %v | Want: %v", got_lab_map_coords[example_obtacle].is_obstacle, true),
	)

	free_all()
}
