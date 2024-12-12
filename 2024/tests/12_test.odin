package main

import "core:fmt"
import "core:testing"

garden_example :: []string {
	"RRRRIICCFF",
	"RRRRIICCCF",
	"VVRRRCCFFF",
	"VVRCCCJFFF",
	"VVVVCJJCFE",
	"VVIVCCJJEE",
	"VVIIICJJEE",
	"MIIIIIJJEE",
	"MIIISIJEEE",
	"MMMISSJEEE",
}

@(test)
d12p1 :: proc(t: ^testing.T) {
	want :: 1930
	got := get_garden_fencing_cost(garden_example)
	testing.expect(t, got == want, fmt.aprintf("Got: %v | Want: %v", got, want))

	free_all()
}

@(test)
d12p2 :: proc(t: ^testing.T) {
	want :: 1206
	got := get_garden_fencing_cost_p2(garden_example)
	testing.expect(t, got == want, fmt.aprintf("Got: %v | Want: %v", got, want))

	free_all()
}

@(test)
test_parse_garden :: proc(t: ^testing.T) {
	got := parse_garden(garden_example)

	want2_3 :: 'R'
	want5_6 :: 'J'

	testing.expect(t, got[2][3] == want2_3, fmt.aprintf("Got: %v | Want: %v", got[2][3], want2_3))
	testing.expect(t, got[5][6] == want5_6, fmt.aprintf("Got: %v | Want: %v", got[5][6], want5_6))

	free_all()
}
