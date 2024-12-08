package main

import "core:fmt"
import "core:strings"

D07P2 :: proc() {
	input_string := #load("inputs/07.txt", string)
	lines := strings.split(input_string, "\n", context.temp_allocator)

	calibration_sum := get_sum_of_valid_calibrations(lines, true)
	fmt.printf("Total calibration result: %d\n", calibration_sum)
}
