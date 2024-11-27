package main

import "core:fmt"
import "core:strings"

D04P2 :: proc() {
	input_string := #load("./inputs/04.txt", string)
	lines := strings.split(input_string, "\n", context.temp_allocator)

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
	winning_card: int
	winning_drawing := 0
	for drawing in drawings {
		for &card in cards {
			if card.won {
				continue
			}

			for &row in card.numbers {
				for &number in row {
					if number.number == drawing {
						number.drawn = true
					}
				}
			}

			current_card = check_bingo(card)
			if current_card != 0 {
				card.won = true
				winning_card = current_card
				winning_drawing = drawing
			}
		}
	}

	return winning_card * winning_drawing
}
