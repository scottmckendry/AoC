package main

import "core:fmt"
import "core:strconv"
import "core:strings"
import "utils"

D11P1 :: proc() {
	lines, backing := utils.read_lines("./inputs/11.txt")
	defer delete(lines)
	defer delete(backing)

	flash_total := get_octopi_energy_flashes(lines, 100)
	fmt.printfln("Total flashes after 100 steps: %v", flash_total)
}

get_octopi_energy_flashes :: proc(lines: []string, steps: int) -> int {
	energy_levels := parse_octopi_energy_levels(lines)
	flashes := 0
	for _ in 0 ..< steps {
		flashes += simulate_octopus_step(&energy_levels)
	}
	return flashes
}

parse_octopi_energy_levels :: proc(lines: []string) -> (energy_levels: [10][10]int) {
	for line, i in lines {
		energy_strings := strings.split(line, "", context.temp_allocator)
		for str, j in energy_strings {
			energy_levels[i][j] = strconv.atoi(str)
		}
	}
	return
}

simulate_octopus_step :: proc(energy_levels: ^[10][10]int) -> (flashes_in_step: int) {
	peak_energy_indexes: [dynamic]Vec2
	defer delete(peak_energy_indexes)

	for i in 0 ..< 10 {
		for j in 0 ..< 10 {
			energy_levels[i][j] += 1
			if energy_levels[i][j] > 9 {
				append(&peak_energy_indexes, Vec2{i, j})
			}
		}
	}

	flashes_in_step = simulate_octopus_energy_flash(energy_levels, &peak_energy_indexes)
	return
}

simulate_octopus_energy_flash :: proc(
	energy_levels: ^[10][10]int,
	peak_energy_indexes: ^[dynamic]Vec2,
) -> (
	flashes: int,
) {
	for len(peak_energy_indexes) > 0 {
		current := pop(peak_energy_indexes)
		if energy_levels[current.x][current.y] == 0 {
			continue
		}

		energy_levels[current.x][current.y] = 0
		flashes += 1

		neighbors := []Vec2 {
			{current.x - 1, current.y},
			{current.x + 1, current.y},
			{current.x, current.y - 1},
			{current.x, current.y + 1},
			{current.x - 1, current.y - 1},
			{current.x - 1, current.y + 1},
			{current.x + 1, current.y - 1},
			{current.x + 1, current.y + 1},
		}

		for neighbor in neighbors {
			// check if neighbor is within bounds
			if neighbor.x >= 0 && neighbor.x < 10 && neighbor.y >= 0 && neighbor.y < 10 {
				if energy_levels[neighbor.x][neighbor.y] == 0 {
					continue
				}

				energy_levels[neighbor.x][neighbor.y] += 1
				if energy_levels[neighbor.x][neighbor.y] > 9 {
					append(peak_energy_indexes, neighbor)
				}
			}
		}
	}

	return
}
