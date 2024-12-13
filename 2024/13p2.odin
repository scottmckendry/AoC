package main

import "core:fmt"
import "core:strings"

D13P2 :: proc() {
	input_string := #load("inputs/13.txt", string)
	lines := strings.split(input_string, "\n", context.temp_allocator)

	token_cost := get_token_cost(lines, true)
	fmt.printf("Minimum tokens to get all prizes: %d\n", token_cost)
}
