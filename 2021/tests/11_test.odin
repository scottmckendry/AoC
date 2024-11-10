package main

import "core:fmt"
import "core:testing"

octopi_engery_levels :: []string {
	"5483143223",
	"2745854711",
	"5264556173",
	"6141336146",
	"6357385478",
	"4167524645",
	"2176841721",
	"6882881134",
	"4846848554",
	"5283751526",
}

@(test)
d11p1 :: proc(t: ^testing.T) {
	want := 1656
	got := get_octopi_energy_flashes(octopi_engery_levels, 100)
	testing.expect(t, got == want, fmt.tprintf("Got: %v | Want: %v", got, want))
}

@(test)
d11p2 :: proc(t: ^testing.T) {
	want := 195
	got := get_all_octopi_flash_step(octopi_engery_levels)
	testing.expect(t, got == want, fmt.tprintf("Got: %v | Want: %v", got, want))
}

@(test)
test_parse_octopi_enegy_levels :: proc(t: ^testing.T) {
	want_map := map[Vec2]int {
		{0, 5} = 4,
		{3, 0} = 6,
		{6, 9} = 1,
		{9, 2} = 8,
	}

	got := parse_octopi_energy_levels(octopi_engery_levels)
	for key, value in want_map {
		testing.expect(
			t,
			got[key.x][key.y] == value,
			fmt.tprintf("Incorect value at %v: Got: %v | Want: %v", key, got[key.x][key.y], value),
		)
	}

	free_all()
}

@(test)
test_octopi_state_at_step :: proc(t: ^testing.T) {
	energy_levels := parse_octopi_energy_levels(octopi_engery_levels)
	want_flashes := 0
	got_flashes := simulate_octopus_step(&energy_levels)

	want_map := map[Vec2]int {
		{0, 2} = 9,
		{4, 3} = 8,
	}
	for key, value in want_map {
		testing.expect(
			t,
			energy_levels[key.x][key.y] == value,
			fmt.tprintf(
				"Incorect value at %v: Got: %v | Want: %v",
				key,
				energy_levels[key.x][key.y],
				value,
			),
		)
	}

	testing.expect(
		t,
		got_flashes == want_flashes,
		fmt.tprintf("Got: %v | Want: %v", got_flashes, want_flashes),
	)

	// add another step
	want_flashes = 35
	got_flashes = simulate_octopus_step(&energy_levels)

	want_map = map[Vec2]int {
		{0, 2} = 0,
		{4, 3} = 0,
	}
	for key, value in want_map {
		testing.expect(
			t,
			energy_levels[key.x][key.y] == value,
			fmt.tprintf(
				"Incorect value at %v: Got: %v | Want: %v",
				key,
				energy_levels[key.x][key.y],
				value,
			),
		)
	}

	testing.expect(
		t,
		got_flashes == want_flashes,
		fmt.tprintf("Got: %v | Want: %v", got_flashes, want_flashes),
	)

	free_all()
}
