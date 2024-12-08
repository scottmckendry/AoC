package main

import "core:fmt"
import "core:strings"

antenna :: struct {
    position: vec2,
    frequency: rune,
}

D08P1 :: proc() {
	input_string := #load("inputs/08.txt", string)
	lines := strings.split(input_string, "\n", context.temp_allocator)

	antinode_count := get_antinode_count(lines[:len(lines) - 1])
	fmt.printf("Total antinodes: %d\n", antinode_count)
}

get_antinode_count :: proc(lines: []string) -> int {
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
                if i >= j { // skip duplicate pairs
                    continue
                }

                // calculate vector between antennas
                vec := vec2{antenna2.position.x - antenna1.position.x, antenna2.position.y - antenna1.position.y}

                // get the two antinodes by adding and subtracting the vector from each antenna
                antinode1 := vec2{antenna1.position.x - vec.x, antenna1.position.y - vec.y}
                antinode2 := vec2{antenna2.position.x + vec.x, antenna2.position.y + vec.y}

                // check if antinodes are in bounds and not already found
                check_antinode(&antinodes, antinode1, max_x, max_y)
                check_antinode(&antinodes, antinode2, max_x, max_y)
            }
        }
    }

    return len(antinodes)
}

check_antinode :: proc(antinodes: ^map[vec2]bool, antinode: vec2, max_x: int, max_y: int) -> bool {
    if antinode.x < 0 || antinode.x >= max_x || antinode.y < 0 || antinode.y >= max_y {
        return false
    }

    _, found := antinodes^[antinode]
    if found {
        return true
    }

    antinodes[antinode] = true

    return true
}

parse_antennas :: proc(lines: []string) -> (antennas: map[rune][dynamic]antenna) {
    for line, y in lines {
        for frequency, x in line {
            if frequency == '.' {
                continue
            }

            curr_antenna := antenna{vec2{x, y}, frequency}

            antennas_at_frequency, ok := antennas[frequency]
            if !ok {
                antennas[frequency] = [dynamic]antenna{curr_antenna}
            } else {
                append(&antennas_at_frequency, curr_antenna)
                antennas[frequency] = antennas_at_frequency
            }

        }
    }
    return
}
