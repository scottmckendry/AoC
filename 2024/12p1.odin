package main

import "core:fmt"
import "core:strings"

D12P1 :: proc() {
	input_string := #load("inputs/12.txt", string)
	lines := strings.split(input_string, "\n", context.temp_allocator)

	fencing_cost := get_garden_fencing_cost(lines)
	fmt.printf("Fencing cost: %d\n", fencing_cost)
}

get_garden_fencing_cost :: proc(input: []string) -> int {
	garden := parse_garden(input)
	defer {
		for row in garden {
			delete(row)
		}
		delete(garden)
	}

	fence_cost := map_fences(&garden)
	return fence_cost
}

parse_garden :: proc(input: []string) -> (garden: [dynamic][dynamic]rune) {
	for line in input {
		if line == "" {
			continue
		}
		row: [dynamic]rune
		for char in line {
			append(&row, char)
		}
		append(&garden, row)
	}
	return
}

map_fences :: proc(garden: ^[dynamic][dynamic]rune) -> (fence_cost: int) {
	visited := map[vec2]bool{}
	defer delete(visited)

	for row, y in garden {
		for _, x in row {
			if visited[vec2{x, y}] {
				continue
			}

			queue := [dynamic]vec2{vec2{x, y}}
			defer delete(queue)

			perimeter := 0
			area := 0
			for len(queue) > 0 {
				pot_coord := pop(&queue)
				pot := garden[pot_coord.y][pot_coord.x]

				if visited[pot_coord] {
					continue
				}

				visited[pot_coord] = true
				area += 1

				neighbours := []vec2 {
					vec2{pot_coord.x - 1, pot_coord.y},
					vec2{pot_coord.x + 1, pot_coord.y},
					vec2{pot_coord.x, pot_coord.y - 1},
					vec2{pot_coord.x, pot_coord.y + 1},
				}

				matching_neighbours := 0
				for neighbour in neighbours {
					if neighbour.x < 0 ||
					   neighbour.x >= len(row) ||
					   neighbour.y < 0 ||
					   neighbour.y >= len(garden) {
						continue
					}
					if garden[neighbour.y][neighbour.x] == pot {
						append(&queue, neighbour)
						matching_neighbours += 1
					}
				}

				perimeter += 4 - matching_neighbours
			}
			fence_cost += perimeter * area
		}
	}
	return fence_cost
}
