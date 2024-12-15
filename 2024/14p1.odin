package main

import "core:fmt"
import "core:log"
import "core:strconv"
import "core:strings"

robot :: struct {
	pos, vel: vec2,
}

D14P1 :: proc() {
	input_string := #load("inputs/14.txt", string)
	lines := strings.split(input_string, "\n", context.temp_allocator)

	safety_factor := calculate_safety_factor(lines, vec2{100, 102})
	fmt.printf("Safety factor: %d\n", safety_factor)
}

calculate_safety_factor :: proc(lines: []string, bounds: vec2) -> int {
	robots := parse_robots(lines)
	defer delete(robots)
	seconds := 100

	for &robot in robots {
		apply_robot_velocity(&robot, seconds, bounds)
	}

	middle_x := bounds.x / 2
	middle_y := bounds.y / 2
	quadrants: [4]int

	for robot in robots {
		// Skip robots on the middle lines
		if robot.pos.x == middle_x || robot.pos.y == middle_y {
			continue
		}

		if robot.pos.x < middle_x {
			if robot.pos.y < middle_y {
				quadrants[0] += 1 // top left
			} else {
				quadrants[1] += 1 // bottom left
			}
		} else {
			if robot.pos.y < middle_y {
				quadrants[2] += 1 // top right
			} else {
				quadrants[3] += 1 // bottom right
			}
		}
	}

	log.info(quadrants)
	return quadrants[0] * quadrants[1] * quadrants[2] * quadrants[3]
}

parse_robots :: proc(input: []string) -> (robots: [dynamic]robot) {
	for line in input {
		if line == "" {
			continue
		}

		r := robot{}

		pos_and_vel_strs := strings.split(line, " ", context.temp_allocator)
		pos_str := strings.split(pos_and_vel_strs[0], "p=", context.temp_allocator)[1]
		vel_str := strings.split(pos_and_vel_strs[1], "v=", context.temp_allocator)[1]

		pos_parts := strings.split(pos_str, ",", context.temp_allocator)
		vel_parts := strings.split(vel_str, ",", context.temp_allocator)

		r.pos.x = strconv.atoi(pos_parts[0])
		r.pos.y = strconv.atoi(pos_parts[1])
		r.vel.x = strconv.atoi(vel_parts[0])
		r.vel.y = strconv.atoi(vel_parts[1])

		append(&robots, r)
	}

	return
}

apply_robot_velocity :: proc(r: ^robot, seconds: int, bounds: vec2) {
	r.pos.x += r.vel.x * seconds
	r.pos.y += r.vel.y * seconds

	r.pos.x = ((r.pos.x % (bounds.x + 1)) + (bounds.x + 1)) % (bounds.x + 1)
	r.pos.y = ((r.pos.y % (bounds.y + 1)) + (bounds.y + 1)) % (bounds.y + 1)
}
