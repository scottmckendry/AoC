package main

import "core:fmt"
import "core:strings"

D14P2 :: proc() {
	input_string := #load("inputs/14.txt", string)
	lines := strings.split(input_string, "\n", context.temp_allocator)

	bounds := vec2{100, 102}

	robots := parse_robots(lines)
	defer delete(robots)
	seconds := 200000

	seconds = 1
	found := false
	for !found {
		for &robot in robots {
			apply_robot_velocity(&robot, 1, bounds)
		}

		found = check_robots(&robots, bounds)
		if found {
			break
		}
		seconds += 1
	}

	fmt.printf("Seconds: %d\n", seconds)
}

check_robots :: proc(robots: ^[dynamic]robot, bounds: vec2) -> bool {
	visited := make(map[vec2]bool)
	defer delete(visited)

	for &robot in robots {
		if visited[robot.pos] {
			return false
		}

		visited[robot.pos] = true
	}
	return true
}
