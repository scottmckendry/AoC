package main

import "core:fmt"
import "core:strings"

direction :: struct {
	dx, dy: int,
}

D04P1 :: proc() {
	input_string := #load("inputs/04.txt", string)
	lines := strings.split(input_string, "\n", context.temp_allocator)

	lines = lines[:len(lines) - 1] // remove the last empty line

	num_xmas_words := get_total_xmas_words(lines)
	fmt.printf("Total number of XMAS words: %d\n", num_xmas_words)
}

get_total_xmas_words :: proc(word_search: []string) -> int {
	directions := []direction {
		{0, 1}, // horizontal
		{1, 0}, // vertical
		{1, 1}, // diagonal top-left to bottom-right
		{1, -1}, // diagonal top-right to bottom-left
	}

	total := 0
	height := len(word_search)
	width := len(word_search[0])

	for dir in directions {
		for y in 0 ..< height {
			for x in 0 ..< width {
				// check bounds for space to fit "XMAS"
				diff_x, diff_y := dir.dx * 3, dir.dy * 3
				if x + diff_x >= width ||
				   x + diff_x < 0 ||
				   y + diff_y >= height ||
				   y + diff_y < 0 {
					continue
				}

				// check forwards first
				if word_search[y][x] == 'X' &&
				   word_search[y + dir.dy][x + dir.dx] == 'M' &&
				   word_search[y + dir.dy * 2][x + dir.dx * 2] == 'A' &&
				   word_search[y + dir.dy * 3][x + dir.dx * 3] == 'S' {
					total += 1
					continue
				}

				// and then check backwards
				if word_search[y][x] == 'S' &&
				   word_search[y + dir.dy][x + dir.dx] == 'A' &&
				   word_search[y + dir.dy * 2][x + dir.dx * 2] == 'M' &&
				   word_search[y + dir.dy * 3][x + dir.dx * 3] == 'X' {
					total += 1
				}
			}
		}
	}
	return total
}
