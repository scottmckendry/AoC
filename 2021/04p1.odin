package main

import "core:fmt"
import "core:strconv"
import "core:strings"
import "utils"

bingo_card :: struct {
	won:     bool,
	numbers: [5][5]bingo_number,
}

bingo_number :: struct {
	number: int,
	drawn:  bool,
}

D04P1 :: proc() {
	lines, backing := utils.read_lines("./inputs/04.txt")
	defer delete(lines)
	defer delete(backing)

	winning_score := get_winning_bingo_score(lines)
	fmt.printfln("Winning bingo score: %v", winning_score)
}

get_winning_bingo_score :: proc(input: []string) -> int {
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
	game_won := false
	for drawing in drawings {
		if game_won {
			break
		}
		for &card in cards {
			for &row in card.numbers {
				for &number in row {
					if number.number == drawing {
						number.drawn = true
					}
				}
			}
			current_card = check_bingo(card)
			if current_card != 0 {
				game_won = true
				winning_card = current_card
				winning_drawing = drawing
			}
		}
	}

	return winning_card * winning_drawing
}

parse_bingo_drawings :: proc(input: []string) -> [dynamic]int {
	drawings_str := strings.split(input[0], ",", context.temp_allocator)
	drawings: [dynamic]int

	for drawing_str in drawings_str {
		append(&drawings, strconv.atoi(drawing_str))
	}
	return drawings
}

parse_bingo_card :: proc(raw_card: []string) -> bingo_card {
	card: bingo_card
	for row, i in raw_card {
		numbers_str := strings.split(row, " ", context.temp_allocator)
		j := 0
		for col in numbers_str {
			if col == "" {
				continue
			}
			card.numbers[i][j].number = strconv.atoi(col)
			j += 1
		}
	}
	return card
}

check_bingo :: proc(card: bingo_card) -> int {
	// Check rows
	for row in card.numbers {
		if row[0].drawn && row[1].drawn && row[2].drawn && row[3].drawn && row[4].drawn {
			return get_unmarked_sum(card)
		}
	}
	// Check columns
	for i := 0; i < 5; i += 1 {
		if card.numbers[0][i].drawn &&
		   card.numbers[1][i].drawn &&
		   card.numbers[2][i].drawn &&
		   card.numbers[3][i].drawn &&
		   card.numbers[4][i].drawn {
			return get_unmarked_sum(card)
		}
	}

	return 0
}

get_unmarked_sum :: proc(card: bingo_card) -> int {
	sum := 0
	for row in card.numbers {
		for number in row {
			if !number.drawn {
				sum += number.number
			}
		}
	}
	return sum
}
