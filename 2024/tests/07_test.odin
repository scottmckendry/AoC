package main

import "core:fmt"
import "core:testing"

@(test)
d07p1 :: proc(t: ^testing.T) {
	calibration_equations := []string {
		"190: 10 19",
		"3267: 81 40 27",
		"83: 17 5",
		"156: 15 6",
		"7290: 6 8 6 15",
		"161011: 16 10 13",
		"192: 17 8 14",
		"21037: 9 7 18 13",
		"292: 11 6 16 20",
	}
	want: u64 = 3749
	got := get_sum_of_valid_calibrations(calibration_equations, false)
	testing.expect(t, got == want, fmt.aprintf("Got: %v | Want: %v", got, want))

	free_all()
}

@(test)
d07p2 :: proc(t: ^testing.T) {
	calibration_equations := []string {
		"190: 10 19",
		"3267: 81 40 27",
		"83: 17 5",
		"156: 15 6",
		"7290: 6 8 6 15",
		"161011: 16 10 13",
		"192: 17 8 14",
		"21037: 9 7 18 13",
		"292: 11 6 16 20",
	}
	want: u64 = 11387
	got := get_sum_of_valid_calibrations(calibration_equations, true)
	testing.expect(t, got == want, fmt.aprintf("Got: %v | Want: %v", got, want))

	free_all()
}
