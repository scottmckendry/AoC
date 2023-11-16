package main

import (
	"aoc/utils"
)

var solutions = []func(){
	D01P1, D01P2, D02P1, D02P2, D03P1, D03P2, D04P1, D04P2, D05P1, D05P2, D06P1, D06P2, D07P1, D07P2, D08P1, D08P2,
}

func main() {
	for _, solution := range solutions {
		utils.Benchmark(solution)
	}
}
