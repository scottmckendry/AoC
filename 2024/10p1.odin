package main

import "core:fmt"
import "core:strings"

D10P1 :: proc() {
	input_string := #load("inputs/10.txt", string)
	lines := strings.split(input_string, "\n", context.temp_allocator)

	sum_trailhead_scores := get_sum_trailhead_scores(lines, false)
	fmt.printf("Sum of all trailhead scores: %d\n", sum_trailhead_scores)
}

get_sum_trailhead_scores :: proc(input: []string, part2: bool) -> int {
	trailmap, trailheads := parse_trailmap(input)
	defer delete(trailmap)
	defer delete(trailheads)
	sum: int
	for trailhead in trailheads {
		sum += get_trailhead_score(trailmap, trailhead, len(input[0]), part2)
	}
	return sum
}

parse_trailmap :: proc(input: []string) -> (trailmap: [dynamic]int, trailheads: [dynamic]int) {
	max_x := len(input[0])
	for line, y in input {
		if line == "" {
			continue
		}
		for char, x in line {
			// convert rune to int
			append(&trailmap, auto_cast (char - '0'))

			if char == '0' {
				append(&trailheads, y * max_x + x)
			}
		}
	}
	return
}

get_trailhead_score :: proc(
	trailmap: [dynamic]int,
	trailhead: int,
	map_width: int,
	part2: bool,
) -> int {
	score := 0
	queue := [dynamic]int{trailhead}
	visited := make([dynamic]bool, len(trailmap))
	visited[trailhead] = true
	defer {
		delete(queue)
		delete(visited)
	}

	for len(queue) > 0 {
		coord := pop(&queue)
		if part2 {
			visited[coord] = true
		}
		curr_height := trailmap[coord]

		// Check all 4 directions
		neighbours := []int{-1, 1, -map_width, map_width}
		for offset in neighbours {
			neighbour := coord + offset

			// Skip if out of bounds or crossing horizontal boundary
			if neighbour < 0 ||
			   neighbour >= len(trailmap) ||
			   (offset == -1 && coord % map_width == 0) ||
			   (offset == 1 && coord % map_width == map_width - 1) {
				continue
			}

			// Skip if not exactly one height higher or already visited
			if trailmap[neighbour] != curr_height + 1 || (!part2 && visited[neighbour]) {
				continue
			}

			if trailmap[neighbour] == 9 {
				score += 1
				if !part2 {
					visited[neighbour] = true
				}
			} else {
				append(&queue, neighbour)
			}
		}
	}
	return score
}
