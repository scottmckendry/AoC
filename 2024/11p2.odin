package main

import "core:fmt"

D11P2 :: proc() {
	input := #load("inputs/11.txt", string)

	num_stones := simulate_stones(input, 75)
	fmt.printf("Number of stones after 75 generations: %d\n", num_stones)
}
