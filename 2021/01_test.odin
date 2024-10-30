package main

import "core:fmt"
import "core:mem"
import "core:testing"


@(test)
d01p1 :: proc(t: ^testing.T) {
	input: []string = {"199", "200", "208", "210", "200", "207", "240", "269", "260", "263"}
	got := get_depth_increase_count(input)
	want := 7
	testing.expect(t, got == want, fmt.aprintf("Got: %v | Want: %v", got, want))

	free_all()
}

@(test)
d01p2 :: proc(t: ^testing.T) {
	input: []string = {"199", "200", "208", "210", "200", "207", "240", "269", "260", "263"}
	got := get_depth_increase_count_windowed(input)
	want := 5
	testing.expect(t, got == want, fmt.aprintf("Got: %v | Want: %v", got, want))

	free_all()
}
