package main

import "core:fmt"
import "core:testing"

@(test)
d08p1 :: proc(t: ^testing.T) {
	antenna_map := []string {
		"............",
		"........0...",
		".....0......",
		".......0....",
		"....0.......",
		"......A.....",
		"............",
		"............",
		"........A...",
		".........A..",
		"............",
		"............",
	}
	want := 14
	got := get_antinode_count(antenna_map)
	testing.expect(t, got == want, fmt.aprintf("Got: %v | Want: %v", got, want))

	free_all()
}

@(test)
d08p2 :: proc(t: ^testing.T) {
	antenna_map := []string {
		"............",
		"........0...",
		".....0......",
		".......0....",
		"....0.......",
		"......A.....",
		"............",
		"............",
		"........A...",
		".........A..",
		"............",
		"............",
	}
	want := 34
	got := get_antinode_count_p2(antenna_map)
	testing.expect(t, got == want, fmt.aprintf("Got: %v | Want: %v", got, want))

	free_all()
}

@(test)
test_parse_antennas :: proc(t: ^testing.T) {
	antenna_map := []string {
		"............",
		"........0...",
		".....0......",
		".......0....",
		"....0.......",
		"......A.....",
		"............",
		"............",
		"........A...",
		".........A..",
		"............",
		"............",
	}
	got := parse_antennas(antenna_map)
	want_A0 := antenna{vec2{6, 5}, 'A'}
	want_03 := antenna{vec2{4, 4}, '0'}

	testing.expect(
		t,
		got['A'][0] == want_A0,
		fmt.aprintf("Got: %v | Want: %v", got['A'][0], want_A0),
	)
	testing.expect(
		t,
		got['0'][3] == want_03,
		fmt.aprintf("Got: %v | Want: %v", got['0'][3], want_03),
	)


	free_all()
}
