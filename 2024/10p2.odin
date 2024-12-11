package main

import "core:fmt"
import "core:strings"

D10P2 :: proc() {
	input_string := #load("inputs/10.txt", string)
	lines := strings.split(input_string, "\n", context.temp_allocator)

	sum_trailhead_scores := get_sum_trailhead_scores(lines, true)
	fmt.printf("Sum of all trailhead scores: %d\n", sum_trailhead_scores)
}
