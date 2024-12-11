package main

import "core:fmt"
import "core:math"
import "core:strconv"
import "core:strings"

D11P1 :: proc() {
	input := #load("inputs/11.txt", string)

	num_stones := simulate_stones(input, 25)
	fmt.printf("Number of stones after 25 generations: %d\n", num_stones)
}

simulate_stones :: proc(input: string, blinks: int) -> int {
	stones := parse_stones(input)
	defer delete(stones)

	for _ in 0 ..< blinks {
		stones = simulate_blink(stones)
	}

	sum := 0
	for _, stone_count in stones {
		sum += stone_count
	}
	return sum
}

parse_stones :: proc(input: string) -> (stones: map[int]int) {
	stone_strs := strings.split(input, " ", context.temp_allocator)
	for str in stone_strs {
		value := strconv.atoi(str)
		stone_count, ok := stones[value]
		if !ok {
			stones[value] = 1
		}
		stones[value] = stone_count + 1
	}
	return
}

simulate_blink :: proc(stones: map[int]int) -> (new_stones: map[int]int) {
	for stone_value, stone_count in stones {
		if stone_value == 0 {
			new_stones[1] += stone_count
			continue
		}

		num_digits := get_num_digits(stone_value)
		if num_digits % 2 == 0 {
			half := num_digits / 2
			left := stone_value / int(math.pow(10, f64(half)))
			right := stone_value % int(math.pow(10, f64(half)))

			new_stones[left] += stone_count
			new_stones[right] += stone_count
			continue
		}

		new_stones[stone_value * 2024] += stone_count
	}
	delete(stones)

	return
}

get_num_digits :: proc(num: int) -> int {
	num_digits := 0
	num_copy := num
	for num_copy > 0 {
		num_digits += 1
		num_copy /= 10
	}
	return num_digits
}
