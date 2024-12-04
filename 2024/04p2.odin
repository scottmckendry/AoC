package main

import "core:fmt"
import "core:strings"

D04P2 :: proc() {
	input_string := #load("inputs/04.txt", string)
	lines := strings.split(input_string, "\n", context.temp_allocator)

	lines = lines[:len(lines) - 1] // remove the last empty line

	num_X_mas_words := get_total_X_mas_words(lines)
	fmt.printf("Total number of XMAS words: %d\n", num_X_mas_words)
}

get_total_X_mas_words :: proc(word_search: []string) -> int {
	total_X_mas_words := 0

	for line, x in word_search {
		for char, y in line {
			if char == 'A' {
				// check bounds
				if x == 0 || x == len(word_search) - 1 || y == 0 || y == len(line) - 1 {
					continue
				}

				top_left := word_search[x - 1][y - 1]
				top_right := word_search[x - 1][y + 1]
				bottom_left := word_search[x + 1][y - 1]
				bottom_right := word_search[x + 1][y + 1]

				// Check all valid patterns
				if (top_left == 'M' &&
					   top_right == 'M' &&
					   bottom_left == 'S' &&
					   bottom_right == 'S') ||
				   (top_left == 'S' &&
						   top_right == 'S' &&
						   bottom_left == 'M' &&
						   bottom_right == 'M') ||
				   (top_left == 'M' &&
						   top_right == 'S' &&
						   bottom_left == 'M' &&
						   bottom_right == 'S') ||
				   (top_left == 'S' &&
						   top_right == 'M' &&
						   bottom_left == 'S' &&
						   bottom_right == 'M') {
					total_X_mas_words += 1
				}
			}
		}
	}

	return total_X_mas_words
}
