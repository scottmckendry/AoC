package main

import "core:fmt"
import "core:strings"

D02P2 :: proc() {
	input_string := #load("inputs/02.txt", string)
	lines := strings.split(input_string, "\n", context.temp_allocator)

	safe_reports := get_safe_reports(lines, true)
	fmt.printf("Number of safe reports: %d\n", safe_reports)
}
