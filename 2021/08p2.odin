package main

import "core:fmt"
import "core:slice"
import "core:strings"
import "utils"

D08P2 :: proc() {
	lines, backing := utils.read_lines("./inputs/08.txt")
	defer delete(lines)
	defer delete(backing)

	output_total := decode_signal_output_values(lines)
	fmt.printfln("Signal output total: %v", output_total)
}

decode_signal_output_values :: proc(input: []string) -> int {
	swapped_decoded_values := map[string]int{}
	defer delete(swapped_decoded_values)

	output_total := 0
	for line in input {
		signal_input_digits, signal_output_digits := parse_signal_line(line)
		decoded_values := decode_digit_strings(signal_input_digits)
		defer delete(decoded_values)

		for k, v in decoded_values {
			swapped_decoded_values[v] = k
		}

		output_value := 0
		for digit in signal_output_digits {
			output_value = output_value * 10 + swapped_decoded_values[digit]
		}
		output_total += output_value
	}
	return output_total
}

parse_signal_line :: proc(line: string) -> (inputs: []string, outputs: []string) {
	parts := strings.split(line, " ", context.temp_allocator)

	// split each string into individual characters, sort alphabetically then rejoin
	for digit_string, i in parts {
		chars := strings.split(digit_string, "", context.temp_allocator)
		slice.sort(chars[:])
		parts[i] = strings.join(chars, "", context.temp_allocator)
	}

	inputs = parts[:10]
	outputs = parts[11:]
	return
}

decode_digit_strings :: proc(digits: []string) -> (decoded: map[int]string) {
	// set digits with unique number of segments: 1, 4, 7, 8
	for digit in digits {
		switch len(digit) {
		case 2:
			decoded[1] = digit
		case 3:
			decoded[7] = digit
		case 4:
			decoded[4] = digit
		case 7:
			decoded[8] = digit
		}
	}

	// get digits with 5 & 6 segments: 2, 3, 5, 6, 9, 0
	for digit in digits {
		switch len(digit) {
		case 5:
			// digit is 3 if contains both characters from 1
			if get_char_match_count(digit, decoded[1]) == 2 {
				decoded[3] = digit
			} else if get_char_match_count(digit, decoded[1]) == 1 &&
			   get_char_match_count(digit, decoded[4]) == 2 {
				// digit is 2 if contains 1 from 1 and 2 from 4
				decoded[2] = digit
			} else {
				decoded[5] = digit
			}
		case 6:
			// digit is 6 if contains all from 5 and 1 from 1
			if get_char_match_count(digit, decoded[4]) == 3 &&
			   get_char_match_count(digit, decoded[1]) == 1 {
				decoded[6] = digit
			} else if get_char_match_count(digit, decoded[4]) == 4 &&
			   get_char_match_count(digit, decoded[1]) == 2 {
				// digit is 9 if contains all from 4 and 2 from 1
				decoded[9] = digit
			} else {
				// digit is 0
				decoded[0] = digit
			}
		}
	}
	return
}

get_char_match_count :: proc(a: string, b: string) -> int {
	match_count := 0
	for a_char in a {
		if strings.contains_rune(b, a_char) {
			match_count += 1
		}
	}
	return match_count
}
