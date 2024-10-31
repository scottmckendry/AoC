package main

import "core:fmt"
import "utils"

D04P2 :: proc() {
	lines, backing := utils.read_lines("./inputs/04.txt")
	defer delete(lines)
	defer delete(backing)

	winning_score := get_last_bingo_winner_score(lines)
	fmt.printfln("Last bingo winner score: %d", winning_score)
}

get_last_bingo_winner_score :: proc(input: []string) -> int {
	drawings := parse_bingo_drawings(input)
	cards: [dynamic]bingo_card
	defer delete(drawings)
	defer delete(cards)

	for i := 2; i < len(input); i += 6 {
		append(&cards, parse_bingo_card(input[i:i + 5]))
	}

    current_card := 0
    draw_index := 0
    current_card_idx := 0
	winning_card: int
	winning_index := 0
	for draw_index < len(drawings) {
		for &card in cards {
			for &row in card.numbers {
				for &number in row {
					if number.number == drawings[draw_index] {
						number.drawn = true
					}
				}
			}
		}

		current_card, current_card_idx = check_bingo(cards)
        if current_card != 0 {
            winning_card = current_card
            winning_index = draw_index
            ordered_remove(&cards, current_card_idx)
        }
		draw_index += 1
	}

	return winning_card * drawings[winning_index]
}
