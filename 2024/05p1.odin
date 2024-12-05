package main

import "core:fmt"
import "core:strconv"
import "core:strings"

D05P1 :: proc() {
	input_string := #load("inputs/05.txt", string)
	lines := strings.split(input_string, "\n", context.temp_allocator)

	sum_middle_page_numbers := get_sum_middle_page_numbers(lines)
	fmt.printf("Sum of all correct middle page numbers: %d\n", sum_middle_page_numbers)
}

get_sum_middle_page_numbers :: proc(page_ordering_rules: []string) -> int {
	sum := 0
	rules, updates := parse_page_ordering_rules(page_ordering_rules)
	defer {
		for _, key in rules {
			delete(key)
		}
		delete(rules)
		for update in updates {
			delete(update)
		}
		delete(updates)
	}

	valid_updates: [dynamic]int
	defer delete(valid_updates)

	for update, i in updates {
		previous_pages: [dynamic]int
		defer delete(previous_pages)
		is_valid := true
		for page in update {
			// if any page in rules appears before the rule key, it is not valid
			page_rules, ok := rules[page]
			if !ok {
				append(&previous_pages, page)
				continue
			}

			for previous_page in previous_pages {
				for rule in page_rules {
					if rule == previous_page {
						is_valid = false
						break
					}
				}
			}

			append(&previous_pages, page)
		}

		if is_valid {
			append(&valid_updates, i)
		}
	}

	for idx in valid_updates {
		// get the middle page number of all valid updates
		sum += updates[idx][len(updates[idx]) / 2]
	}

	return sum
}

parse_page_ordering_rules :: proc(
	lines: []string,
) -> (
	rules: map[int][dynamic]int,
	updates: [dynamic][dynamic]int,
) {
	updates_start_at: int
	for line, i in lines {
		if line == "" {
			updates_start_at = i + 1
			break
		}

		parts := strings.split(line, "|", context.temp_allocator)
		left := strconv.atoi(parts[0])
		right := strconv.atoi(parts[1])

		rule, ok := rules[left]
		if !ok {
			rule = [dynamic]int{}
		}

		append(&rule, right)
		rules[left] = rule
	}

	for line in lines[updates_start_at:] {
		parts := strings.split(line, ",", context.temp_allocator)
		update := [dynamic]int{}
		for part in parts {
			append(&update, strconv.atoi(part))
		}
		append(&updates, update)
	}

	return
}
