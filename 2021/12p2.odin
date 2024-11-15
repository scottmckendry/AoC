package main

import "core:fmt"
import "utils"

D12P2 :: proc() {
	lines, backing := utils.read_lines("./inputs/12.txt")
	defer delete(lines)
	defer delete(backing)

	small_cave_path_total := traverse_caves(lines, false)
	fmt.printfln("Paths through small caves: %v", small_cave_path_total)
}
