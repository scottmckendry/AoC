package main

import "core:fmt"
import "core:mem"
import "core:testing"

@(test)
d04p1 :: proc(t: ^testing.T) {
	input: []string = {
		"7,4,9,5,11,17,23,2,0,14,21,24,10,16,13,6,15,25,12,22,18,20,8,19,3,26,1",
		"",
		"22 13 17 11  0",
		" 8  2 23  4 24",
		"21  9 14 16  7",
		" 6 10  3 18  5",
		" 1 12 20 15 19",
		"",
		" 3 15  0  2 22",
		" 9 18 13 17  5",
		"19  8  7 25 23",
		"20 11 10 24  4",
		"14 21 16 12  6",
		"",
		"14 21 17 24  4",
		"10 16 15  9 19",
		"18  8 23 26 20",
		"22 11 13  6  5",
		" 2  0 12  3  7",
	}
	got := get_winning_bingo_score(input)
	want := 4512
	testing.expect(t, got == want, fmt.aprintf("Got: %v | Want: %v", got, want))

	free_all()
}

@(test)
d04p2 :: proc(t: ^testing.T) {
	input: []string = {
		"7,4,9,5,11,17,23,2,0,14,21,24,10,16,13,6,15,25,12,22,18,20,8,19,3,26,1",
		"",
		"22 13 17 11  0",
		" 8  2 23  4 24",
		"21  9 14 16  7",
		" 6 10  3 18  5",
		" 1 12 20 15 19",
		"",
		" 3 15  0  2 22",
		" 9 18 13 17  5",
		"19  8  7 25 23",
		"20 11 10 24  4",
		"14 21 16 12  6",
		"",
		"14 21 17 24  4",
		"10 16 15  9 19",
		"18  8 23 26 20",
		"22 11 13  6  5",
		" 2  0 12  3  7",
	}
	got := get_last_bingo_winner_score(input)
	want := 1924
	testing.expect(t, got == want, fmt.aprintf("Got: %v | Want: %v", got, want))

	free_all()
}

@(test)
test_parse_bingo_drawings :: proc(t: ^testing.T) {
	input: []string = {"7,4,9,5,11"}
	got := parse_bingo_drawings(input)
	want := [dynamic]int{7, 4, 9, 5, 11}

	matching := true
	for v, i in got {
		if v != want[i] {
			matching = false
			break
		}
	}

	testing.expect(t, matching, fmt.aprintf("Got: %v | Want: %v", got, want))

	free_all()
}

test_parse_bingo_card :: proc(t: ^testing.T) {
	input: []string = {
		"22 13 17 11  0",
		" 8  2 23  4 24",
		"21  9 14 16  7",
		" 6 10  3 18  5",
		" 1 12 20 15 19",
	}

	got := parse_bingo_card(input)
	matching := got.numbers[2][2].number == 14
	matching = matching && got.numbers[4][4].number == 19

	testing.expect(
		t,
		matching,
		fmt.aprintf(
			"Wanted 14, got %v | Wanted 19, got %v",
			got.numbers[2][2].number,
			got.numbers[4][4].number,
		),
	)
}
