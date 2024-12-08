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
	antinodes := [dynamic]vec2{}
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
				if i == j {
					continue
				}

				// calculate vector between antennas
				vec := vec2 {
					antenna2.position.x - antenna1.position.x,
					antenna2.position.y - antenna1.position.y,
				}

				// simplify the vector (if possible) e.g. (1, 2) -> (1, 2), (2, 4) -> (1, 2)
				vec = simplify_vector(vec)

				// first check all valid antinodes by adding the vector to the first antenna
				in_bounds := true
				pos := vec2{antenna1.position.x + vec.x, antenna1.position.y + vec.y}
				for in_bounds {
					in_bounds = check_antinode(&antinodes, pos, max_x, max_y)
					pos.x += vec.x
					pos.y += vec.y
				}

				// then check all valid antinodes by subtracting the vector from the second antenna 
				// this ensures that any nodes inbetween the two antennas are counted
				in_bounds = true
				pos = vec2{antenna2.position.x, antenna2.position.y}
				for in_bounds {
					in_bounds = check_antinode(&antinodes, pos, max_x, max_y)
					pos.x -= vec.x
					pos.y -= vec.y
				}
			}
		}
	}

	return len(antinodes)
}

simplify_vector :: proc(vec: vec2) -> vec2 {
	vec_copy := vec
	// find the greatest common divisor of the vector components
	gcd := find_gcd(vec.x, vec.y)

	// simplify the vector
	vec_copy.x /= gcd
	vec_copy.y /= gcd

	return vec
}

find_gcd :: proc(a, b: int) -> int {
	a_copy := a
	b_copy := b

	for b_copy != 0 {
		a_copy, b_copy = b_copy, a_copy % b_copy
	}

	return a
}
