package main

import "core:fmt"
import "core:testing"

signals :: []string {
	"be cfbegad cbdgef fgaecd cgeb fdcge agebfd fecdb fabcd edb | fdgacbe cefdb cefbgd gcbe",
	"edbfga begcd cbg gc gcadebf fbgde acbgfd abcde gfcbed gfec | fcgedb cgb dgebacf gc",
	"fgaebd cg bdaec gdafb agbcfd gdcbef bgcad gfac gcb cdgabef | cg cg fdcagb cbg",
	"fbegcd cbd adcefb dageb afcb bc aefdc ecdab fgdeca fcdbega | efabcd cedba gadfec cb",
	"aecbfdg fbg gf bafeg dbefa fcge gcbea fcaegb dgceab fcbdga | gecf egdcabf bgf bfgea",
	"fgeab ca afcebg bdacfeg cfaedg gcfdb baec bfadeg bafgc acf | gebdcfa ecba ca fadegcb",
	"dbcfg fgd bdegcaf fgec aegbdf ecdfab fbedc dacgb gdcebf gf | cefg dcbef fcge gbcadfe",
	"bdfegc cbegaf gecbf dfcage bdacg ed bedf ced adcbefg gebcd | ed bcgafe cdgba cbgef",
	"egadfb cdbfeg cegd fecab cgb gbdefca cg fgcdab egfdb bfceg | gbdfcae bgc cg cgb",
	"gcafb gcf dcaebfg ecagb gf abcdeg gaef cafbge fdbac fegbdc | fgae cfgab fg bagce",
}

@(test)
d08p1 :: proc(t: ^testing.T) {
	want := 26
	got := count_unique_output_digits(signals)
	testing.expect(t, got == want, fmt.tprintf("Got: %v | Want: %v", got, want))

	free_all()
}

@(test)
d08p2 :: proc(t: ^testing.T) {
	want := 61229
	got := decode_signal_output_values(signals)
	testing.expect(t, got == want, fmt.tprintf("Got: %v | Want: %v", got, want))

	free_all()
}

@(test)
test_parse_signal_line :: proc(t: ^testing.T) {
	line := "acedgfb cdfbe gcdfa fbcad dab cefabd cdfgeb eafb cagedb ab | cdfeb fcadb cdfeb cdbaf"
	want_inputs := []string {
		"abcdefg",
		"bcdef",
		"acdfg",
		"abcdf",
		"abd",
		"abcdef",
		"bcdefg",
		"abef",
		"abcdeg",
		"ab",
	}
	want_outputs := []string{"bcdef", "abcdf", "bcdef", "abcdf"}

	got_inputs, got_outputs := parse_signal_line(line)

	for input, i in want_inputs {
		testing.expect(
			t,
			input == got_inputs[i],
			fmt.tprintf("Got: %v | Want: %v", got_inputs[i], input),
		)
	}

	for output, i in want_outputs {
		testing.expect(
			t,
			output == got_outputs[i],
			fmt.tprintf("Got: %v | Want: %v", got_outputs[i], output),
		)
	}

	free_all()
}

@(test)
test_decode_digit_strings :: proc(t: ^testing.T) {
	digits := []string {
		"abcdefg",
		"bcdef",
		"acdfg",
		"abcdf",
		"abd",
		"abcdef",
		"bcdefg",
		"abef",
		"abcdeg",
		"ab",
	}
	want := map[int]string {
		1 = "ab",
		2 = "acdfg",
		3 = "abcdf",
		4 = "abef",
		5 = "bcdef",
		6 = "bcdefg",
		7 = "abd",
		8 = "abcdefg",
		9 = "abcdef",
		0 = "abcdeg",
	}

	got := decode_digit_strings(digits)

	for k, v in want {
		testing.expect(
			t,
			got[k] == v,
			fmt.tprintf("Wrong value for key %v | Got: %v | Want: %v", k, got[k], v),
		)
	}

	free_all()
}

@(test)
test_get_char_match_count :: proc(t: ^testing.T) {
	digit := "abcdf" // 3
	compare := "ab" // 1
	want := 2

	got := get_char_match_count(digit, compare)

	testing.expect(t, got == want, fmt.tprintf("Got: %v | Want: %v", got, want))

	free_all()
}
