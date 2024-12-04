package main

import "core:fmt"
import "core:strings"

D04P1 :: proc() {
	input_string := #load("inputs/04.txt", string)
	lines := strings.split(input_string, "\n", context.temp_allocator)

	lines = lines[:len(lines) - 1] // remove the last empty line

	num_xmas_words := get_total_xmas_words(lines)
	fmt.printf("Total number of XMAS words: %d\n", num_xmas_words)
}

get_total_xmas_words :: proc(word_search: []string) -> int {
	total_xmas_words := 0
	// horizontal lines
	for line in word_search {
		total_xmas_words += count_matches(line, "XMAS")
	}

	// vertical lines
	for i in 0 ..< len(word_search[0]) {
		vertical_line: [dynamic]u8
		defer delete(vertical_line)
		for line in word_search {
			append(&vertical_line, line[i])
		}
		total_xmas_words += count_matches(transmute(string)vertical_line[:], "XMAS")
	}

	// Diagonal lines (top-left to bottom-right)
	for k in 0 ..< len(word_search[0]) {
		diagonal_line: [dynamic]u8
		defer delete(diagonal_line)
		row, col := 0, k
		for row < len(word_search) && col < len(word_search[0]) {
			append(&diagonal_line, word_search[row][col])
			row += 1
			col += 1
		}
		total_xmas_words += count_matches(transmute(string)diagonal_line[:], "XMAS")
	}
	for i in 1 ..< len(word_search) {
		diagonal_line: [dynamic]u8
		defer delete(diagonal_line)
		row, col := i, 0
		for row < len(word_search) && col < len(word_search[0]) {
			append(&diagonal_line, word_search[row][col])
			row += 1
			col += 1
		}
		total_xmas_words += count_matches(transmute(string)diagonal_line[:], "XMAS")
	}

	// Diagonal lines (top-right to bottom-left)
	for k in 0 ..< len(word_search[0]) {
		diagonal_line: [dynamic]u8
		defer delete(diagonal_line)
		row, col := 0, k
		for row < len(word_search) && col >= 0 {
			append(&diagonal_line, word_search[row][col])
			row += 1
			col -= 1
		}
		total_xmas_words += count_matches(transmute(string)diagonal_line[:], "XMAS")
	}
	for i in 1 ..< len(word_search) {
		diagonal_line: [dynamic]u8
		defer delete(diagonal_line)
		row, col := i, len(word_search[0]) - 1
		for row < len(word_search) && col >= 0 {
			append(&diagonal_line, word_search[row][col])
			row += 1
			col -= 1
		}
		total_xmas_words += count_matches(transmute(string)diagonal_line[:], "XMAS")
	}

	return total_xmas_words
}

count_matches :: proc(search_string: string, word: string) -> int {
	count := 0
	reversed := strings.reverse(search_string, context.temp_allocator)

	for _, i in 0 ..< len(search_string) {
		if strings.has_prefix(search_string[i:], word) {
			count += 1
		}

		if strings.has_prefix(reversed[i:], word) {
			count += 1
		}
	}

	return count
}
