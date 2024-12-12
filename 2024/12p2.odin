package main

import "core:fmt"
import "core:strings"

D12P2 :: proc() {
	input_string := #load("inputs/12.txt", string)
	lines := strings.split(input_string, "\n", context.temp_allocator)

	fencing_cost := get_garden_fencing_cost_p2(lines)
	fmt.printf("Fencing cost: %d\n", fencing_cost)
}

get_garden_fencing_cost_p2 :: proc(input: []string) -> int {
	garden := parse_garden(input)
	defer {
		for row in garden {
			delete(row)
		}
		delete(garden)
	}

	fence_cost := map_fences_p2(&garden)
	return fence_cost
}

map_fences_p2 :: proc(garden: ^[dynamic][dynamic]rune) -> (fence_cost: int) {
	visited := map[vec2]bool{}
	defer delete(visited)

	for row, y in garden {
		for _, x in row {
			if visited[vec2{x, y}] {
				continue
			}

			// Find all connected positions with the same value
			current_region := map[vec2]bool{}
			defer delete(current_region)
			pot := garden[y][x]

			queue := [dynamic]vec2{vec2{x, y}}
			defer delete(queue)

			for len(queue) > 0 {
				pos := pop(&queue)
				if pos in visited || pos in current_region {
					continue
				}

				if garden[pos.y][pos.x] != pot {
					continue
				}

				current_region[pos] = true
				visited[pos] = true

				neighbours := [dynamic]vec2 {
					vec2{pos.x - 1, pos.y},
					vec2{pos.x + 1, pos.y},
					vec2{pos.x, pos.y - 1},
					vec2{pos.x, pos.y + 1},
				}
				defer delete(neighbours)

				for n in neighbours {
					if n.x < 0 || n.x >= len(row) || n.y < 0 || n.y >= len(garden^) {
						continue
					}
					if garden[n.y][n.x] == pot {
						append(&queue, n)
					}
				}
			}

			// Count corners for this region
			corners := 0
			for pos in current_region {
				// Outer corners
				left := vec2{pos.x - 1, pos.y} not_in current_region
				right := vec2{pos.x + 1, pos.y} not_in current_region
				up := vec2{pos.x, pos.y - 1} not_in current_region
				down := vec2{pos.x, pos.y + 1} not_in current_region

				// Count outer corners
				corners += int(left && up)
				corners += int(right && up)
				corners += int(left && down)
				corners += int(right && down)

				// Count inner corners
				if !left && !up {
					corners += int(vec2{pos.x - 1, pos.y - 1} not_in current_region)
				}
				if !right && !up {
					corners += int(vec2{pos.x + 1, pos.y - 1} not_in current_region)
				}
				if !left && !down {
					corners += int(vec2{pos.x - 1, pos.y + 1} not_in current_region)
				}
				if !right && !down {
					corners += int(vec2{pos.x + 1, pos.y + 1} not_in current_region)
				}
			}

			fence_cost += len(current_region) * corners
		}
	}
	return fence_cost
}
