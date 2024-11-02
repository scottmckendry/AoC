package main

import "core:fmt"
import "core:testing"

@(test)
d06p1 :: proc(t: ^testing.T) {
	input := "3,4,3,1,2"

	want := 26
	got := simulate_lanterfish_growth(input, 18)
	testing.expect(t, got == want, fmt.tprintf("Got: %v | Want: %v", got, want))

	want = 5934
	got = simulate_lanterfish_growth(input, 80)
	testing.expect(t, got == want, fmt.tprintf("Got: %v | Want: %v", got, want))

	free_all()
}

//@(test)
//d06p2 :: proc(t: ^testing.T) {
//	input := "3,4,3,1,2"
//
//	want := 26984457539
//	got := simulate_lanterfish_growth(input, 256)
//	testing.expect(t, got == want, fmt.tprintf("Got: %v | Want: %v", got, want))
//
//	free_all()
//}

@(test)
test_parse_laternfish :: proc(t: ^testing.T) {
	input := "3,4,3,1,2"
	want := [dynamic]int{3, 4, 3, 1, 2}
	got := parse_lanterfish(input)

	for fish, i in got {
		testing.expect(t, fish == want[i], fmt.tprintf("Got: %v | Want: %v", fish, want[i]))
	}

	free_all()
}

@(test)
test_simulate_laternfish_day :: proc(t: ^testing.T) {
	fish := [dynamic]int{2, 3, 2, 0, 1}
	want := [dynamic]int{1, 2, 1, 6, 0, 8}

	simulate_lanternfish_day(&fish)

	for i in 0 ..< len(fish) {
		testing.expect(t, fish[i] == want[i], fmt.tprintf("Got: %v | Want: %v", fish[i], want[i]))
	}

	free_all()
}
