package main

import "core:fmt"
import "core:testing"

trailmap_example :: []string {
	"89010123",
	"78121874",
	"87430965",
	"96549874",
	"45678903",
	"32019012",
	"01329801",
	"10456732",
}

@(test)
d10p1 :: proc(t: ^testing.T) {
	want :: 36
	got := get_sum_trailhead_scores(trailmap_example, false)
	testing.expect(t, got == want, fmt.aprintf("Got: %v | Want: %v", got, want))

	free_all()
}

@(test)
d10p2 :: proc(t: ^testing.T) {
	want :: 81
	got := get_sum_trailhead_scores(trailmap_example, true)
	testing.expect(t, got == want, fmt.aprintf("Got: %v | Want: %v", got, want))

	free_all()
}

@(test)
test_parse_trailmap :: proc(t: ^testing.T) {
	got_map, got_heads := parse_trailmap(trailmap_example)
	want_length := 64
	want_3_3 := 4
	want_7_4 := 6
	max_x := 8
	want_heads_length := 9

	testing.expect(
		t,
		len(got_map) == want_length,
		fmt.aprintf("Got: %v | Want: %v", len(got_map), want_length),
	)
	testing.expect(
		t,
		len(got_heads) == want_heads_length,
		fmt.aprintf("Got: %v | Want: %v", len(got_heads), want_heads_length),
	)
	testing.expect(
		t,
		got_map[max_x * 3 + 3] == want_3_3,
		fmt.aprintf("Got: %v | Want: %v", got_map[3 + 3], want_3_3),
	)
	testing.expect(
		t,
		got_map[max_x * 7 + 4] == want_7_4,
		fmt.aprintf("Got: %v | Want: %v", got_map[7 + 4], want_7_4),
	)

	free_all()
}
