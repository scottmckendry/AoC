package utils

import "core:fmt"
import "core:os"
import "core:strings"
import "core:time"

read_lines :: proc(filepath: string) -> [dynamic]string {
	data, ok := os.read_entire_file(filepath, context.allocator)
	if !ok {
		fmt.eprintfln("Error reading file: %v", filepath)
		return [dynamic]string{}
	}

	lines := [dynamic]string{}
	iter := string(data)
	for line in strings.split_lines_iterator(&iter) {
		append(&lines, line)
	}

	return lines
}

benchmark :: proc(solution: proc()) -> time.Duration {
	start := time.now()
	solution()
	took := time.since(start)
	fmt.printfln("Execution Time: %v", took)
	return took
}
