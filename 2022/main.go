package main

import (
	"aoc/utils"
)

var solutions = map[string]func(){
	"01p1": D01P1,
	"01p2": D01P2,
}

func main() {
	for _, solution := range solutions {
		utils.Benchmark(solution)
	}
}
