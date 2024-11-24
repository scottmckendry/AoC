package main

import "core:fmt"
import "core:testing"

fold_instructions := []string {
	"6,10",
	"0,14",
	"9,10",
	"0,3",
	"10,4",
	"4,11",
	"6,0",
	"6,12",
	"4,1",
	"0,13",
	"10,12",
	"3,4",
	"3,0",
	"8,4",
	"1,10",
	"2,14",
	"8,10",
	"9,0",
	"",
	"fold along y=7",
	"fold along x=5",
}

@(test)
d13p1 :: proc(t: ^testing.T) {
	want := 17
	got := fold_transparent_paper(fold_instructions, false)
	testing.expect(t, got == want, fmt.tprintf("Got: %v | Want: %v", got, want))
	free_all()
}

@(test)
test_parse_fold_instructions :: proc(t: ^testing.T) {
	got_dots, _ := parse_fold_instructions(fold_instructions)
	testing.expect(
		t,
		got_dots[0] == Vec2{6, 10},
		fmt.tprintf("Got: %v | Want: %v", got_dots[0], Vec2{6, 10}),
	)

	testing.expect(
		t,
		got_dots[4] == Vec2{10, 4},
		fmt.tprintf("Got: %v | Want: %v", got_dots[4], Vec2{10, 4}),
	)

	free_all()
}
