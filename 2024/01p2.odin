package main

import "core:fmt"
import "core:strings"

D01P2 :: proc() {
	input_string := #load("inputs/01.txt", string)
	lines := strings.split(input_string, "\n", context.temp_allocator)

	similarity_score := get_list_similarity_score(lines)
	fmt.printf("List similarity score: %d\n", similarity_score)
}

get_list_similarity_score :: proc(lines: []string) -> int {
	left, right := parse_number_pairs(lines)
	defer delete(left)
	defer delete(right)

	similarity_score := 0
	for num in left {
		count := 0
		for num2 in right {
			if num == num2 {
				count += 1
			}
		}

		similarity_score += num * count
	}

	return similarity_score
}
