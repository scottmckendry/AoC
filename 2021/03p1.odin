package main

import "core:fmt"
import "core:strconv"
import "core:strings"

D03P1 :: proc() {
	input_string := #load("./inputs/03.txt", string)
	lines := strings.split(input_string, "\n", context.temp_allocator)

	power_consumption := calculate_power_consumption(lines)
	fmt.printfln("Power consumption: %v", power_consumption)
}

calculate_power_consumption :: proc(input: []string) -> int {
	gamma_rate_str := "0b" // binary uint prefix - used to imply base 2 when parsing

	for i := 0; i < len(input[0]); i += 1 {
		one_count := 0
		zero_count := 0
		for line in input {
			if line == "" {
				continue
			}

			if line[i] == '1' {
				one_count += 1
			} else {
				zero_count += 1
			}
		}

		if one_count > zero_count {
			gamma_rate_str = strings.concatenate({gamma_rate_str, "1"}, context.temp_allocator)
		} else {
			gamma_rate_str = strings.concatenate({gamma_rate_str, "0"}, context.temp_allocator)
		}
	}

	gamma_rate, _ := strconv.parse_uint(gamma_rate_str)
	epsilon_rate := ~gamma_rate & ((0b1 << len(input[0])) - 1) // bitwise flip with mask https://stackoverflow.com/questions/6351374/bitwise-operator-for-simply-flipping-all-bits-in-an-integer

	return int(gamma_rate * epsilon_rate)
}
