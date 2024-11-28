package main

import "core:fmt"
import "core:strings"

D01P1 :: proc() {
	input_string := #load("inputs/01.txt", string)
	lines := strings.split(input_string, "\n", context.temp_allocator)

	fmt.printfln(lines[0])
}
