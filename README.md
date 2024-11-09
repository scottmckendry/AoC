# Advent of Code 📆

All my solutions to the [Advent of Code](https://adventofcode.com/) challenges, written in Go/Odin. Possibly the only thing I will ever get into the Christmas spirit for 🎄

<p align="center">
  <img alt="grinch" src="https://github.com/scottmckendry/AoC/assets/39483124/def61fe9-d27c-4440-b033-4fb7630306e0"/>
</p>

## Project Structure

I've separated each year into its own Go module. Each day is separated into two files, one for each part of the challenge. To run a solution, simply `cd` into the directory and run `go run . -solution 01p1` (where `01p1` is the day and part you want to run).
The `-benchmark` flag can be used to time the execution of the solution. Using the `-benchmark` flag on its own will run all solutions for the year 10 times over, getting the average execution time.

The same is true for Odin solutions, except the command to run the solution is `odin run . -solution 01p1`.

> [!NOTE]
> Benchmarks are run via [this GitHub Action](https://github.com/scottmckendry/aoc/actions/workflows/CI.yml) and are not indicative of the performance of the code on your machine.
> The action uses the `ubuntu-latest` image and runs each solution 10 times to get an average. This is by no means a perfect benchmark, so take the results below with a grain of salt.

## 2023 (Go)

<!-- 2023TableStart -->
| Day | Part 1 | Part 2 | Stars |
| --- | --- | --- | --- |
| [Day 1: Trebuchet?!](https://adventofcode.com/2023/day/1) | [423µs](2023/01p1.go) | [1.423ms](2023/01p2.go) | ⭐⭐ |
| [Day 2: Cube Conundrum](https://adventofcode.com/2023/day/2) | [344µs](2023/02p1.go) | [269µs](2023/02p2.go) | ⭐⭐ |
| [Day 3: Gear Ratios](https://adventofcode.com/2023/day/3) | [396µs](2023/03p1.go) | [2.096ms](2023/03p2.go) | ⭐⭐ |
| [Day 4: Scratchcards](https://adventofcode.com/2023/day/4) | [3.123ms](2023/04p1.go) | [25.177ms](2023/04p2.go) | ⭐⭐ |
| [Day 5: If You Give a Seed A Fertilizer](https://adventofcode.com/2023/day/5) | [443µs](2023/05p1.go) | [1.938ms](2023/05p2.go) | ⭐⭐ |
| [Day 6: Wait For It](https://adventofcode.com/2023/day/6) | [22µs](2023/06p1.go) | [24µs](2023/06p2.go) | ⭐⭐ |
| [Day 7: Camel Cards](https://adventofcode.com/2023/day/7) | [871µs](2023/07p1.go) | [966µs](2023/07p2.go) | ⭐⭐ |
| [Day 8: Haunted Wasteland](https://adventofcode.com/2023/day/8) | [567µs](2023/08p1.go) | [2.524ms](2023/08p2.go) | ⭐⭐ |
| [Day 9: Mirage Maintenance](https://adventofcode.com/2023/day/9) | [666µs](2023/09p1.go) | [710µs](2023/09p2.go) | ⭐⭐ |
| [Day 10: Pipe Maze](https://adventofcode.com/2023/day/10) | [6.55ms](2023/10p1.go) | [7.294ms](2023/10p2.go) | ⭐⭐ |
| [Day 11: Cosmic Expansion](https://adventofcode.com/2023/day/11) | [10.868ms](2023/11p1.go) | [12.868ms](2023/11p2.go) | ⭐⭐ |
| [Day 12: Hot Springs](https://adventofcode.com/2023/day/12) | [2.142ms](2023/12p1.go) | [94.597ms](2023/12p2.go) | ⭐⭐ |
| [Day 13: Point of Incidence](https://adventofcode.com/2023/day/13) | [522µs](2023/13p1.go) | [60.776ms](2023/13p2.go) | ⭐⭐ |
| [Day 14: Parabolic Reflector Dish](https://adventofcode.com/2023/day/14) | [6.527ms](2023/14p1.go) | [495.177ms](2023/14p2.go) | ⭐⭐ |
| [Day 15: Lens Library](https://adventofcode.com/2023/day/15) | [165µs](2023/15p1.go) | [1.032ms](2023/15p2.go) | ⭐⭐ |
| [Day 16: The Floor Will Be Lava](https://adventofcode.com/2023/day/16) | [5.235ms](2023/16p1.go) | [868.589ms](2023/16p2.go) | ⭐⭐ |

<!-- 2023TableEnd -->

**TODO:**

-   In the process of improving the performance of Day 5 part 2, I've gone and broken it to the point where it no longer gives the correct answer. So while it is an improvement of the original 1.5 hours, it still needs some work.
-   Day 16 part 2 uses a brute force approach to find the answer. I'm certain with heavy caching and dynamic programming, it could be improved significantly.

## 2022 (Go)

<!-- 2022TableStart -->
| Day | Part 1 | Part 2 | Stars |
| --- | --- | --- | --- |
| [Day 1: Calorie Counting](https://adventofcode.com/2022/day/1) | [217µs](2022/01p1.go) | [202µs](2022/01p2.go) | ⭐⭐ |
| [Day 2: Rock Paper Scissors](https://adventofcode.com/2022/day/2) | [222µs](2022/02p1.go) | [277µs](2022/02p2.go) | ⭐⭐ |
| [Day 3: Rucksack Reorganization](https://adventofcode.com/2022/day/3) | [262µs](2022/03p1.go) | [170µs](2022/03p2.go) | ⭐⭐ |
| [Day 4: Camp Cleanup](https://adventofcode.com/2022/day/4) | [748µs](2022/04p1.go) | [623µs](2022/04p2.go) | ⭐⭐ |
| [Day 5: Supply Stacks](https://adventofcode.com/2022/day/5) | [686µs](2022/05p1.go) | [708µs](2022/05p2.go) | ⭐⭐ |
| [Day 6: Tuning Trouble](https://adventofcode.com/2022/day/6) | [308µs](2022/06p1.go) | [2.158ms](2022/06p2.go) | ⭐⭐ |
| [Day 7: No Space Left On Device](https://adventofcode.com/2022/day/7) | [254µs](2022/07p1.go) | [172µs](2022/07p2.go) | ⭐⭐ |
| [Day 8: Treetop Tree House](https://adventofcode.com/2022/day/8) | [249µs](2022/08p1.go) | [1.456ms](2022/08p2.go) | ⭐⭐ |
| [Day 9: Rope Bridge](https://adventofcode.com/2022/day/9) | [966µs](2022/09p1.go) | [1.721ms](2022/09p2.go) | ⭐⭐ |
| [Day 10: Cathode-Ray Tube](https://adventofcode.com/2022/day/10) | [32µs](2022/10p1.go) | [54µs](2022/10p2.go) | ⭐⭐ |
| [Day 11: Monkey in the Middle](https://adventofcode.com/2022/day/11) | [104µs](2022/11p1.go) | [13.96ms](2022/11p2.go) | ⭐⭐ |
| [Day 12: Hill Climbing Algorithm](https://adventofcode.com/2022/day/12) | [3.665ms](2022/12p1.go) | [2.902ms](2022/12p2.go) | ⭐⭐ |

<!-- 2022TableEnd -->

## 2021 (Odin)

<!-- 2021TableStart -->
| Day | Part 1 | Part 2 | Stars |
| --- | --- | --- | --- |
| [Day 1: Sonar Sweep](https://adventofcode.com/2023/day/1) | [473µs](2021/01p1.odin) | [871µs](2021/01p2.odin) | ⭐⭐ |
| [Day 2: Dive!](https://adventofcode.com/2023/day/2) | [668µs](2021/02p1.odin) | [651µs](2021/02p2.odin) | ⭐⭐ |
| [Day 3: Binary Diagnostic](https://adventofcode.com/2023/day/3) | [330µs](2021/03p1.odin) | [582µs](2021/03p2.odin) | ⭐⭐ |
| [Day 4: Giant Squid](https://adventofcode.com/2023/day/4) | [713µs](2021/04p1.odin) | [1.203ms](2021/04p2.odin) | ⭐⭐ |
| [Day 5: Hydrothermal Venture](https://adventofcode.com/2023/day/5) | [47.776ms](2021/05p1.odin) | [86.24ms](2021/05p2.odin) | ⭐⭐ |
| [Day 6: Lanternfish](https://adventofcode.com/2023/day/6) | [100µs](2021/06p1.odin) | [129µs](2021/06p2.odin) | ⭐⭐ |
| [Day 7: The Treachery of Whales](https://adventofcode.com/2023/day/7) | [1.417ms](2021/07p1.odin) | [1.591ms](2021/07p2.odin) | ⭐⭐ |
| [Day 8: Seven Segment Search](https://adventofcode.com/2023/day/8) | [421µs](2021/08p1.odin) | [5.007ms](2021/08p2.odin) | ⭐⭐ |
| [Day 9: Smoke Basin](https://adventofcode.com/2023/day/9) | [666µs](2021/09p1.odin) | [7.69ms](2021/09p2.odin) | ⭐⭐ |
<!-- 2021TableEnd -->
