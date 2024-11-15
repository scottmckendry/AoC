package main

import "core:fmt"
import "core:strings"
import "utils"

cave :: struct {
	large:       bool,
	connections: [dynamic]string,
}

D12P1 :: proc() {
	lines, backing := utils.read_lines("./inputs/12.txt")
	defer delete(lines)
	defer delete(backing)

	small_cave_path_total := traverse_caves(lines, true)
	fmt.printfln("Paths through small caves: %v", small_cave_path_total)
}

traverse_caves :: proc(lines: []string, visited_twice: bool) -> int {
	caves := parse_caves(lines)
	visited := make(map[string]int)
	defer {
		for cave, _ in caves {
			delete(caves[cave].connections)
		}
		delete(caves)
		delete(visited)
	}

	return count_paths(caves, "start", &visited, visited_twice)
}

count_paths :: proc(
	caves: map[string]cave,
	current: string,
	visited: ^map[string]int,
	visited_twice: bool,
) -> int {
	visited_twice_local := visited_twice
	if current == "end" {
		for cave, _ in caves {
			if cave == "start" || cave == "end" {
				continue
			}
			if !caves[cave].large && visited[cave] > 0 {
				return 1
			}
		}
		return 0
	}

	if current == "start" && visited[current] > 0 {
		return 0
	}

	if !caves[current].large {
		if visited[current] > 0 {
			if visited_twice {
				return 0
			}
			visited_twice_local = true
		}
	}

	visited[current] += 1
	defer {visited[current] -= 1}

	total_paths := 0
	for connection in caves[current].connections {
		total_paths += count_paths(caves, connection, visited, visited_twice_local)
	}

	return total_paths
}


parse_caves :: proc(lines: []string) -> (caves: map[string]cave) {
	for connection in lines {
		connection_parts := strings.split(connection, "-", context.temp_allocator)
		for part, i in &connection_parts {
			mapped_cave, ok := &caves[part]
			if !ok {
				caves[part] = cave {
					large       = strings.to_upper(part, context.temp_allocator) == part,
					connections = {connection_parts[(i + 1) % 2]},
				}
			} else {
				append(&mapped_cave.connections, connection_parts[(i + 1) % 2])
			}
		}
	}

	return caves
}
