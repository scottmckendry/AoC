package main

import "core:fmt"
import "core:strconv"
import "core:strings"

memory_instruction :: struct {
	condtion: bool,
	is_do:    bool,
	mul:      [2]int,
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
		if instruction.condtion {
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
		remaining := line
		for len(remaining) > 0 {
			mul_index := strings.index(remaining, "mul(")
			do_index := strings.index(remaining, "do()")
			dont_index := strings.index(remaining, "don't()")

			if mul_index == -1 {
				mul_index = 9999
			}
			if do_index == -1 {
				do_index = 9999
			}
			if dont_index == -1 {
				dont_index = 9999
			}

			// check if there are no remaining instructions or get the nearest instruction
			start := min(mul_index, do_index, dont_index)
			if start == 9999 {
				break
			}

			if start == do_index {
				append(&instructions, memory_instruction{condtion = true, is_do = true})
				remaining = remaining[start + 4:]
				continue
			}

			if start == dont_index {
				append(&instructions, memory_instruction{condtion = true, is_do = false})
				remaining = remaining[start + 7:]
				continue
			}

			start += 4 // skip over "mul("
			end := strings.index(remaining[start:], ")")
			if end == -1 {
				break
			}

			pair := strings.split(remaining[start:start + end], ",", context.temp_allocator)

			// make sure only two values were found
			if len(pair) == 2 {
				number_pair := [2]int{}
				valid_pair := true
				for str, i in pair {
					num, ok := strconv.parse_int(str)
					if !ok {
						valid_pair = false
						break
					}
					number_pair[i] = num
				}
				if valid_pair {
					append(&instructions, memory_instruction{condtion = false, mul = number_pair})
				}
			}

			remaining = remaining[start + 4:] // keep the rest of the string for the next iteration
		}
	}
	return
}
