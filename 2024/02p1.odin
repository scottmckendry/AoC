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
		str_numbers := strings.split(line, " ", context.temp_allocator)
		numbers := make([dynamic]int)
		defer delete(numbers)

		for str in str_numbers {
			append(&numbers, strconv.atoi(str))
		}

		if is_safe_report(numbers, dampener) {
			result += 1
		}
	}
	return result
}

is_safe_report :: proc(numbers: [dynamic]int, dampener: bool) -> bool {
	if check_sequence(numbers) {
		return true
	}

	if !dampener {
		return false
	}

	for i := 0; i < len(numbers); i += 1 {
		temp := make([dynamic]int)
		defer delete(temp)

		for j := 0; j < len(numbers); j += 1 {
			if j != i {
				append(&temp, numbers[j])
			}
		}
		if check_sequence(temp) {
			return true
		}
	}

	return false
}

check_sequence :: proc(numbers: [dynamic]int) -> bool {
	prev := numbers[0]
	curr := numbers[1]

	diff := abs(curr - prev)
	if diff > 3 || diff == 0 {
		return false
	}

	increasing := curr > prev
	prev = curr

	for i := 2; i < len(numbers); i += 1 {
		curr = numbers[i]

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
