package main

import "core:fmt"
import "core:strings"

memory_instruction :: struct {
	condition: bool,
	is_do:     bool,
	mul:       [2]int,
}

D03P2 :: proc() {
	input_string := #load("inputs/03.txt", string)
	lines := strings.split(input_string, "\n", context.temp_allocator)

	sum_of_multiplications := get_sum_of_cond_multiplications(lines)
	fmt.printf("Sum of all multiplications: %d\n", sum_of_multiplications)
}

get_sum_of_cond_multiplications :: proc(lines: []string) -> int {
	instructions := parse_memory_instructions(lines)
	defer delete(instructions)
	doing := true
	sum := 0
	for instruction in instructions {
		if instruction.condition {
			if instruction.is_do {
				doing = true
			} else {
				doing = false
			}
			continue
		}

		if doing {
			sum += instruction.mul[0] * instruction.mul[1]
		}
	}
	return sum
}

parse_memory_instructions :: proc(lines: []string) -> (instructions: [dynamic]memory_instruction) {
	for line in lines {
		i := 0
		for i < len(line) {
			switch line[i] {
			case 'd':
				// Check for "do()" or "don't()"
				if i + 3 < len(line) && line[i:i + 3] == "do(" {
					append(&instructions, memory_instruction{condition = true, is_do = true})
					i += 4
				} else if i + 6 < len(line) && line[i:i + 6] == "don't(" {
					append(&instructions, memory_instruction{condition = true, is_do = false})
					i += 7
				} else {
					i += 1
				}
			case 'm':
				// Check for "mul("
				if i + 3 < len(line) && line[i:i + 4] == "mul(" {
					i += 4
					num1, num2: int
					ok: bool
					i, num1, num2, ok = parse_multiplication(line, i)
					if ok {
						append(
							&instructions,
							memory_instruction{condition = false, mul = [2]int{num1, num2}},
						)
					}
				} else {
					i += 1
				}
			case:
				i += 1
			}
		}
	}
	return
}
