package main

import "core:fmt"
import "utils"

D06P2 :: proc() {
	lines, backing := utils.read_lines("./inputs/06.txt")
	defer delete(lines)
	defer delete(backing)

	days := 256
	total_lanterfish := simulate_lanterfish_growth(lines[0], days)
	fmt.printfln("Number of lanterfish after %v days: %v", days, total_lanterfish)
}
