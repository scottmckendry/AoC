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
| [Day 1: Historian Hysteria](https://adventofcode.com/2024/day/1) | [231µs](2024/01p1.odin) | [305µs](2024/01p2.odin) | ⭐⭐ |
| [Day 2: Red-Nosed Reports](https://adventofcode.com/2024/day/2) | [467µs](2024/02p1.odin) | [1ms](2024/02p2.odin) | ⭐⭐ |
| [Day 3: Mull It Over](https://adventofcode.com/2024/day/3) | [69µs](2024/03p1.odin) | [71µs](2024/03p2.odin) | ⭐⭐ |
| [Day 4: Ceres Search](https://adventofcode.com/2024/day/4) | [478µs](2024/04p1.odin) | [146µs](2024/04p2.odin) | ⭐⭐ |
| [Day 5: Print Queue](https://adventofcode.com/2024/day/5) | [834µs](2024/05p1.odin) | [1.4ms](2024/05p2.odin) | ⭐⭐ |
| [Day 6: Guard Gallivant](https://adventofcode.com/2024/day/6) | [3.6ms](2024/06p1.odin) | [651.1ms](2024/06p2.odin) | ⭐⭐ |
| [Day 7: Bridge Repair](https://adventofcode.com/2024/day/7) | [1.7ms](2024/07p1.odin) | [27.2ms](2024/07p2.odin) | ⭐⭐ |
| [Day 8: Resonant Collinearity](https://adventofcode.com/2024/day/8) | [198µs](2024/08p1.odin) | [430µs](2024/08p2.odin) | ⭐⭐ |
| [Day 9: Disk Fragmenter](https://adventofcode.com/2024/day/9) | [1.6ms](2024/09p1.odin) | [443.1ms](2024/09p2.odin) | ⭐⭐ |
| [Day 10: Hoof It](https://adventofcode.com/2024/day/10) | [441µs](2024/10p1.odin) | [422µs](2024/10p2.odin) | ⭐⭐ |
| [Day 11: Plutonian Pebbles](https://adventofcode.com/2024/day/11) | [1.1ms](2024/11p1.odin) | [32.1ms](2024/11p2.odin) | ⭐⭐ |
| [Day 12: Garden Groups](https://adventofcode.com/2024/day/12) | [5.8ms](2024/12p1.odin) | [19.5ms](2024/12p2.odin) | ⭐⭐ |
| [Day 13: Claw Contraption](https://adventofcode.com/2024/day/13) | [129µs](2024/13p1.odin) | [132µs](2024/13p2.odin) | ⭐⭐ |
| [Day 14: Restroom Redoubt](https://adventofcode.com/2024/day/14) | [224µs](2024/14p1.odin) | [201ms](2024/14p2.odin) | ⭐⭐ |
<!-- 2024TableEnd -->

## 2023 (Go)

<!-- 2023TableStart -->
| Day | Part 1 | Part 2 | Stars |
| --- | --- | --- | --- |
| [Day 1: Trebuchet?!](https://adventofcode.com/2023/day/1) | [441µs](2023/01p1.go) | [1.458ms](2023/01p2.go) | ⭐⭐ |
| [Day 2: Cube Conundrum](https://adventofcode.com/2023/day/2) | [375µs](2023/02p1.go) | [318µs](2023/02p2.go) | ⭐⭐ |
| [Day 3: Gear Ratios](https://adventofcode.com/2023/day/3) | [415µs](2023/03p1.go) | [1.809ms](2023/03p2.go) | ⭐⭐ |
| [Day 4: Scratchcards](https://adventofcode.com/2023/day/4) | [3.057ms](2023/04p1.go) | [25.831ms](2023/04p2.go) | ⭐⭐ |
| [Day 5: If You Give a Seed A Fertilizer](https://adventofcode.com/2023/day/5) | [543µs](2023/05p1.go) | [2.069ms](2023/05p2.go) | ⭐⭐ |
| [Day 6: Wait For It](https://adventofcode.com/2023/day/6) | [17µs](2023/06p1.go) | [20µs](2023/06p2.go) | ⭐⭐ |
| [Day 7: Camel Cards](https://adventofcode.com/2023/day/7) | [1.074ms](2023/07p1.go) | [1.719ms](2023/07p2.go) | ⭐⭐ |
| [Day 8: Haunted Wasteland](https://adventofcode.com/2023/day/8) | [599µs](2023/08p1.go) | [2.498ms](2023/08p2.go) | ⭐⭐ |
| [Day 9: Mirage Maintenance](https://adventofcode.com/2023/day/9) | [703µs](2023/09p1.go) | [756µs](2023/09p2.go) | ⭐⭐ |
| [Day 10: Pipe Maze](https://adventofcode.com/2023/day/10) | [6.455ms](2023/10p1.go) | [7.645ms](2023/10p2.go) | ⭐⭐ |
| [Day 11: Cosmic Expansion](https://adventofcode.com/2023/day/11) | [11.252ms](2023/11p1.go) | [13.424ms](2023/11p2.go) | ⭐⭐ |
| [Day 12: Hot Springs](https://adventofcode.com/2023/day/12) | [2.125ms](2023/12p1.go) | [93.538ms](2023/12p2.go) | ⭐⭐ |
| [Day 13: Point of Incidence](https://adventofcode.com/2023/day/13) | [586µs](2023/13p1.go) | [62.816ms](2023/13p2.go) | ⭐⭐ |
| [Day 14: Parabolic Reflector Dish](https://adventofcode.com/2023/day/14) | [6.433ms](2023/14p1.go) | [486.307ms](2023/14p2.go) | ⭐⭐ |
| [Day 15: Lens Library](https://adventofcode.com/2023/day/15) | [150µs](2023/15p1.go) | [1.026ms](2023/15p2.go) | ⭐⭐ |
| [Day 16: The Floor Will Be Lava](https://adventofcode.com/2023/day/16) | [4.883ms](2023/16p1.go) | [874.961ms](2023/16p2.go) | ⭐⭐ |

<!-- 2023TableEnd -->

**TODO:**

-   In the process of improving the performance of Day 5 part 2, I've gone and broken it to the point where it no longer gives the correct answer. So while it is an improvement of the original 1.5 hours, it still needs some work.
-   Day 16 part 2 uses a brute force approach to find the answer. I'm certain with heavy caching and dynamic programming, it could be improved significantly.

## 2022 (Go)

<!-- 2022TableStart -->
| Day | Part 1 | Part 2 | Stars |
| --- | --- | --- | --- |
| [Day 1: Calorie Counting](https://adventofcode.com/2022/day/1) | [214µs](2022/01p1.go) | [203µs](2022/01p2.go) | ⭐⭐ |
| [Day 2: Rock Paper Scissors](https://adventofcode.com/2022/day/2) | [243µs](2022/02p1.go) | [257µs](2022/02p2.go) | ⭐⭐ |
| [Day 3: Rucksack Reorganization](https://adventofcode.com/2022/day/3) | [212µs](2022/03p1.go) | [136µs](2022/03p2.go) | ⭐⭐ |
| [Day 4: Camp Cleanup](https://adventofcode.com/2022/day/4) | [684µs](2022/04p1.go) | [681µs](2022/04p2.go) | ⭐⭐ |
| [Day 5: Supply Stacks](https://adventofcode.com/2022/day/5) | [709µs](2022/05p1.go) | [694µs](2022/05p2.go) | ⭐⭐ |
| [Day 6: Tuning Trouble](https://adventofcode.com/2022/day/6) | [294µs](2022/06p1.go) | [2.046ms](2022/06p2.go) | ⭐⭐ |
| [Day 7: No Space Left On Device](https://adventofcode.com/2022/day/7) | [219µs](2022/07p1.go) | [125µs](2022/07p2.go) | ⭐⭐ |
| [Day 8: Treetop Tree House](https://adventofcode.com/2022/day/8) | [227µs](2022/08p1.go) | [1.407ms](2022/08p2.go) | ⭐⭐ |
| [Day 9: Rope Bridge](https://adventofcode.com/2022/day/9) | [1.019ms](2022/09p1.go) | [1.673ms](2022/09p2.go) | ⭐⭐ |
| [Day 10: Cathode-Ray Tube](https://adventofcode.com/2022/day/10) | [33µs](2022/10p1.go) | [46µs](2022/10p2.go) | ⭐⭐ |
| [Day 11: Monkey in the Middle](https://adventofcode.com/2022/day/11) | [70µs](2022/11p1.go) | [15.265ms](2022/11p2.go) | ⭐⭐ |
| [Day 12: Hill Climbing Algorithm](https://adventofcode.com/2022/day/12) | [3.687ms](2022/12p1.go) | [2.947ms](2022/12p2.go) | ⭐⭐ |

<!-- 2022TableEnd -->

## 2021 (Odin)

<!-- 2021TableStart -->
| Day | Part 1 | Part 2 | Stars |
| --- | --- | --- | --- |
| [Day 1: Sonar Sweep](https://adventofcode.com/2021/day/1) | [90µs](2021/01p1.odin) | [165µs](2021/01p2.odin) | ⭐⭐ |
| [Day 2: Dive!](https://adventofcode.com/2021/day/2) | [122µs](2021/02p1.odin) | [135µs](2021/02p2.odin) | ⭐⭐ |
| [Day 3: Binary Diagnostic](https://adventofcode.com/2021/day/3) | [39µs](2021/03p1.odin) | [334µs](2021/03p2.odin) | ⭐⭐ |
| [Day 4: Giant Squid](https://adventofcode.com/2021/day/4) | [186µs](2021/04p1.odin) | [324µs](2021/04p2.odin) | ⭐⭐ |
| [Day 5: Hydrothermal Venture](https://adventofcode.com/2021/day/5) | [21.423ms](2021/05p1.odin) | [38.245ms](2021/05p2.odin) | ⭐⭐ |
| [Day 6: Lanternfish](https://adventofcode.com/2021/day/6) | [10µs](2021/06p1.odin) | [12µs](2021/06p2.odin) | ⭐⭐ |
| [Day 7: The Treachery of Whales](https://adventofcode.com/2021/day/7) | [452µs](2021/07p1.odin) | [677µs](2021/07p2.odin) | ⭐⭐ |
| [Day 8: Seven Segment Search](https://adventofcode.com/2021/day/8) | [67µs](2021/08p1.odin) | [1.191ms](2021/08p2.odin) | ⭐⭐ |
| [Day 9: Smoke Basin](https://adventofcode.com/2021/day/9) | [163µs](2021/09p1.odin) | [2.805ms](2021/09p2.odin) | ⭐⭐ |
| [Day 10: Syntax Scoring](https://adventofcode.com/2021/day/10) | [352µs](2021/10p1.odin) | [421µs](2021/10p2.odin) | ⭐⭐ |
| [Day 11: Dumbo Octopus](https://adventofcode.com/2021/day/11) | [160µs](2021/11p1.odin) | [313µs](2021/11p2.odin) | ⭐⭐ |
| [Day 12: Passage Pathfinding](https://adventofcode.com/2021/day/12) | [2.364ms](2021/12p1.odin) | [56.695ms](2021/12p2.odin) | ⭐⭐ |
| [Day 13: Transparent Oragami](https://adventofcode.com/2021/day/13) | [470µs](2021/13p1.odin) | [1.294ms](2021/13p2.odin) | ⭐⭐ |
<!-- 2021TableEnd -->
