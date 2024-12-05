package main

import "core:fmt"
import "core:testing"

page_ordering_rules: []string : {
	"47|53",
	"97|13",
	"97|61",
	"97|47",
	"75|29",
	"61|13",
	"75|53",
	"29|13",
	"97|29",
	"53|29",
	"61|53",
	"97|53",
	"61|29",
	"47|13",
	"75|47",
	"97|75",
	"47|61",
	"75|61",
	"47|29",
	"75|13",
	"53|13",
	"",
	"75,47,61,53,29",
	"97,61,53,29,13",
	"75,29,13",
	"75,97,47,61,53",
	"61,13,29",
	"97,13,75,29,47",
}

@(test)
d05p1 :: proc(t: ^testing.T) {
	want := 143
	got := get_sum_middle_page_numbers(page_ordering_rules)
	testing.expect(t, got == want, fmt.aprintf("Got: %v | Want: %v", got, want))

	free_all()
}

@(test)
d05p2 :: proc(t: ^testing.T) {
	want := 123
	got := get_sum_middle_invalid_page_numbers(page_ordering_rules)
	testing.expect(t, got == want, fmt.aprintf("Got: %v | Want: %v", got, want))

	free_all()
}

@(test)
test_parse_page_ordering_rules :: proc(t: ^testing.T) {
	rules, updates := parse_page_ordering_rules(page_ordering_rules)

	seventy_five := rules[75]
	testing.expect(
		t,
		len(seventy_five) == 5,
		fmt.aprintf("Got: %v | Want: %v", len(seventy_five), 5),
	)

	testing.expect(
		t,
		seventy_five[0] == 29,
		fmt.aprintf("Got: %v | Want: %v", seventy_five[0], 47),
	)

	three_three_update := updates[3][3]

	testing.expect(t, len(updates) == 6, fmt.aprintf("Got: %v | Want: %v", len(updates), 6))

	testing.expect(
		t,
		three_three_update == 61,
		fmt.aprintf("Got: %v | Want: %v", three_three_update, 13),
	)

	free_all()
}

@(test)
test_reorder_invalid_update :: proc(t: ^testing.T) {
	rules, _ := parse_page_ordering_rules(page_ordering_rules)

	invalid_rule := [dynamic]int{75, 97, 47, 61, 53}
	want := [dynamic]int{97, 75, 47, 61, 53}

	reordered_update := reorder_invalid_update(invalid_rule, &rules)

	testing.expect(
		t,
		len(reordered_update) == len(want),
		fmt.aprintf("Got: %v | Want: %v", len(reordered_update), len(want)),
	)

	for i in 0 ..< len(reordered_update) {
		testing.expect(
			t,
			reordered_update[i] == want[i],
			fmt.aprintf("Index: %v | Got: %v | Want: %v", i, reordered_update[i], want[i]),
		)
	}

	free_all()
}
