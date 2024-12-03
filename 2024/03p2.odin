package main

import "core:fmt"
import "core:strconv"
import "core:strings"

D03P2 :: proc() {
	input_string := #load("inputs/03.txt", string)
	lines := strings.split(input_string, "\n", context.temp_allocator)

	sum_of_multiplications := get_sum_of_multiplications(lines, true)
	fmt.printf("Sum of all multiplications: %d\n", sum_of_multiplications)
}


parse_corrupted_memory_pt2 :: proc(corrupted_memory: []string) -> (number_pairs: [dynamic][2]int) {
	can_do := true
	for line in corrupted_memory {
		remaining := line
		for len(remaining) > 0 {

			start := strings.index(remaining, "mul(")
			if start == -1 {
				break
			}

			start += 4 // skip over "mul("
			end := strings.index(remaining[start:], ")")
			if end == -1 {
				break
			}

			pair := strings.split(remaining[start:start + end], ",", context.temp_allocator)

			// make sure only two values were found
			if len(pair) == 2 {
				condition_index, is_do := get_next_condition(remaining, start)
				if condition_index != -1 {
					// make sure the condition is before the current pair if it needs to be applied
					if condition_index < start {
						can_do = is_do
					}
				}

				number_pair := [2]int{}
				valid_pair := true
				for str, i in pair {
					num, ok := strconv.parse_int(str)
					if !ok {
						valid_pair = false
						break
					}
					number_pair[i] = num
				}
				if valid_pair && can_do {
					append(&number_pairs, number_pair)
				}
			}

			remaining = remaining[start + 4:] // keep the rest of the string for the next iteration
		}
	}
	return number_pairs
}

get_next_condition :: proc(remaining: string, mul_position: int) -> (index: int, is_do: bool) {
	// Look only at the substring before the mul() position
	search_area := remaining[:mul_position]

	do_index := strings.last_index(search_area, "do()")
	dont_index := strings.last_index(search_area, "don't()")

	if do_index == -1 && dont_index == -1 {
		return -1, false
	}

	if do_index == -1 {
		return dont_index, false
	}

	if dont_index == -1 {
		return do_index, true
	}

	// Return the one that appears last (closest to mul)
	if do_index > dont_index {
		return do_index, true
	}

	return dont_index, false
}
