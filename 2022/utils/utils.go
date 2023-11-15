package utils

import (
	"bufio"
	"fmt"
	"os"
	"time"
)

func ReadLines(path string) []string {
	file, err := os.Open(path)
	if err != nil {
		fmt.Println("Error opening file:", err)
	}

	defer file.Close()

	var lines []string
	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		lines = append(lines, scanner.Text())
	}

	return lines
}

func Benchmark(solution func()) time.Duration {
	start := time.Now()
	solution()
	fmt.Printf("Execution time: %v\n", time.Since(start))
	return time.Since(start)
}
