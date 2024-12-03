package main

import "core:fmt"
import "core:testing"

@(test)
d03p1 :: proc(t: ^testing.T) {
	corrupted_memory := []string {
		"xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))",
	}
	want := 161
	got := get_sum_of_multiplications(corrupted_memory)
	testing.expect(t, got == want, fmt.aprintf("Got: %v | Want: %v", got, want))

	free_all()
}

@(test)
d03p2 :: proc(t: ^testing.T) {
	corrupted_memory := []string {
		"xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))",
	}
	want := 48
	got := get_sum_of_cond_multiplications(corrupted_memory)
	testing.expect(t, got == want, fmt.aprintf("Got: %v | Want: %v", got, want))

	free_all()
}

@(test)
test_parse_corrupted_memory :: proc(t: ^testing.T) {
	corrupted_memory := []string {
		"xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))",
	}
	want := [dynamic][2]int{{2, 4}, {5, 5}, {11, 8}, {8, 5}}
	got := parse_corrupted_memory(corrupted_memory)

	testing.expect(
		t,
		len(got) == len(want),
		fmt.aprintf("Got: %v | Want: %v", len(got), len(want)),
	)

	free_all()
}
