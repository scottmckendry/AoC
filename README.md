# Advent of Code 📆
All my solutions to the [Advent of Code](https://adventofcode.com/) challenges, written in Go. Possibly the only thing I will ever get into the Christmas spirit for 🎄

<p align="center">
  <img alt="grinch" src="https://github.com/scottmckendry/AoC/assets/39483124/def61fe9-d27c-4440-b033-4fb7630306e0"/>
</p>

## Project Structure
I've separated each year into its own Go module. Each day is separated into two files, one for each part of the challenge. To run a solution, simply `cd` into the directory and run `go run . -solution 01p1` (where `01p1` is the day and part you want to run).
The `-benchmark` flag can be used to time the execution of the solution. Using the `-benchmark` flag on its own will run all solutions for the year 100 times over, getting the average execution time.

> [!NOTE]
> Benchmarks are run via [this GitHub Action](https://github.com/scottmckendry/aoc/actions/workflows/readmeStats.yml) and are not indicative of the performance of the code on your machine.
> The action uses the `ubuntu-latest` image and runs each solution 100 times to get an average. This is by no means a perfect benchmark, so take the results below with a grain of salt.

## 2023
<!-- 2023TableStart -->
| Day | Part 1 | Part 2 | Stars |
| --- | --- | --- | --- |
| [Day 1: Trebuchet?!](https://adventofcode.com/2023/day/1) | [420µs](2023/01p1.go) | [1.567ms](2023/01p2.go) | ⭐⭐ |
| [Day 2: Cube Conundrum](https://adventofcode.com/2023/day/2) | [330µs](2023/02p1.go) | [338µs](2023/02p2.go) | ⭐⭐ |
| [Day 3: Gear Ratios](https://adventofcode.com/2023/day/3) | [375µs](2023/03p1.go) | [1.65ms](2023/03p2.go) | ⭐⭐ |
| [Day 4: Scratchcards](https://adventofcode.com/2023/day/4) | [3.55ms](2023/04p1.go) | [25.842ms](2023/04p2.go) | ⭐⭐ |
| [Day 5: If You Give a Seed A Fertilizer](https://adventofcode.com/2023/day/5) | [495µs](2023/05p1.go) | [2.004ms](2023/05p2.go) | ⭐⭐ |
| [Day 6: Wait For It](https://adventofcode.com/2023/day/6) | [17µs](2023/06p1.go) | [13µs](2023/06p2.go) | ⭐⭐ |
| [Day 7: Camel Cards](https://adventofcode.com/2023/day/7) | [962µs](2023/07p1.go) | [999µs](2023/07p2.go) | ⭐⭐ |
| [Day 8: Haunted Wasteland](https://adventofcode.com/2023/day/8) | [517µs](2023/08p1.go) | [2.479ms](2023/08p2.go) | ⭐⭐ |
| [Day 9: Mirage Maintenance](https://adventofcode.com/2023/day/9) | [639µs](2023/09p1.go) | [638µs](2023/09p2.go) | ⭐⭐ |
| [Day 10: Pipe Maze](https://adventofcode.com/2023/day/10) | [7.77ms](2023/10p1.go) | [8.589ms](2023/10p2.go) | ⭐⭐ |
| [Day 11: Cosmic Expansion](https://adventofcode.com/2023/day/11) | [16.78ms](2023/11p1.go) | [17.364ms](2023/11p2.go) | ⭐⭐ |
| [Day 12: Hot Springs](https://adventofcode.com/2023/day/12) | [1.075ms](2023/12p1.go) | [12.668ms](2023/12p2.go) | ⭐⭐ |
| [Day 13: Point of Incidence](https://adventofcode.com/2023/day/13) | [533µs](2023/13p1.go) | [58.545ms](2023/13p2.go) | ⭐⭐ |
| [Day 14: Parabolic Reflector Dish](https://adventofcode.com/2023/day/14) | [6.412ms](2023/14p1.go) | [488.53ms](2023/14p2.go) | ⭐⭐ |

<!-- 2023TableEnd -->
**TODO:**
- In the process of improving the performance of Day 5 part 2, I've gone and broken it to the point where it no longer gives the correct answer. So while it is an improvement of the original 1.5 hours, it still needs some work. 

## 2022
<!-- 2022TableStart -->
| Day | Part 1 | Part 2 | Stars |
| --- | --- | --- | --- |
| [Day 1: Calorie Counting](https://adventofcode.com/2022/day/1) | [191µs](2022/01p1.go) | [196µs](2022/01p2.go) | ⭐⭐ |
| [Day 2: Rock Paper Scissors](https://adventofcode.com/2022/day/2) | [204µs](2022/02p1.go) | [189µs](2022/02p2.go) | ⭐⭐ |
| [Day 3: Rucksack Reorganization](https://adventofcode.com/2022/day/3) | [293µs](2022/03p1.go) | [168µs](2022/03p2.go) | ⭐⭐ |
| [Day 4: Camp Cleanup](https://adventofcode.com/2022/day/4) | [811µs](2022/04p1.go) | [847µs](2022/04p2.go) | ⭐⭐ |
| [Day 5: Supply Stacks](https://adventofcode.com/2022/day/5) | [768µs](2022/05p1.go) | [745µs](2022/05p2.go) | ⭐⭐ |
| [Day 6: Tuning Trouble](https://adventofcode.com/2022/day/6) | [349µs](2022/06p1.go) | [2.025ms](2022/06p2.go) | ⭐⭐ |
| [Day 7: No Space Left On Device](https://adventofcode.com/2022/day/7) | [195µs](2022/07p1.go) | [161µs](2022/07p2.go) | ⭐⭐ |
| [Day 8: Treetop Tree House](https://adventofcode.com/2022/day/8) | [238µs](2022/08p1.go) | [1.303ms](2022/08p2.go) | ⭐⭐ |
| [Day 9: Rope Bridge](https://adventofcode.com/2022/day/9) | [968µs](2022/09p1.go) | [1.649ms](2022/09p2.go) | ⭐⭐ |
| [Day 10: Cathode-Ray Tube](https://adventofcode.com/2022/day/10) | [28µs](2022/10p1.go) | [55µs](2022/10p2.go) | ⭐⭐ |
| [Day 11: Monkey in the Middle](https://adventofcode.com/2022/day/11) | [134µs](2022/11p1.go) | [13.154ms](2022/11p2.go) | ⭐⭐ |
| [Day 12: Hill Climbing Algorithm](https://adventofcode.com/2022/day/12) | [3.554ms](2022/12p1.go) | [2.88ms](2022/12p2.go) | ⭐⭐ |

<!-- 2022TableEnd -->
