package main

import "core:fmt"
import "core:strconv"
import "core:strings"

D03P1 :: proc() {
	input_string := #load("inputs/03.txt", string)
	lines := strings.split(input_string, "\n", context.temp_allocator)

	sum_of_multiplications := get_sum_of_multiplications(lines)
	fmt.printf("Sum of all multiplications: %d\n", sum_of_multiplications)
}

get_sum_of_multiplications :: proc(lines: []string) -> int {
	number_pairs := parse_corrupted_memory(lines)
	defer delete(number_pairs)
	sum := 0
	for pair in number_pairs {
		sum += pair[0] * pair[1]
	}
	return sum
}

parse_corrupted_memory :: proc(corrupted_memory: []string) -> (number_pairs: [dynamic][2]int) {
	for line in corrupted_memory {
		i := 0
		for i < len(line) {
			if line[i] == 'm' {
				// Check for "mul("
				if i + 3 < len(line) && line[i:i + 4] == "mul(" {
					i += 4
					num1, num2: int
					ok: bool
					i, num1, num2, ok = parse_multiplication(line, i)
					if ok {
						append(&number_pairs, [2]int{num1, num2})
					}
				} else {
					i += 1
				}
			} else {
				i += 1
			}
		}
	}
	return
}

parse_multiplication :: proc(
	line: string,
	start: int,
) -> (
	new_pos: int,
	num1: int,
	num2: int,
	ok: bool,
) {
	// Parse first number
	i := start
	num_start := i
	for i < len(line) && (line[i] >= '0' && line[i] <= '9') {
		i += 1
	}
	if i == num_start {return i, 0, 0, false}
	num1 = strconv.parse_int(line[num_start:i]) or_return

	// Expect comma
	if i >= len(line) || line[i] != ',' {return i, 0, 0, false}
	i += 1

	// Parse second number
	num_start = i
	for i < len(line) && (line[i] >= '0' && line[i] <= '9') {
		i += 1
	}
	if i == num_start {return i, 0, 0, false}
	num2 = strconv.parse_int(line[num_start:i]) or_return

	// Expect closing parenthesis
	if i >= len(line) || line[i] != ')' {return i, 0, 0, false}
	i += 1

	return i, num1, num2, true
}
