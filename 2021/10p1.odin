package main

import "core:fmt"
import "core:strings"

D10P1 :: proc() {
	input_string := #load("./inputs/10.txt", string)
	lines := strings.split(input_string, "\n", context.temp_allocator)

	syntax_error_score := get_syntax_error_score(lines)
	fmt.printfln("Syntax Error Score: %v", syntax_error_score)
}

get_syntax_error_score :: proc(input: []string) -> int {
	score := 0
	for line in input {
		score += get_line_score(line)
	}
	return score
}

get_line_score :: proc(line: string) -> int {
	score := 0
	opened: [dynamic]rune

	matches := map[rune]rune {
		')' = '(',
		']' = '[',
		'}' = '{',
		'>' = '<',
	}

	error_score := map[rune]int {
		')' = 3,
		']' = 57,
		'}' = 1197,
		'>' = 25137,
	}

	defer {
		delete(opened)
		delete(matches)
		delete(error_score)
	}

	for char in line {
		switch char {
		case '(', '[', '{', '<':
			append(&opened, char)

		case ')', ']', '}', '>':
			if len(opened) == 0 || opened[len(opened) - 1] != matches[char] {
				return error_score[char]
			}
			ordered_remove(&opened, len(opened) - 1)
		}
	}

	return score
}
