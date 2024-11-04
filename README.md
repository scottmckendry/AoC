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
> Benchmarks are run via [this GitHub Action](https://github.com/scottmckendry/aoc/actions/workflows/readmeStats.yml) and are not indicative of the performance of the code on your machine.
> The action uses the `ubuntu-latest` image and runs each solution 10 times to get an average. This is by no means a perfect benchmark, so take the results below with a grain of salt.

## 2023 (Go)

<!-- 2023TableStart -->
| Day | Part 1 | Part 2 | Stars |
| --- | --- | --- | --- |
| [Day 1: Trebuchet?!](https://adventofcode.com/2023/day/1) | [380µs](2023/01p1.go) | [1.431ms](2023/01p2.go) | ⭐⭐ |
| [Day 2: Cube Conundrum](https://adventofcode.com/2023/day/2) | [328µs](2023/02p1.go) | [274µs](2023/02p2.go) | ⭐⭐ |
| [Day 3: Gear Ratios](https://adventofcode.com/2023/day/3) | [357µs](2023/03p1.go) | [2.035ms](2023/03p2.go) | ⭐⭐ |
| [Day 4: Scratchcards](https://adventofcode.com/2023/day/4) | [2.863ms](2023/04p1.go) | [26.44ms](2023/04p2.go) | ⭐⭐ |
| [Day 5: If You Give a Seed A Fertilizer](https://adventofcode.com/2023/day/5) | [476µs](2023/05p1.go) | [1.993ms](2023/05p2.go) | ⭐⭐ |
| [Day 6: Wait For It](https://adventofcode.com/2023/day/6) | [25µs](2023/06p1.go) | [24µs](2023/06p2.go) | ⭐⭐ |
| [Day 7: Camel Cards](https://adventofcode.com/2023/day/7) | [1.043ms](2023/07p1.go) | [1.151ms](2023/07p2.go) | ⭐⭐ |
| [Day 8: Haunted Wasteland](https://adventofcode.com/2023/day/8) | [551µs](2023/08p1.go) | [2.476ms](2023/08p2.go) | ⭐⭐ |
| [Day 9: Mirage Maintenance](https://adventofcode.com/2023/day/9) | [699µs](2023/09p1.go) | [715µs](2023/09p2.go) | ⭐⭐ |
| [Day 10: Pipe Maze](https://adventofcode.com/2023/day/10) | [6.71ms](2023/10p1.go) | [7.579ms](2023/10p2.go) | ⭐⭐ |
| [Day 11: Cosmic Expansion](https://adventofcode.com/2023/day/11) | [11.583ms](2023/11p1.go) | [11.648ms](2023/11p2.go) | ⭐⭐ |
| [Day 12: Hot Springs](https://adventofcode.com/2023/day/12) | [2.173ms](2023/12p1.go) | [96.082ms](2023/12p2.go) | ⭐⭐ |
| [Day 13: Point of Incidence](https://adventofcode.com/2023/day/13) | [620µs](2023/13p1.go) | [60.878ms](2023/13p2.go) | ⭐⭐ |
| [Day 14: Parabolic Reflector Dish](https://adventofcode.com/2023/day/14) | [6.568ms](2023/14p1.go) | [494.032ms](2023/14p2.go) | ⭐⭐ |
| [Day 15: Lens Library](https://adventofcode.com/2023/day/15) | [169µs](2023/15p1.go) | [1.019ms](2023/15p2.go) | ⭐⭐ |
| [Day 16: The Floor Will Be Lava](https://adventofcode.com/2023/day/16) | [5.399ms](2023/16p1.go) | [874.6ms](2023/16p2.go) | ⭐⭐ |

<!-- 2023TableEnd -->

**TODO:**

-   In the process of improving the performance of Day 5 part 2, I've gone and broken it to the point where it no longer gives the correct answer. So while it is an improvement of the original 1.5 hours, it still needs some work.
-   Day 16 part 2 uses a brute force approach to find the answer. I'm certain with heavy caching and dynamic programming, it could be improved significantly.

## 2022 (Go)

<!-- 2022TableStart -->
| Day | Part 1 | Part 2 | Stars |
| --- | --- | --- | --- |
| [Day 1: Calorie Counting](https://adventofcode.com/2022/day/1) | [188µs](2022/01p1.go) | [236µs](2022/01p2.go) | ⭐⭐ |
| [Day 2: Rock Paper Scissors](https://adventofcode.com/2022/day/2) | [274µs](2022/02p1.go) | [298µs](2022/02p2.go) | ⭐⭐ |
| [Day 3: Rucksack Reorganization](https://adventofcode.com/2022/day/3) | [420µs](2022/03p1.go) | [207µs](2022/03p2.go) | ⭐⭐ |
| [Day 4: Camp Cleanup](https://adventofcode.com/2022/day/4) | [1.327ms](2022/04p1.go) | [823µs](2022/04p2.go) | ⭐⭐ |
| [Day 5: Supply Stacks](https://adventofcode.com/2022/day/5) | [765µs](2022/05p1.go) | [753µs](2022/05p2.go) | ⭐⭐ |
| [Day 6: Tuning Trouble](https://adventofcode.com/2022/day/6) | [261µs](2022/06p1.go) | [2.113ms](2022/06p2.go) | ⭐⭐ |
| [Day 7: No Space Left On Device](https://adventofcode.com/2022/day/7) | [196µs](2022/07p1.go) | [161µs](2022/07p2.go) | ⭐⭐ |
| [Day 8: Treetop Tree House](https://adventofcode.com/2022/day/8) | [318µs](2022/08p1.go) | [1.354ms](2022/08p2.go) | ⭐⭐ |
| [Day 9: Rope Bridge](https://adventofcode.com/2022/day/9) | [948µs](2022/09p1.go) | [1.713ms](2022/09p2.go) | ⭐⭐ |
| [Day 10: Cathode-Ray Tube](https://adventofcode.com/2022/day/10) | [30µs](2022/10p1.go) | [53µs](2022/10p2.go) | ⭐⭐ |
| [Day 11: Monkey in the Middle](https://adventofcode.com/2022/day/11) | [98µs](2022/11p1.go) | [14.507ms](2022/11p2.go) | ⭐⭐ |
| [Day 12: Hill Climbing Algorithm](https://adventofcode.com/2022/day/12) | [3.678ms](2022/12p1.go) | [2.948ms](2022/12p2.go) | ⭐⭐ |

<!-- 2022TableEnd -->

## 2021 (Odin)

<!-- 2021TableStart -->
| Day | Part 1 | Part 2 | Stars |
| --- | --- | --- | --- |
| [Day 1: Sonar Sweep](https://adventofcode.com/2023/day/1) | [431µs](2021/01p1.odin) | [801µs](2021/01p2.odin) | ⭐⭐ |
| [Day 2: Dive!](https://adventofcode.com/2023/day/2) | [605µs](2021/02p1.odin) | [609µs](2021/02p2.odin) | ⭐⭐ |
| [Day 3: Binary Diagnostic](https://adventofcode.com/2023/day/3) | [288µs](2021/03p1.odin) | [533µs](2021/03p2.odin) | ⭐⭐ |
| [Day 4: Giant Squid](https://adventofcode.com/2023/day/4) | [676µs](2021/04p1.odin) | [1.157ms](2021/04p2.odin) | ⭐⭐ |
| [Day 5: Hydrothermal Venture](https://adventofcode.com/2023/day/5) | [50.175ms](2021/05p1.odin) | [91.467ms](2021/05p2.odin) | ⭐⭐ |
| [Day 6: Lanternfish](https://adventofcode.com/2023/day/6) | [86µs](2021/06p1.odin) | [122µs](2021/06p2.odin) | ⭐⭐ |
| [Day 7: The Treachery of Whales](https://adventofcode.com/2023/day/7) | [4.916ms](2021/07p1.odin) | [5.041ms](2021/07p2.odin) | ⭐⭐ |
<!-- 2021TableEnd -->
