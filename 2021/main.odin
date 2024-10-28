package main

import "core:fmt"
import "core:os"
import "core:strconv"
import "core:strings"
import "utils"


main :: proc() {
	solutions: map[string]proc() = {
		"01P1:Sonar Sweep" = D01P1,
	}

	for _, solution in solutions {
		utils.benchmark(solution)
	}
}
