package main

import "core:fmt"
import "core:testing"

@(test)
d02p1 :: proc(t: ^testing.T) {
	reports := []string {
		"7 6 4 2 1",
		"1 2 7 8 9",
		"9 7 6 2 1",
		"1 3 2 4 5",
		"8 6 4 4 1",
		"1 3 6 7 9",
	}
	want := 2
	got := get_safe_reports(reports, false)
	testing.expect(t, got == want, fmt.aprintf("Got: %v | Want: %v", got, want))

	free_all()
}

@(test)
d02p2 :: proc(t: ^testing.T) {
	reports := []string {
		"7 6 4 2 1",
		"1 2 7 8 9",
		"9 7 6 2 1",
		"1 3 2 4 5",
		"8 6 4 4 1",
		"1 3 6 7 9",
	}
	want := 4
	got := get_safe_reports(reports, true)
	testing.expect(t, got == want, fmt.aprintf("Got: %v | Want: %v", got, want))

	free_all()
}

@(test)
test_is_safe_report :: proc(t: ^testing.T) {
	test_cases := []struct {
		input:    [dynamic]int,
		want:     bool,
		dampener: bool,
	} {
		{[dynamic]int{1, 3, 6, 7, 9}, true, false},
		{[dynamic]int{8, 6, 4, 4, 1}, false, false},
		{[dynamic]int{1, 3, 2, 4, 5}, true, true},
		{[dynamic]int{1, 2, 7, 8, 9}, false, true},
	}

	for test, i in test_cases {
		got := is_safe_report(test.input, test.dampener)
		testing.expect(
			t,
			got == test.want,
			fmt.aprintf("Test case at index %v failed. Got: %v | Want: %v", i, got, test.want),
		)
	}
	free_all()
}

@(test)
test_check_sequence :: proc(t: ^testing.T) {
	test_cases := []struct {
		input: [dynamic]int,
		want:  bool,
	} {
		{[dynamic]int{1, 3, 6, 7, 9}, true},
		{[dynamic]int{8, 6, 4, 4, 1}, false},
		{[dynamic]int{1, 3, 2, 4, 5}, false},
		{[dynamic]int{7, 6, 4, 2, 1}, true},
	}

	for test, i in test_cases {
		got := check_sequence(test.input)
		testing.expect(
			t,
			got == test.want,
			fmt.aprintf("Test case at index %v failed. Got: %v | Want: %v", i, got, test.want),
		)
	}
	free_all()
}
