package main

import "core:fmt"
import "core:testing"

@(test)
d05p1 :: proc(t: ^testing.T) {
	input := []string {
		"0,9 -> 5,9",
		"8,0 -> 0,8",
		"9,4 -> 3,4",
		"2,2 -> 2,1",
		"7,0 -> 7,4",
		"6,4 -> 2,0",
		"0,9 -> 2,9",
		"3,4 -> 1,4",
		"0,0 -> 8,8",
		"5,5 -> 8,2",
	}
	want := 5
	got := get_overlapping_points(input)

	testing.expect(t, got == want, fmt.tprintf("Got: %v | Want: %v", got, want))
	free_all()
}

@(test)
d05p2 :: proc(t: ^testing.T) {
	input := []string {
		"0,9 -> 5,9",
		"8,0 -> 0,8",
		"9,4 -> 3,4",
		"2,2 -> 2,1",
		"7,0 -> 7,4",
		"6,4 -> 2,0",
		"0,9 -> 2,9",
		"3,4 -> 1,4",
		"0,0 -> 8,8",
		"5,5 -> 8,2",
	}
	want := 12
	got := get_overlapping_points_with_diagonals(input)

	testing.expect(t, got == want, fmt.tprintf("Got: %v | Want: %v", got, want))
	free_all()
}

@(test)
test_parse_vent_lines :: proc(t: ^testing.T) {
	input := []string{"0,9 -> 5,9", "420,0 -> 0,69"}
	want := [dynamic]VentLine{{Vec2{0, 9}, Vec2{5, 9}}, {Vec2{420, 0}, Vec2{0, 69}}}
	got := parse_vent_lines(input)

	testing.expect(
		t,
		len(got) == len(want),
		fmt.tprintf("Length Got: %v | Length Want: %v", len(got), len(want)),
	)

	for line, i in want {
		testing.expect(
			t,
			got[i].start.x == line.start.x &&
			got[i].end.x == line.end.x &&
			got[i].start.y == line.start.y &&
			got[i].end.y == line.end.y,
			fmt.tprintf("Got: %v | Want: %v", got[i], line),
		)
	}


	free_all()
}
