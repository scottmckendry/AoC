package main

import "core:fmt"
import "core:strconv"
import "core:strings"

Equation :: struct {
	calibration: int,
	equation:    [dynamic]int,
}

D07P1 :: proc() {
	input_string := #load("inputs/07.txt", string)
	lines := strings.split(input_string, "\n", context.temp_allocator)

	calibration_sum := get_sum_of_valid_calibrations(lines, false)
	fmt.printf("Total calibration result: %d\n", calibration_sum)
}

get_sum_of_valid_calibrations :: proc(input: []string, include_concat: bool) -> (sum: u64) {
	calibration_equations := parse_equations(input)
	defer {
		for equation in calibration_equations {
			delete(equation.equation)
		}
		delete(calibration_equations)
	}

	for equation in calibration_equations {
		sliced := equation.equation[:]
		is_valid := apply_operator(equation.calibration, sliced[0], sliced[1:], include_concat)

		if is_valid {
			sum += auto_cast equation.calibration
		}
	}
	return sum
}

parse_equations :: proc(equations: []string) -> (calibration_equations: [dynamic]Equation) {
	for equation in equations {
		if equation == "" {
			continue
		}

		calibration_equation := Equation{}

		parts := strings.split(equation, ": ", context.temp_allocator)
		calibration_equation.calibration = strconv.atoi(parts[0])

		equation_parts := strings.split(parts[1], " ", context.temp_allocator)
		for part in equation_parts {
			append(&calibration_equation.equation, strconv.atoi(part))
		}

		append(&calibration_equations, calibration_equation)
	}

	return
}

apply_operator :: proc(
	calibration: int,
	current_value: int,
	remaining_operands: []int,
	include_concat: bool,
) -> (
	is_valid: bool,
) {
	if len(remaining_operands) == 0 {
		return current_value == calibration
	}

	add_result := apply_operator(
		calibration,
		current_value + remaining_operands[0],
		remaining_operands[1:],
		include_concat,
	)
	if add_result {
		return true
	}

	mult_result := apply_operator(
		calibration,
		current_value * remaining_operands[0],
		remaining_operands[1:],
		include_concat,
	)
	if mult_result {
		return true
	}

	if include_concat {
		concat_result := apply_operator(
			calibration,
			concat_ints(current_value, remaining_operands[0]),
			remaining_operands[1:],
			include_concat,
		)
		if concat_result {
			return true
		}
	}

	return
}


concat_ints :: proc(a: int, b: int) -> (result: int) {
	b_digits := 1
	b_copy := b
	for b_copy >= 10 {
		b_copy /= 10
		b_digits += 1
	}

	result = a
	for i := 0; i < b_digits; i += 1 {
		result *= 10
	}

	result += b
	return
}
