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

## 2024 (Odin)

<!-- 2024TableStart -->
| Day | Part 1 | Part 2 | Stars |
| --- | --- | --- | --- |
| [Day 1: Historian Hysteria](https://adventofcode.com/2024/day/1) | [236µs](2024/01p1.odin) | [340µs](2024/01p2.odin) | ⭐⭐ |
| [Day 2: Red-Nosed Reports](https://adventofcode.com/2024/day/2) | [517µs](2024/02p1.odin) | [1.232ms](2024/02p2.odin) | ⭐⭐ |
<!-- 2024TableEnd -->

## 2023 (Go)

<!-- 2023TableStart -->
| Day | Part 1 | Part 2 | Stars |
| --- | --- | --- | --- |
| [Day 1: Trebuchet?!](https://adventofcode.com/2023/day/1) | [503µs](2023/01p1.go) | [1.449ms](2023/01p2.go) | ⭐⭐ |
| [Day 2: Cube Conundrum](https://adventofcode.com/2023/day/2) | [341µs](2023/02p1.go) | [234µs](2023/02p2.go) | ⭐⭐ |
| [Day 3: Gear Ratios](https://adventofcode.com/2023/day/3) | [336µs](2023/03p1.go) | [1.692ms](2023/03p2.go) | ⭐⭐ |
| [Day 4: Scratchcards](https://adventofcode.com/2023/day/4) | [3.008ms](2023/04p1.go) | [25.539ms](2023/04p2.go) | ⭐⭐ |
| [Day 5: If You Give a Seed A Fertilizer](https://adventofcode.com/2023/day/5) | [579µs](2023/05p1.go) | [1.993ms](2023/05p2.go) | ⭐⭐ |
| [Day 6: Wait For It](https://adventofcode.com/2023/day/6) | [19µs](2023/06p1.go) | [18µs](2023/06p2.go) | ⭐⭐ |
| [Day 7: Camel Cards](https://adventofcode.com/2023/day/7) | [984µs](2023/07p1.go) | [977µs](2023/07p2.go) | ⭐⭐ |
| [Day 8: Haunted Wasteland](https://adventofcode.com/2023/day/8) | [508µs](2023/08p1.go) | [2.594ms](2023/08p2.go) | ⭐⭐ |
| [Day 9: Mirage Maintenance](https://adventofcode.com/2023/day/9) | [696µs](2023/09p1.go) | [704µs](2023/09p2.go) | ⭐⭐ |
| [Day 10: Pipe Maze](https://adventofcode.com/2023/day/10) | [6.772ms](2023/10p1.go) | [7.233ms](2023/10p2.go) | ⭐⭐ |
| [Day 11: Cosmic Expansion](https://adventofcode.com/2023/day/11) | [11.217ms](2023/11p1.go) | [13.878ms](2023/11p2.go) | ⭐⭐ |
| [Day 12: Hot Springs](https://adventofcode.com/2023/day/12) | [2.552ms](2023/12p1.go) | [92.01ms](2023/12p2.go) | ⭐⭐ |
| [Day 13: Point of Incidence](https://adventofcode.com/2023/day/13) | [576µs](2023/13p1.go) | [61.83ms](2023/13p2.go) | ⭐⭐ |
| [Day 14: Parabolic Reflector Dish](https://adventofcode.com/2023/day/14) | [6.486ms](2023/14p1.go) | [483.771ms](2023/14p2.go) | ⭐⭐ |
| [Day 15: Lens Library](https://adventofcode.com/2023/day/15) | [158µs](2023/15p1.go) | [988µs](2023/15p2.go) | ⭐⭐ |
| [Day 16: The Floor Will Be Lava](https://adventofcode.com/2023/day/16) | [4.951ms](2023/16p1.go) | [865.135ms](2023/16p2.go) | ⭐⭐ |

<!-- 2023TableEnd -->

**TODO:**

-   In the process of improving the performance of Day 5 part 2, I've gone and broken it to the point where it no longer gives the correct answer. So while it is an improvement of the original 1.5 hours, it still needs some work.
-   Day 16 part 2 uses a brute force approach to find the answer. I'm certain with heavy caching and dynamic programming, it could be improved significantly.

## 2022 (Go)

<!-- 2022TableStart -->
| Day | Part 1 | Part 2 | Stars |
| --- | --- | --- | --- |
| [Day 1: Calorie Counting](https://adventofcode.com/2022/day/1) | [193µs](2022/01p1.go) | [221µs](2022/01p2.go) | ⭐⭐ |
| [Day 2: Rock Paper Scissors](https://adventofcode.com/2022/day/2) | [257µs](2022/02p1.go) | [244µs](2022/02p2.go) | ⭐⭐ |
| [Day 3: Rucksack Reorganization](https://adventofcode.com/2022/day/3) | [224µs](2022/03p1.go) | [148µs](2022/03p2.go) | ⭐⭐ |
| [Day 4: Camp Cleanup](https://adventofcode.com/2022/day/4) | [686µs](2022/04p1.go) | [654µs](2022/04p2.go) | ⭐⭐ |
| [Day 5: Supply Stacks](https://adventofcode.com/2022/day/5) | [728µs](2022/05p1.go) | [681µs](2022/05p2.go) | ⭐⭐ |
| [Day 6: Tuning Trouble](https://adventofcode.com/2022/day/6) | [267µs](2022/06p1.go) | [2.024ms](2022/06p2.go) | ⭐⭐ |
| [Day 7: No Space Left On Device](https://adventofcode.com/2022/day/7) | [194µs](2022/07p1.go) | [186µs](2022/07p2.go) | ⭐⭐ |
| [Day 8: Treetop Tree House](https://adventofcode.com/2022/day/8) | [244µs](2022/08p1.go) | [1.263ms](2022/08p2.go) | ⭐⭐ |
| [Day 9: Rope Bridge](https://adventofcode.com/2022/day/9) | [945µs](2022/09p1.go) | [1.729ms](2022/09p2.go) | ⭐⭐ |
| [Day 10: Cathode-Ray Tube](https://adventofcode.com/2022/day/10) | [45µs](2022/10p1.go) | [102µs](2022/10p2.go) | ⭐⭐ |
| [Day 11: Monkey in the Middle](https://adventofcode.com/2022/day/11) | [72µs](2022/11p1.go) | [13.098ms](2022/11p2.go) | ⭐⭐ |
| [Day 12: Hill Climbing Algorithm](https://adventofcode.com/2022/day/12) | [3.624ms](2022/12p1.go) | [2.913ms](2022/12p2.go) | ⭐⭐ |

<!-- 2022TableEnd -->

## 2021 (Odin)

<!-- 2021TableStart -->
| Day | Part 1 | Part 2 | Stars |
| --- | --- | --- | --- |
| [Day 1: Sonar Sweep](https://adventofcode.com/2021/day/1) | [128µs](2021/01p1.odin) | [258µs](2021/01p2.odin) | ⭐⭐ |
| [Day 2: Dive!](https://adventofcode.com/2021/day/2) | [158µs](2021/02p1.odin) | [173µs](2021/02p2.odin) | ⭐⭐ |
| [Day 3: Binary Diagnostic](https://adventofcode.com/2021/day/3) | [78µs](2021/03p1.odin) | [381µs](2021/03p2.odin) | ⭐⭐ |
| [Day 4: Giant Squid](https://adventofcode.com/2021/day/4) | [191µs](2021/04p1.odin) | [337µs](2021/04p2.odin) | ⭐⭐ |
| [Day 5: Hydrothermal Venture](https://adventofcode.com/2021/day/5) | [21.051ms](2021/05p1.odin) | [37.443ms](2021/05p2.odin) | ⭐⭐ |
| [Day 6: Lanternfish](https://adventofcode.com/2021/day/6) | [6µs](2021/06p1.odin) | [12µs](2021/06p2.odin) | ⭐⭐ |
| [Day 7: The Treachery of Whales](https://adventofcode.com/2021/day/7) | [483µs](2021/07p1.odin) | [632µs](2021/07p2.odin) | ⭐⭐ |
| [Day 8: Seven Segment Search](https://adventofcode.com/2021/day/8) | [48µs](2021/08p1.odin) | [1.154ms](2021/08p2.odin) | ⭐⭐ |
| [Day 9: Smoke Basin](https://adventofcode.com/2021/day/9) | [136µs](2021/09p1.odin) | [2.75ms](2021/09p2.odin) | ⭐⭐ |
| [Day 10: Syntax Scoring](https://adventofcode.com/2021/day/10) | [263µs](2021/10p1.odin) | [349µs](2021/10p2.odin) | ⭐⭐ |
| [Day 11: Dumbo Octopus](https://adventofcode.com/2021/day/11) | [132µs](2021/11p1.odin) | [266µs](2021/11p2.odin) | ⭐⭐ |
| [Day 12: Passage Pathfinding](https://adventofcode.com/2021/day/12) | [2.304ms](2021/12p1.odin) | [56.007ms](2021/12p2.odin) | ⭐⭐ |
| [Day 13: Transparent Oragami](https://adventofcode.com/2021/day/13) | [527µs](2021/13p1.odin) | [1.55ms](2021/13p2.odin) | ⭐⭐ |
<!-- 2021TableEnd -->
