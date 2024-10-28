package main

import "core:fmt"
import "core:strconv"
import "core:time"
import "utils"

D01P2 :: proc() {
	lines := utils.read_lines("./inputs/01p1.txt")
	depth_increase_count := get_depth_increase_count(lines)
	fmt.printfln("Depth increasd %v times.", depth_increase_count)
}
