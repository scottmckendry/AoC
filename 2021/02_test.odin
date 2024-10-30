package main

import "core:fmt"
import "core:mem"
import "core:testing"

@(test)
d02p1 :: proc(t: ^testing.T) {
	input: []string = {"forward 5", "down 5", "forward 8", "up 3", "down 8", "forward 2"}
	got := parse_directions(input)
	want := 150
	testing.expect(t, got == want, fmt.aprintf("Got: %v | Want: %v", got, want))

	free_all()
}

@(test)
d02p2 :: proc(t: ^testing.T) {
	input: []string = {"forward 5", "down 5", "forward 8", "up 3", "down 8", "forward 2"}
	got := parse_submarine_instructions(input)
	want := 900
	testing.expect(t, got == want, fmt.aprintf("Got: %v | Want: %v", got, want))

	free_all()
}
