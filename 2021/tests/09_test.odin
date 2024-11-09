package main

import "core:fmt"
import "core:testing"

heightmap :: []string{"2199943210", "3987894921", "9856789892", "8767896789", "9899965678"}

@(test)
d09p1 :: proc(t: ^testing.T) {
	want := 15
	got := get_risk_levels(heightmap)
	testing.expect(t, got == want, fmt.tprintf("Got: %v | Want: %v", got, want))
}

@(test)
d09p2 :: proc(t: ^testing.T) {
	want := 1134
	got := get_product_of_basin_sizes(heightmap)
	testing.expect(t, got == want, fmt.tprintf("Got: %v | Want: %v", got, want))
}

@(test)
test_parse_heightmap :: proc(t: ^testing.T) {
	want := [dynamic]int {
		2,
		1,
		9,
		9,
		9,
		4,
		3,
		2,
		1,
		0,
		3,
		9,
		8,
		7,
		8,
		9,
		4,
		9,
		2,
		1,
		9,
		8,
		5,
		6,
		7,
		8,
		9,
		8,
		9,
		2,
		8,
		7,
		6,
		7,
		8,
		9,
		6,
		7,
		8,
		9,
		9,
		8,
		9,
		9,
		9,
		6,
		5,
		6,
		7,
		8,
	}
	got := parse_heightmap(heightmap)

	for coord, i in want {
		testing.expect(
			t,
			got[i] == coord,
			fmt.tprintf("Incorrect value at index %v: Got: %v | Want: %v", i, got[i], coord),
		)
	}

	free_all()
}

@(test)
test_get_low_points :: proc(t: ^testing.T) {
	want := [dynamic]int{1, 9, 22, 46}
	got := get_low_points(parse_heightmap(heightmap), 5, 10)

	for coord, i in want {
		testing.expect(
			t,
			got[i] == coord,
			fmt.tprintf("Incorrect value at index %v: Got: %v | Want: %v", i, got[i], coord),
		)
	}

	free_all()
}
