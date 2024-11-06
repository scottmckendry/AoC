package main

import "core:fmt"
import "core:strings"
import "utils"

D08P1 :: proc() {
	lines, backing := utils.read_lines("./inputs/08.txt")
	defer delete(lines)
	defer delete(backing)

    unique_digits := count_unique_output_digits(lines)
	fmt.printfln("Number of unique digits in output: %v", unique_digits)
}

count_unique_output_digits :: proc(input: []string) -> int {
    unique_digits := 0
    for line in input {
        output := strings.split(line, "|", context.temp_allocator)[1]
        digit_strings := strings.split(output, " ", context.temp_allocator)
        for digit_str in digit_strings {
            switch len(digit_str) {
            case 2, 3, 4, 7:
                unique_digits += 1
            }
        }
    }
    return unique_digits
}
