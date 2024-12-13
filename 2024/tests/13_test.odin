package main

import "core:fmt"
import "core:testing"

claw_machine_example :: []string {
	"Button A: X+94, Y+34",
	"Button B: X+22, Y+67",
	"Prize: X=8400, Y=5400",
	"",
	"Button A: X+26, Y+66",
	"Button B: X+67, Y+21",
	"Prize: X=12748, Y=12176",
	"",
	"Button A: X+17, Y+86",
	"Button B: X+84, Y+37",
	"Prize: X=7870, Y=6450",
	"",
	"Button A: X+69, Y+23",
	"Button B: X+27, Y+71",
	"Prize: X=18641, Y=10279",
}

@(test)
d13p1 :: proc(t: ^testing.T) {
	want :: 480
	got := get_token_cost(claw_machine_example, false)
	testing.expect(t, got == want, fmt.aprintf("Got: %v | Want: %v", got, want))

	free_all()
}

@(test)
test_parse_claw_machines :: proc(t: ^testing.T) {
	got := parse_claw_machines(claw_machine_example, false)
	got_p2 := parse_claw_machines(claw_machine_example, true)

	want_0_button_ax :: 94
	want_1_prize_x :: 12748
	want_2_button_by :: 37
	want_3_prize_y :: 10279

	want_p2_0_prize_x :: 10000000008400

	testing.expect(
		t,
		got[0].button_a.x == want_0_button_ax,
		fmt.aprintf(
			"Wanted claw_machine[0].button_a.x: %d | Got: %d",
			want_0_button_ax,
			got[0].button_a.x,
		),
	)

	testing.expect(
		t,
		got[1].prize.x == want_1_prize_x,
		fmt.aprintf(
			"Wanted claw_machine[1].prize.x: %d | Got: %d",
			want_1_prize_x,
			got[1].prize.x,
		),
	)

	testing.expect(
		t,
		got[2].button_b.y == want_2_button_by,
		fmt.aprintf(
			"Wanted claw_machine[2].button_b.y: %d | Got: %d",
			want_2_button_by,
			got[2].button_b.y,
		),
	)

	testing.expect(
		t,
		got[3].prize.y == want_3_prize_y,
		fmt.aprintf(
			"Wanted claw_machine[3].prize.y: %d | Got: %d",
			want_3_prize_y,
			got[3].prize.y,
		),
	)

	testing.expect(
		t,
		got_p2[0].prize.x == want_p2_0_prize_x,
		fmt.aprintf(
			"Wanted claw_machine[0].prize.x: %d | Got: %d",
			want_p2_0_prize_x,
			got_p2[0].prize.x,
		),
	)

	free_all()
}
