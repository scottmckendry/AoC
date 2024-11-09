package main

import "core:fmt"
import "core:testing"

navigation_subsystem :: []string {
	"[({(<(())[]>[[{[]{<()<>>",
	"[(()[<>])]({[<{<<[]>>(",
	"{([(<{}[<>[]}>{[]{[(<()>",
	"((((<{}<{<{<>}{[]{[]{}",
	"[[<[([]))<([[{}[[()]]]",
	"[{[{({}]{}}([{[{{{}}([]",
	"{<[[]]>}<{[{[{[]{()[[[]",
	"[<(<(<(<{}))><([]([]()",
	"<{([([[(<>()){}]>(<<{{",
	"<{([{{}}[<[[[<>{}]]]>[]]",
}

@(test)
d10p1 :: proc(t: ^testing.T) {
	want := 26397
	got := get_syntax_error_score(navigation_subsystem)
	testing.expect(t, got == want, fmt.tprintf("Got: %v | Want: %v", got, want))
}

@(test)
d10p2 :: proc(t: ^testing.T) {
	want := 288957
	got := get_middle_autocomplete_score(navigation_subsystem)
	testing.expect(t, got == want, fmt.tprintf("Got: %v | Want: %v", got, want))
}

@(test)
test_get_line_score :: proc(t: ^testing.T) {
	want := 1197
	got := get_line_score(navigation_subsystem[2]) // syntax error
	testing.expect(t, got == want, fmt.tprintf("Got: %v | Want: %v", got, want))

	want = 0
	got = get_line_score(navigation_subsystem[0]) // no syntax error
	testing.expect(t, got == want, fmt.tprintf("Got: %v | Want: %v", got, want))
}

@(test)
test_complete_navigation_line :: proc(t: ^testing.T) {
	want := "}}]])})]"
	got := complete_navigation_line(navigation_subsystem[0])
	testing.expect(t, got == want, fmt.tprintf("Got: %v | Want: %v", got, want))

	want = "])}>"
	got = complete_navigation_line(navigation_subsystem[9])
	testing.expect(t, got == want, fmt.tprintf("Got: %v | Want: %v", got, want))

	want = "" // when line is corrupted
	got = complete_navigation_line(navigation_subsystem[2])
	testing.expect(t, got == want, fmt.tprintf("Got: %v | Want: %v", got, want))
}

@(test)
test_score_completion :: proc(t: ^testing.T) {
	want := 288957
	got := score_completion("}}]])})]")
	testing.expect(t, got == want, fmt.tprintf("Got: %v | Want: %v", got, want))

	want = 0
	got = score_completion("")
	testing.expect(t, got == want, fmt.tprintf("Got: %v | Want: %v", got, want))
}
