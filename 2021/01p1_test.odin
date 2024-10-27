package main

import "core:fmt"
import "core:mem"
import "core:testing"

@(test)
day1_example :: proc(t: ^testing.T) {
	input: [dynamic]string = {"199", "200", "208", "210", "200", "207", "240", "269", "260", "263"}

	result := get_depth_increase_count(input)
	testing.expect(
		t,
		result == 7,
		fmt.aprintf("Depth increase count failed.\nGot: %v\nWanted: %v", result, 7),
	)

	free_all()
}
