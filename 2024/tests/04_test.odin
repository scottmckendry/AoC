package main

import "core:fmt"
import "core:testing"

@(test)
d04p1 :: proc(t: ^testing.T) {
	word_search := []string {
		"MMMSXXMASM",
		"MSAMXMSMSA",
		"AMXSXMAAMM",
		"MSAMASMSMX",
		"XMASAMXAMM",
		"XXAMMXXAMA",
		"SMSMSASXSS",
		"SAXAMASAAA",
		"MAMMMXMMMM",
		"MXMXAXMASX",
	}
	want := 18
	got := get_total_xmas_words(word_search)
	testing.expect(t, got == want, fmt.aprintf("Got: %v | Want: %v", got, want))

	free_all()
}

@(test)
d04p2 :: proc(t: ^testing.T) {
	word_search := []string {
		"MMMSXXMASM",
		"MSAMXMSMSA",
		"AMXSXMAAMM",
		"MSAMASMSMX",
		"XMASAMXAMM",
		"XXAMMXXAMA",
		"SMSMSASXSS",
		"SAXAMASAAA",
		"MAMMMXMMMM",
		"MXMXAXMASX",
	}
	want := 9
	got := get_total_X_mas_words(word_search)
	testing.expect(t, got == want, fmt.aprintf("Got: %v | Want: %v", got, want))

	free_all()
}


@(test)
test_count_word_matches :: proc(t: ^testing.T) {
	search_string := "XMASAMXAMM"
	word := "XMAS"
	want := 2
	got := count_matches(search_string, word)
	testing.expect(t, got == want, fmt.aprintf("Got: %v | Want: %v", got, want))

	free_all()
}
