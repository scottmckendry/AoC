package main

import "core:fmt"
import "core:strconv"
import "core:strings"

D02P1 :: proc() {
	input_string := #load("inputs/02.txt", string)
	lines := strings.split(input_string, "\n", context.temp_allocator)

	safe_reports := get_safe_reports(lines, false)
	fmt.printf("Number of safe reports: %d\n", safe_reports)
}

get_safe_reports :: proc(lines: []string, dampener: bool) -> int {
	result := 0
	for line in lines {
		if line == "" {
			continue
		}
		numbers := strings.split(line, " ", context.temp_allocator)
		dynamic_numbers: [dynamic]string
		defer delete(dynamic_numbers)
		append(&dynamic_numbers, ..numbers[:])
		if is_safe_report(dynamic_numbers, dampener) {
			result += 1
		}
	}
	return result
}

is_safe_report :: proc(input: [dynamic]string, dampener: bool) -> bool {
	if check_sequence(input) {
		return true
	}

	// return false if the dampener is off
	if !dampener {
		return false
	}

	// Try removing each number one at a time
	for i := 0; i < len(input); i += 1 {
		temp := make([dynamic]string)
		defer delete(temp)

		for j := 0; j < len(input); j += 1 {
			if j != i {
				append(&temp, input[j])
			}
		}
		if check_sequence(temp) {
			return true
		}
	}

	return false
}

check_sequence :: proc(numbers: [dynamic]string) -> bool {
	if len(numbers) < 2 do return false

	prev := strconv.atoi(numbers[0])
	curr := strconv.atoi(numbers[1])

	diff := abs(curr - prev)
	if diff > 3 || diff == 0 do return false

	increasing := curr > prev
	prev = curr

	for i := 2; i < len(numbers); i += 1 {
		curr = strconv.atoi(numbers[i])

		if (increasing && curr <= prev) || (!increasing && curr >= prev) {
			return false
		}

		diff = abs(curr - prev)
		if diff > 3 || diff == 0 {
			return false
		}

		prev = curr
	}

	return true
}
