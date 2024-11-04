package main

import "core:fmt"
import "utils"

D07P2 :: proc() {
	lines, backing := utils.read_lines("./inputs/07.txt")
	defer delete(lines)
	defer delete(backing)

	least_fuel := least_fuel_crab_alignment(lines[0], true)
	fmt.printfln("Least fuel required to align crabs: %v", least_fuel)
}
