package main

import "core:fmt"
import "core:math"
import "core:strconv"
import "core:strings"

claw_machine :: struct {
	button_a: vec2,
	button_b: vec2,
	prize:    vec2,
}

D13P1 :: proc() {
	input_string := #load("inputs/13.txt", string)
	lines := strings.split(input_string, "\n", context.temp_allocator)

	token_cost := get_token_cost(lines, false)
	fmt.printf("Minimum tokens to get all prizes: %d\n", token_cost)
}

get_token_cost :: proc(lines: []string, p2: bool) -> i64 {
	token_cost: i64 = 0
	claw_machines := parse_claw_machines(lines, p2)
	defer delete(claw_machines)

	for machine in claw_machines {
		// c3 = c1 * a + c2 * b
		// c6 = c4 * a + c5 * b

		// where:
		// c1, c4 = button_a.x, button_a.y
		// c2, c5 = button_b.x, button_b.y
		// c3, c6 = prize.x, prize.y

		// calculate b
		numerator := f64(
			machine.button_a.x * machine.prize.y - machine.button_a.y * machine.prize.x,
		)
		denominator := f64(
			machine.button_a.x * machine.button_b.y - machine.button_a.y * machine.button_b.x,
		)
		b := numerator / denominator

		// calculate a
		a := (f64(machine.prize.x) - f64(machine.button_b.x) * b) / f64(machine.button_a.x)

		// round a and b to the nearest 3 decimal places
		a = math.round(a * 1000) / 1000
		b = math.round(b * 1000) / 1000

		// if both a and b are integers and a, b >= 0
		if a == f64(int(a)) && b == f64(int(b)) && a >= 0 && b >= 0 {
			token_cost += i64(int(a) * 3 + int(b))
		}
	}

	return token_cost
}

parse_claw_machines :: proc(lines: []string, p2: bool) -> (claw_machines: [dynamic]claw_machine) {
	machine: claw_machine
	for line, x in lines {
		if line == "" {
			append(&claw_machines, machine)
			machine = claw_machine{}
			continue
		}

		// button a
		if x % 4 == 0 {
			x_offset := strconv.atoi(line[12:14])
			y_offset := strconv.atoi(line[18:20])
			machine.button_a = vec2{x_offset, y_offset}
		}

		// button b
		if x % 4 == 1 {
			x_offset := strconv.atoi(line[12:14])
			y_offset := strconv.atoi(line[18:20])
			machine.button_b = vec2{x_offset, y_offset}
		}

		// prize
		if x % 4 == 2 {
			prize_parts := strings.split(line, ",", context.temp_allocator)
			x_parts := strings.split(prize_parts[0], "=", context.temp_allocator)
			y_parts := strings.split(prize_parts[1], "=", context.temp_allocator)

			x_offset := strconv.atoi(x_parts[1])
			y_offset := strconv.atoi(y_parts[1])

			if p2 {
				x_offset += 10000000000000
				y_offset += 10000000000000
			}

			machine.prize = vec2{x_offset, y_offset}
		}
	}

	append(&claw_machines, machine)
	return
}
