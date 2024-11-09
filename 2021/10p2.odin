package main

import "core:fmt"
import "core:slice"
import "core:unicode/utf8"
import "utils"

D10P2 :: proc() {
	lines, backing := utils.read_lines("./inputs/10.txt")
	defer delete(lines)
	defer delete(backing)

	middle_autocomplete_score := get_middle_autocomplete_score(lines)
	fmt.printfln("Middle Autocomplete Score: %v", middle_autocomplete_score)
}

get_middle_autocomplete_score :: proc(input: []string) -> int {
	completions: [dynamic]string
	defer delete(completions)
	for line in input {
		completion := complete_navigation_line(line)
		if completion != "" {
			append(&completions, completion)
		}
	}

	scores: [dynamic]int
	defer delete(scores)
	for completion in completions {
		append(&scores, score_completion(completion))
	}

	slice.sort(scores[:])
	return scores[len(scores) / 2]
}

complete_navigation_line :: proc(line: string) -> string {
	opened: [dynamic]rune
	closed: [dynamic]rune
	matches := map[rune]rune {
		')' = '(',
		']' = '[',
		'}' = '{',
		'>' = '<',
	}
	inverse_matches := map[rune]rune {
		'(' = ')',
		'[' = ']',
		'{' = '}',
		'<' = '>',
	}

	defer {
		delete(opened)
		delete(closed)
		delete(matches)
		delete(inverse_matches)
	}

	for char in line {
		switch char {
		case '(', '[', '{', '<':
			append(&opened, char)

		case ')', ']', '}', '>':
			if len(opened) == 0 || opened[len(opened) - 1] != matches[char] {
				return ""
			}
			ordered_remove(&opened, len(opened) - 1)
		}
	}

	// close the opened brackets in reverse order
	for i := len(opened) - 1; i >= 0; i -= 1 {
		append(&closed, inverse_matches[opened[i]])
	}

	// return as string
	return utf8.runes_to_string(closed[:], context.temp_allocator)
}

score_completion :: proc(line: string) -> int {
	values := map[rune]int {
		')' = 1,
		']' = 2,
		'}' = 3,
		'>' = 4,
	}
	defer delete(values)

	score := 0
	for char in line {
		score *= 5
		score += values[char]
	}

	return score
}
