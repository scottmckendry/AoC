package main

import "core:fmt"
import "core:strconv"
import "core:strings"

D13P1 :: proc() {
	input_string := #load("./inputs/13.txt", string)
	lines := strings.split(input_string, "\n", context.temp_allocator)

	visible_dots := fold_transparent_paper(lines, false)
	fmt.printfln("Total visible dots: %v", visible_dots)
}

fold_transparent_paper :: proc(lines: []string, all: bool) -> int {
	dots, folds := parse_fold_instructions(lines)
	defer delete(dots)
	defer delete(folds)

	if !all {
		apply_fold(&dots, folds[0])
		return len(dots)
	}

	for fold in folds {
		apply_fold(&dots, fold)
	}

	draw_dots(dots)
	return len(dots)
}

parse_fold_instructions :: proc(lines: []string) -> (dots: [dynamic]Vec2, folds: [dynamic]string) {
	instruction_start: int
	for line in lines {
		if line == "" {
			break
		}

		dot := Vec2{0, 0}
		line_parts := strings.split(line, ",", context.temp_allocator)
		dot.x = strconv.atoi(line_parts[0])
		dot.y = strconv.atoi(line_parts[1])
		append(&dots, dot)

		instruction_start += 1
	}

	for i := instruction_start + 1; i < len(lines); i += 1 {
		line := lines[i]

		fold_prefix := "fold along "
		if len(line) > len(fold_prefix) {
			fold := line[len(fold_prefix):]
			append(&folds, fold)
		}
	}

	return
}

apply_fold :: proc(dots: ^[dynamic]Vec2, fold: string) {
	if strings.contains(fold, "x=") {
		fold_x := strconv.atoi(strings.split(fold, "=", context.temp_allocator)[1])
		for i := 0; i < len(dots); i += 1 {
			if dots[i].x > fold_x {
				dots[i].x = fold_x - (dots[i].x - fold_x)
			}
		}
	} else if strings.contains(fold, "y=") {
		fold_y := strconv.atoi(strings.split(fold, "=", context.temp_allocator)[1])
		for i := 0; i < len(dots); i += 1 {
			if dots[i].y > fold_y {
				dots[i].y = fold_y - (dots[i].y - fold_y)
			}
		}
	}

	// remove duplicates
	for i := 0; i < len(dots); i += 1 {
		for j := i + 1; j < len(dots); j += 1 {
			if dots[i] == dots[j] {
				unordered_remove(dots, j)
			}
		}
	}
}
