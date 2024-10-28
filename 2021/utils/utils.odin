package utils

import "core:fmt"
import "core:os"
import "core:slice"
import "core:strings"
import "core:time"

solution_stat :: struct {
	name:           string,
	day:            string,
	part:           string,
	execution_time: time.Duration,
}

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

write_lines :: proc(filepath: string, lines: [dynamic]string) {
	content_to_write: string
	for line in lines {
		content_to_write = strings.concatenate({content_to_write, line, "\n"})
	}

	ok := os.write_entire_file(filepath, transmute([]u8)content_to_write)
	if !ok {
		fmt.eprintfln("Error writing file: %v", filepath)
	}
}

benchmark :: proc(solution: proc()) -> time.Duration {
	start := time.now()
	solution()
	took := time.since(start)
	fmt.printfln("Execution Time: %v", took)
	return took
}

get_solution_stats :: proc(solutions: map[string]proc()) -> []solution_stat {
	stats := make([]solution_stat, len(solutions))
	i := 0

	ordered_keys := make([]string, len(solutions))
	for key, _ in solutions {
		ordered_keys[i] = key
		i += 1
	}

	slice.sort(ordered_keys)

	for key, i in ordered_keys {
		solution := solutions[key]
		sum_ex_time := time.Duration(0)
		for j := 0; j < 10; j += 1 {
			sum_ex_time += benchmark(solution)
		}

		stats[i] = solution_stat {
			name           = strings.split(key, ":")[1],
			day            = strings.split(key, ":")[0][0:2],
			part           = strings.split(key, ":")[0][3:4],
			execution_time = time.Duration(
				time.duration_round((sum_ex_time / 10), time.Microsecond),
			),
		}
	}

	return stats
}
