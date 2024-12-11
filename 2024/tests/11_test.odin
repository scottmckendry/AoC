package main

import "core:fmt"
import "core:testing"

@(test)
d11p1 :: proc(t: ^testing.T) {
	example := "125 17"
	want :: 55312
	got := simulate_stones(example, 25)
	testing.expect(t, got == want, fmt.aprintf("Got: %v | Want: %v", got, want))

	free_all()
}

@(test)
test_simulate_blink :: proc(t: ^testing.T) {
	example := "125, 17"
	parsed := parse_stones(example)
	got := simulate_blink(parsed)

	want_7 :: 1

	testing.expect(t, got[7] == want_7, fmt.aprintf("Got: %v | Want: %v", got[7], want_7))

	example = "1036288 7 2 20 24 4048 1 4048 8096 28 67 60 32"
	parsed = parse_stones(example)
	got = simulate_blink(parsed)

	want_0 :: 2

	testing.expect(t, got[0] == want_0, fmt.aprintf("Got: %v | Want: %v", got[0], want_0))

	free_all()
}
