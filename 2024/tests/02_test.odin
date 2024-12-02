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
	want := true
	got := is_safe_report([dynamic]int{1, 3, 6, 7, 9}, false)
	testing.expect(t, got == want, fmt.aprintf("Got: %v | Want: %v", got, want))

	want = false
	got = is_safe_report([dynamic]int{8, 6, 4, 4, 1}, false)
	testing.expect(t, got == want, fmt.aprintf("Got: %v | Want: %v", got, want))

	want = true
	got = is_safe_report([dynamic]int{1, 3, 2, 4, 5}, true)
	testing.expect(t, got == want, fmt.aprintf("Got: %v | Want: %v", got, want))

	free_all()
}

@(test)
test_check_sequence :: proc(t: ^testing.T) {
	want := true
	got := check_sequence([dynamic]int{1, 3, 6, 7, 9})
	testing.expect(t, got == want, fmt.aprintf("Got: %v | Want: %v", got, want))

	want = false
	got = check_sequence([dynamic]int{8, 6, 4, 4, 1})
	testing.expect(t, got == want, fmt.aprintf("Got: %v | Want: %v", got, want))

	want = false
	got = check_sequence([dynamic]int{1, 3, 2, 4, 5})
	testing.expect(t, got == want, fmt.aprintf("Got: %v | Want: %v", got, want))

	free_all()
}
