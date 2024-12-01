package main

import "core:fmt"
import "core:testing"

@(test)
d01p1 :: proc(t: ^testing.T) {
	number_pairs := []string{"3   4", "4   3", "2   5", "1   3", "3   9", "3   3"}
	want := 11
	got := get_total_distance_between_pairs(number_pairs)
	testing.expect(t, got == want, fmt.aprintf("Got: %v | Want: %v", got, want))

	free_all()
}

@(test)
d01p2 :: proc(t: ^testing.T) {
	number_pairs := []string{"3   4", "4   3", "2   5", "1   3", "3   9", "3   3"}
	want := 31
	got := get_list_similarity_score(number_pairs)
	testing.expect(t, got == want, fmt.aprintf("Got: %v | Want: %v", got, want))

	free_all()
}

@(test)
test_parse_number_pairs :: proc(t: ^testing.T) {
	number_pairs := []string{"3   4", "4   3", "2   5", "1   3", "3   9", "3   3"}
	want_left := []int{3, 4, 2, 1, 3, 3}
	want_right := []int{4, 3, 5, 3, 9, 3}
	left, right := parse_number_pairs(number_pairs)
	testing.expect(
		t,
		left[2] == want_left[2],
		fmt.aprintf("Got: %v | Want: %v", left[2], want_left[2]),
	)

	testing.expect(
		t,
		right[4] == want_right[4],
		fmt.aprintf("Got: %v | Want: %v", right[4], want_right[4]),
	)

	free_all()
}
