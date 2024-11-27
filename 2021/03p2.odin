package main

import "core:fmt"
import "core:strconv"
import "core:strings"

D03P2 :: proc() {
	input_string := #load("./inputs/03.txt", string)
	lines := strings.split(input_string, "\n", context.temp_allocator)
	lines = lines[:len(lines) - 1]

	life_support_rating :=
		calculate_generator_scrubber_rating(lines, false) *
		calculate_generator_scrubber_rating(lines, true)

	fmt.printfln("Life support rating: %v", life_support_rating)
}

calculate_generator_scrubber_rating :: proc(input: []string, co2: bool) -> int {
	dyn_input: [dynamic]string
	defer delete(dyn_input)

	append(&dyn_input, ..input[:])

	for i := 0; i < len(input[0]); i += 1 {
		if len(dyn_input) == 1 {
			break
		}

		zero_indexes := [dynamic]int{}
		one_indexes := [dynamic]int{}

		defer {
			delete(zero_indexes)
			delete(one_indexes)
		}

		for line, j in &dyn_input {
			if line[i] == '0' {
				append(&zero_indexes, j)
			} else {
				append(&one_indexes, j)
			}
		}

		removed := 0
		remove_at := zero_indexes
		if len(zero_indexes) > len(one_indexes) {
			remove_at = one_indexes
		}

		if co2 {
			if len(zero_indexes) > len(one_indexes) {
				remove_at = zero_indexes
			} else {
				remove_at = one_indexes
			}
		}

		for index in remove_at {
			ordered_remove(&dyn_input, index - removed)
			removed += 1
		}
	}

	remaining, _ := strconv.parse_uint(dyn_input[0], 2)
	return int(remaining)
}
