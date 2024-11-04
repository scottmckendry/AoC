package main

import "core:fmt"
import "core:testing"

@(test)
d07p1 :: proc(t: ^testing.T) {
	input := "16,1,2,0,4,2,7,1,2,14"

	want := 37
	got := least_fuel_crab_alignment(input, false)
	testing.expect(t, got == want, fmt.tprintf("Got: %v | Want: %v", got, want))

	free_all()
}

@(test)
d07p2 :: proc(t: ^testing.T) {
	input := "16,1,2,0,4,2,7,1,2,14"

	want := 168
	got := least_fuel_crab_alignment(input, true)
	testing.expect(t, got == want, fmt.tprintf("Got: %v | Want: %v", got, want))

	free_all()
}

@(test)
test_parse_crabs :: proc(t: ^testing.T) {
	input := "16,1,2,0,4,2,7,1,2,14"

	want := [dynamic]int{0, 1, 1, 2, 2, 2, 4, 7, 14, 16}
	got := parse_crabs(input)
	for crab, i in got {
		testing.expect(t, crab == want[i], fmt.tprintf("Got: %v | Want: %v", crab, want[i]))
	}

	free_all()
}
