package main

import "core:fmt"
import "core:strings"

D13P2 :: proc() {
	input_string := #load("./inputs/13.txt", string)
	lines := strings.split(input_string, "\n", context.temp_allocator)

	visible_dots := fold_transparent_paper(lines, true)
	fmt.printfln("Total visible dots: %v", visible_dots)
}

draw_dots :: proc(dots: [dynamic]Vec2) {
	min_x, min_y, max_x, max_y := find_bounds(dots)
	for y := min_y; y <= max_y; y += 1 {
		for x := min_x; x <= max_x; x += 1 {
			found := false
			for dot in dots {
				if dot.x == x && dot.y == y {
					fmt.print("#")
					found = true
				}
			}

			if !found {
				fmt.print(".")
			}
		}
		fmt.print("\n")
	}
}

find_bounds :: proc(dots: [dynamic]Vec2) -> (int, int, int, int) {
	min_x, min_y := 1000000, 1000000
	max_x, max_y := -1000000, -1000000

	for dot in dots {
		if dot.x < min_x {
			min_x = dot.x
		}
		if dot.y < min_y {
			min_y = dot.y
		}
		if dot.x > max_x {
			max_x = dot.x
		}
		if dot.y > max_y {
			max_y = dot.y
		}
	}

	return min_x, min_y, max_x, max_y
}
