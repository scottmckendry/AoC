package main

import "core:fmt"
import "core:strings"

D08P1 :: proc() {
	input_string := #load("./inputs/08.txt", string)
	lines := strings.split(input_string, "\n", context.temp_allocator)

	unique_digits := count_unique_output_digits(lines)
	fmt.printfln("Number of unique digits in output: %v", unique_digits)
}

count_unique_output_digits :: proc(input: []string) -> int {
	unique_digits := 0
	for line in input {
		if line == "" {
			continue
		}

		output := strings.split(line, "|", context.temp_allocator)[1]
		digit_strings := strings.split(output, " ", context.temp_allocator)
		for digit_str in digit_strings {
			switch len(digit_str) {
			case 2, 3, 4, 7:
				unique_digits += 1
			}
		}
	}
	return unique_digits
}
