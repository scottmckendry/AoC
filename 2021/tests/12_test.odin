package main

import "core:fmt"
import "core:slice"
import "core:testing"

caves :: []string{"start-A", "start-b", "A-c", "A-b", "b-d", "A-end", "b-end"}

@(test)
d12p1 :: proc(t: ^testing.T) {
	want := 9
	got := traverse_caves(caves, true)
	testing.expect(t, got == want, fmt.tprintf("Got: %v | Want: %v", got, want))
	free_all()
}

@(test)
d12p2 :: proc(t: ^testing.T) {
	want := 35
	got := traverse_caves(caves, false)
	testing.expect(t, got == want, fmt.tprintf("Got: %v | Want: %v", got, want))
	free_all()
}

@(test)
test_parse_caves :: proc(t: ^testing.T) {
	got := parse_caves(caves)
	want_len := 6

	testing.expect(t, len(got) == want_len, fmt.tprintf("Got: %v | Want: %v", len(got), want_len))

	// test start
	connections := got["start"].connections[:]
	testing.expect(t, got["start"].large == false, "start should be small!")
	testing.expect(
		t,
		slice.contains(connections, "A") && slice.contains(connections, "b"),
		fmt.tprintf("start should connect to A and b, got: %v", got["start"].connections),
	)

	// test A
	connections = got["A"].connections[:]
	testing.expect(t, got["A"].large == true, "A should be large!")
	testing.expect(
		t,
		slice.contains(connections, "start") &&
		slice.contains(connections, "c") &&
		slice.contains(connections, "b") &&
		slice.contains(connections, "end"),
		fmt.tprintf("A should connect to start, c, b, and end, got: %v", got["A"].connections),
	)

	// test d
	connections = got["d"].connections[:]
	testing.expect(t, got["d"].large == false, "d should be small!")
	testing.expect(
		t,
		slice.contains(connections, "b"),
		fmt.tprintf("d should connect to b! got: %v", got["d"].connections),
	)

	for cave in got {
		delete(got[cave].connections)
	}
	clear(&got)
	free_all()
}
