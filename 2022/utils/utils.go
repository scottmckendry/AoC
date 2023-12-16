package utils

import (
	"bufio"
	"fmt"
	"os"
	"reflect"
	"runtime"
	"sort"
	"strings"
	"time"
)

type SolutionStatistics struct {
	Name          string
	Day           string
	Part          string
	ExecutionTime time.Duration
}

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

func WriteLines(lines []string, path string) error {
	file, err := os.Create(path)
	if err != nil {
		fmt.Println("Error creating file:", err)
		return err
	}
	defer file.Close()

	w := bufio.NewWriter(file)
	for _, line := range lines {
		fmt.Fprintln(w, line)
	}

	return w.Flush()
}

func Benchmark(solution func()) time.Duration {
	start := time.Now()
	solution()
	fmt.Printf("Execution time: %v\n", time.Since(start))
	return time.Since(start)
}

func GetSolutionStatistics(solutions map[string]func()) []SolutionStatistics {
	var statistics []SolutionStatistics

	// Sort the keys so that the statistics are always in the same order
	var orderedKeys []string
	for key := range solutions {
		orderedKeys = append(orderedKeys, key)
	}
	sort.Strings(orderedKeys)

	for _, name := range orderedKeys {
		functionName := runtime.FuncForPC(reflect.ValueOf(solutions[name]).Pointer()).Name()
		problemName := strings.Split(name, ":")[1]

		averageExecutionTime := time.Duration(0)
		for i := 0; i < 10; i++ {
			averageExecutionTime += Benchmark(solutions[name])
		}

		statistics = append(statistics, SolutionStatistics{
			Name:          problemName,
			Day:           functionName[6:8],
			Part:          functionName[9:10],
			ExecutionTime: (averageExecutionTime / 100).Round(time.Microsecond),
		})
	}

	return statistics
}

func SortInts(ints []int) []int {
	for i := 0; i < len(ints); i++ {
		for j := i + 1; j < len(ints); j++ {
			if ints[i] > ints[j] {
				ints[i], ints[j] = ints[j], ints[i]
			}
		}
	}
	return ints
}
