package main

import "core:fmt"
import "core:strings"

D08P2 :: proc() {
	input_string := #load("inputs/08.txt", string)
	lines := strings.split(input_string, "\n", context.temp_allocator)

	antinode_count := get_antinode_count_p2(lines[:len(lines) - 1])
	fmt.printf("Total antinodes: %d\n", antinode_count)
}

get_antinode_count_p2 :: proc(lines: []string) -> int {
	antennas := parse_antennas(lines)
	antinodes := make(map[vec2]bool)
	defer {
		for _, antennas_at_frequency in antennas {
			delete(antennas_at_frequency)
		}
		delete(antennas)
		delete(antinodes)
	}

	max_x := len(lines[0])
	max_y := len(lines)

	// pair up antennas and get vector between them
	for _, antennas_at_frequency in antennas {
		for antenna1, i in antennas_at_frequency {
			for antenna2, j in antennas_at_frequency {
				if i >= j { 	// skip duplicate pairs
					continue
				}

				// calculate vector between antennas
				vec := vec2 {
					antenna2.position.x - antenna1.position.x,
					antenna2.position.y - antenna1.position.y,
				}

				check_antinode_direction(antenna1.position, vec, &antinodes, max_x, max_y)
				check_antinode_direction(
					antenna2.position,
					vec2{-vec.x, -vec.y},
					&antinodes,
					max_x,
					max_y,
				)
			}
		}
	}

	return len(antinodes)
}

check_antinode_direction :: proc(
	start: vec2,
	vec: vec2,
	antinodes: ^map[vec2]bool,
	max_x, max_y: int,
) {
	pos := start
	for check_antinode(antinodes, pos, max_x, max_y) {
		pos.x += vec.x
		pos.y += vec.y
	}
}
