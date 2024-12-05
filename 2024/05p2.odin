package main

import "core:fmt"
import "core:strings"

D05P2 :: proc() {
	input_string := #load("inputs/05.txt", string)
	lines := strings.split(input_string, "\n", context.temp_allocator)

	sum_middle_page_numbers := get_sum_middle_invalid_page_numbers(lines)
	fmt.printf("Sum of all invalid middle page numbers: %d\n", sum_middle_page_numbers)
}

get_sum_middle_invalid_page_numbers :: proc(page_ordering_rules: []string) -> int {
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

	invalid_updates: [dynamic]int
	defer delete(invalid_updates)

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

		if !is_valid {
			append(&invalid_updates, i)
		}
	}

	for update in invalid_updates {
		reorderd_update := reorder_invalid_update(updates[update], &rules)
		defer delete(reorderd_update)
		sum += reorderd_update[len(reorderd_update) / 2]
	}

	return sum
}

reorder_invalid_update :: proc(
	update: [dynamic]int,
	rules: ^map[int][dynamic]int,
) -> [dynamic]int {
	ordered: [dynamic]int

	for page in update {
		insert_position := len(ordered) // default to end of list

		for ordered_page, i in ordered {
			rules_for_page, has_rules := rules[page] // get rules for page

			// if no rules, the page can be appended at the end
			if has_rules {
				for must_come_after in rules_for_page {
					if must_come_after == ordered_page {
						insert_position = min(i, insert_position)
						break
					}
				}
			}
		}

		inject_at(&ordered, insert_position, page)
	}

	return ordered
}
