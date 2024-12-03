package main

import "core:fmt"
import "core:strconv"
import "core:strings"

D03P1 :: proc() {
	input_string := #load("inputs/03.txt", string)
	lines := strings.split(input_string, "\n", context.temp_allocator)

	sum_of_multiplications := get_sum_of_multiplications(lines, false)
	fmt.printf("Sum of all multiplications: %d\n", sum_of_multiplications)
}

get_sum_of_multiplications :: proc(lines: []string, parse_conditionals: bool) -> int {
	number_pairs: [dynamic][2]int
	if !parse_conditionals {
		number_pairs = parse_corrupted_memory(lines)
	} else {
		number_pairs = parse_corrupted_memory_pt2(lines)
	}
	sum := 0
	for pair in number_pairs {
		sum += pair[0] * pair[1]
	}
	return sum
}

parse_corrupted_memory :: proc(corrupted_memory: []string) -> (number_pairs: [dynamic][2]int) {
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
				if valid_pair {
					append(&number_pairs, number_pair)
				}
			}

			remaining = remaining[start + 4:] // keep the rest of the string for the next iteration
		}
	}
	return number_pairs
}
