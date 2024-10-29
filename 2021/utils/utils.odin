package utils

import "core:fmt"
import "core:mem"
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

read_lines :: proc(filepath: string) -> ([]string, []u8) {
	data, ok := os.read_entire_file(filepath)
	if !ok {
		fmt.eprintfln("Error reading file: %v", filepath)
		return {}, {}
	}

	lines := strings.split(string(data), "\n")
	return lines[0:len(lines) - 1], data
}

write_lines :: proc(filepath: string, lines: [dynamic]string) {
	content_to_write: string
	for line in lines {
		content_to_write = strings.concatenate(
			{content_to_write, line, "\n"},
			context.temp_allocator,
		)
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
	ordered_keys := make([]string, len(solutions))
	defer delete(ordered_keys)

	i_stat := 0
	for key, _ in solutions {
		ordered_keys[i_stat] = key
		i_stat += 1
	}

	slice.sort(ordered_keys)

	for key, i in ordered_keys {
		solution := solutions[key]
		sum_ex_time := time.Duration(0)
		for j := 0; j < 10; j += 1 {
			sum_ex_time += benchmark(solution)
		}

		stats[i] = solution_stat {
			name           = strings.split(key, ":", context.temp_allocator)[1],
			day            = strings.split(key, ":", context.temp_allocator)[0][0:2],
			part           = strings.split(key, ":", context.temp_allocator)[0][3:4],
			execution_time = time.Duration(
				time.duration_round((sum_ex_time / 10), time.Microsecond),
			),
		}
	}

	return stats
}
