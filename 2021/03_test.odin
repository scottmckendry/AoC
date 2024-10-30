package main

import "core:fmt"
import "core:mem"
import "core:testing"

@(test)
d03p1 :: proc(t: ^testing.T) {
	input: []string = {
		"00100",
		"11110",
		"10110",
		"10111",
		"10101",
		"01111",
		"00111",
		"11100",
		"10000",
		"11001",
		"00010",
		"01010",
	}
	got := calculate_power_consumption(input)
	want := 198
	testing.expect(t, got == want, fmt.aprintf("Got: %v | Want: %v", got, want))

	free_all()
}

@(test)
d03p2 :: proc(t: ^testing.T) {
	input: []string = {
		"00100",
		"11110",
		"10110",
		"10111",
		"10101",
		"01111",
		"00111",
		"11100",
		"10000",
		"11001",
		"00010",
		"01010",
	}
	got := calculate_generator_scrubber_rating(input, false)
	want := 23
	testing.expect(t, got == want, fmt.aprintf("Got: %v | Want: %v", got, want))

	got = calculate_generator_scrubber_rating(input, true)
	want = 10
	testing.expect(t, got == want, fmt.aprintf("Got: %v | Want: %v", got, want))

	free_all()
}
