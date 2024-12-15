package main

import "core:fmt"
import "core:testing"

robots_example :: []string {
	"p=0,4 v=3,-3",
	"p=6,3 v=-1,-3",
	"p=10,3 v=-1,2",
	"p=2,0 v=2,-1",
	"p=0,0 v=1,3",
	"p=3,0 v=-2,-2",
	"p=7,6 v=-1,-3",
	"p=3,0 v=-1,-2",
	"p=9,3 v=2,3",
	"p=7,3 v=-1,2",
	"p=2,4 v=2,-3",
	"p=9,5 v=-3,-3",
}

@(test)
d14p1 :: proc(t: ^testing.T) {
	want :: 12
	got := calculate_safety_factor(robots_example, vec2{10, 6})
	testing.expect(t, got == want, fmt.aprintf("Got: %v | Want: %v", got, want))

	free_all()
}

@(test)
test_parse_robots :: proc(t: ^testing.T) {
	got := parse_robots(robots_example)
	want_len := 12
	want_3_px := 2
	want_5_vy := -2

	testing.expect(t, len(got) == want_len, fmt.aprintf("Got: %v | Want: %v", len(got), want_len))
	testing.expect(
		t,
		got[3].pos.x == want_3_px,
		fmt.aprintf("Got: %v | Want: %v", got[3].pos.x, want_3_px),
	)
	testing.expect(
		t,
		got[5].vel.y == want_5_vy,
		fmt.aprintf("Got: %v | Want: %v", got[5].vel.y, want_5_vy),
	)


	free_all()
}

@(test)
test_apply_robot_velocity :: proc(t: ^testing.T) {
	r := robot {
		pos = vec2{2, 4},
		vel = vec2{2, -3},
	}

	bounds := vec2{10, 6}

	// step forward 1 second
	apply_robot_velocity(&r, 1, bounds)
	want_pos := vec2{4, 1}

	testing.expect_value(t, r.pos.x, want_pos.x)
	testing.expect_value(t, r.pos.y, want_pos.y)

	// step forward 1 second
	apply_robot_velocity(&r, 1, bounds)
	want_pos = vec2{6, 5}

	testing.expect_value(t, r.pos.x, want_pos.x)
	testing.expect_value(t, r.pos.y, want_pos.y)

	// step forward 3 seconds
	apply_robot_velocity(&r, 3, bounds)
	want_pos = vec2{1, 3}

	testing.expect_value(t, r.pos.x, want_pos.x)
	testing.expect_value(t, r.pos.y, want_pos.y)

	free_all()
}
