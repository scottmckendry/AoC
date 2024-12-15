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
| [Day 1: Historian Hysteria](https://adventofcode.com/2024/day/1) | [235µs](2024/01p1.odin) | [293µs](2024/01p2.odin) | ⭐⭐ |
| [Day 2: Red-Nosed Reports](https://adventofcode.com/2024/day/2) | [522µs](2024/02p1.odin) | [1.3ms](2024/02p2.odin) | ⭐⭐ |
| [Day 3: Mull It Over](https://adventofcode.com/2024/day/3) | [66µs](2024/03p1.odin) | [71µs](2024/03p2.odin) | ⭐⭐ |
| [Day 4: Ceres Search](https://adventofcode.com/2024/day/4) | [470µs](2024/04p1.odin) | [138µs](2024/04p2.odin) | ⭐⭐ |
| [Day 5: Print Queue](https://adventofcode.com/2024/day/5) | [867µs](2024/05p1.odin) | [1.4ms](2024/05p2.odin) | ⭐⭐ |
| [Day 6: Guard Gallivant](https://adventofcode.com/2024/day/6) | [3.6ms](2024/06p1.odin) | [640.4ms](2024/06p2.odin) | ⭐⭐ |
| [Day 7: Bridge Repair](https://adventofcode.com/2024/day/7) | [1.6ms](2024/07p1.odin) | [27.8ms](2024/07p2.odin) | ⭐⭐ |
| [Day 8: Resonant Collinearity](https://adventofcode.com/2024/day/8) | [173µs](2024/08p1.odin) | [401µs](2024/08p2.odin) | ⭐⭐ |
| [Day 9: Disk Fragmenter](https://adventofcode.com/2024/day/9) | [1.5ms](2024/09p1.odin) | [437.1ms](2024/09p2.odin) | ⭐⭐ |
| [Day 10: Hoof It](https://adventofcode.com/2024/day/10) | [494µs](2024/10p1.odin) | [484µs](2024/10p2.odin) | ⭐⭐ |
| [Day 11: Plutonian Pebbles](https://adventofcode.com/2024/day/11) | [1.1ms](2024/11p1.odin) | [31.7ms](2024/11p2.odin) | ⭐⭐ |
| [Day 12: Garden Groups](https://adventofcode.com/2024/day/12) | [6ms](2024/12p1.odin) | [21.8ms](2024/12p2.odin) | ⭐⭐ |
| [Day 13: Claw Contraption](https://adventofcode.com/2024/day/13) | [127µs](2024/13p1.odin) | [127µs](2024/13p2.odin) | ⭐⭐ |
| [Day 14: Restroom Redoubt](https://adventofcode.com/2024/day/14) | [403µs](2024/14p1.odin) | [198.2ms](2024/14p2.odin) | ⭐⭐ |
<!-- 2024TableEnd -->

## 2023 (Go)

<!-- 2023TableStart -->
| Day | Part 1 | Part 2 | Stars |
| --- | --- | --- | --- |
| [Day 1: Trebuchet?!](https://adventofcode.com/2023/day/1) | [512µs](2023/01p1.go) | [1.512ms](2023/01p2.go) | ⭐⭐ |
| [Day 2: Cube Conundrum](https://adventofcode.com/2023/day/2) | [376µs](2023/02p1.go) | [303µs](2023/02p2.go) | ⭐⭐ |
| [Day 3: Gear Ratios](https://adventofcode.com/2023/day/3) | [437µs](2023/03p1.go) | [1.792ms](2023/03p2.go) | ⭐⭐ |
| [Day 4: Scratchcards](https://adventofcode.com/2023/day/4) | [3.001ms](2023/04p1.go) | [26.103ms](2023/04p2.go) | ⭐⭐ |
| [Day 5: If You Give a Seed A Fertilizer](https://adventofcode.com/2023/day/5) | [454µs](2023/05p1.go) | [2.016ms](2023/05p2.go) | ⭐⭐ |
| [Day 6: Wait For It](https://adventofcode.com/2023/day/6) | [17µs](2023/06p1.go) | [17µs](2023/06p2.go) | ⭐⭐ |
| [Day 7: Camel Cards](https://adventofcode.com/2023/day/7) | [916µs](2023/07p1.go) | [981µs](2023/07p2.go) | ⭐⭐ |
| [Day 8: Haunted Wasteland](https://adventofcode.com/2023/day/8) | [544µs](2023/08p1.go) | [2.503ms](2023/08p2.go) | ⭐⭐ |
| [Day 9: Mirage Maintenance](https://adventofcode.com/2023/day/9) | [687µs](2023/09p1.go) | [925µs](2023/09p2.go) | ⭐⭐ |
| [Day 10: Pipe Maze](https://adventofcode.com/2023/day/10) | [6.711ms](2023/10p1.go) | [7.343ms](2023/10p2.go) | ⭐⭐ |
| [Day 11: Cosmic Expansion](https://adventofcode.com/2023/day/11) | [10.717ms](2023/11p1.go) | [10.512ms](2023/11p2.go) | ⭐⭐ |
| [Day 12: Hot Springs](https://adventofcode.com/2023/day/12) | [2.235ms](2023/12p1.go) | [91.725ms](2023/12p2.go) | ⭐⭐ |
| [Day 13: Point of Incidence](https://adventofcode.com/2023/day/13) | [523µs](2023/13p1.go) | [61.337ms](2023/13p2.go) | ⭐⭐ |
| [Day 14: Parabolic Reflector Dish](https://adventofcode.com/2023/day/14) | [6.486ms](2023/14p1.go) | [486.373ms](2023/14p2.go) | ⭐⭐ |
| [Day 15: Lens Library](https://adventofcode.com/2023/day/15) | [145µs](2023/15p1.go) | [931µs](2023/15p2.go) | ⭐⭐ |
| [Day 16: The Floor Will Be Lava](https://adventofcode.com/2023/day/16) | [4.48ms](2023/16p1.go) | [863.811ms](2023/16p2.go) | ⭐⭐ |

<!-- 2023TableEnd -->

**TODO:**

-   In the process of improving the performance of Day 5 part 2, I've gone and broken it to the point where it no longer gives the correct answer. So while it is an improvement of the original 1.5 hours, it still needs some work.
-   Day 16 part 2 uses a brute force approach to find the answer. I'm certain with heavy caching and dynamic programming, it could be improved significantly.

## 2022 (Go)

<!-- 2022TableStart -->
| Day | Part 1 | Part 2 | Stars |
| --- | --- | --- | --- |
| [Day 1: Calorie Counting](https://adventofcode.com/2022/day/1) | [182µs](2022/01p1.go) | [192µs](2022/01p2.go) | ⭐⭐ |
| [Day 2: Rock Paper Scissors](https://adventofcode.com/2022/day/2) | [255µs](2022/02p1.go) | [280µs](2022/02p2.go) | ⭐⭐ |
| [Day 3: Rucksack Reorganization](https://adventofcode.com/2022/day/3) | [302µs](2022/03p1.go) | [230µs](2022/03p2.go) | ⭐⭐ |
| [Day 4: Camp Cleanup](https://adventofcode.com/2022/day/4) | [716µs](2022/04p1.go) | [616µs](2022/04p2.go) | ⭐⭐ |
| [Day 5: Supply Stacks](https://adventofcode.com/2022/day/5) | [671µs](2022/05p1.go) | [729µs](2022/05p2.go) | ⭐⭐ |
| [Day 6: Tuning Trouble](https://adventofcode.com/2022/day/6) | [344µs](2022/06p1.go) | [2.078ms](2022/06p2.go) | ⭐⭐ |
| [Day 7: No Space Left On Device](https://adventofcode.com/2022/day/7) | [222µs](2022/07p1.go) | [183µs](2022/07p2.go) | ⭐⭐ |
| [Day 8: Treetop Tree House](https://adventofcode.com/2022/day/8) | [261µs](2022/08p1.go) | [1.241ms](2022/08p2.go) | ⭐⭐ |
| [Day 9: Rope Bridge](https://adventofcode.com/2022/day/9) | [961µs](2022/09p1.go) | [1.634ms](2022/09p2.go) | ⭐⭐ |
| [Day 10: Cathode-Ray Tube](https://adventofcode.com/2022/day/10) | [49µs](2022/10p1.go) | [56µs](2022/10p2.go) | ⭐⭐ |
| [Day 11: Monkey in the Middle](https://adventofcode.com/2022/day/11) | [69µs](2022/11p1.go) | [13.422ms](2022/11p2.go) | ⭐⭐ |
| [Day 12: Hill Climbing Algorithm](https://adventofcode.com/2022/day/12) | [3.62ms](2022/12p1.go) | [3.279ms](2022/12p2.go) | ⭐⭐ |

<!-- 2022TableEnd -->

## 2021 (Odin)

<!-- 2021TableStart -->
| Day | Part 1 | Part 2 | Stars |
| --- | --- | --- | --- |
| [Day 1: Sonar Sweep](https://adventofcode.com/2021/day/1) | [90µs](2021/01p1.odin) | [199µs](2021/01p2.odin) | ⭐⭐ |
| [Day 2: Dive!](https://adventofcode.com/2021/day/2) | [136µs](2021/02p1.odin) | [136µs](2021/02p2.odin) | ⭐⭐ |
| [Day 3: Binary Diagnostic](https://adventofcode.com/2021/day/3) | [43µs](2021/03p1.odin) | [274µs](2021/03p2.odin) | ⭐⭐ |
| [Day 4: Giant Squid](https://adventofcode.com/2021/day/4) | [152µs](2021/04p1.odin) | [276µs](2021/04p2.odin) | ⭐⭐ |
| [Day 5: Hydrothermal Venture](https://adventofcode.com/2021/day/5) | [21.431ms](2021/05p1.odin) | [36.873ms](2021/05p2.odin) | ⭐⭐ |
| [Day 6: Lanternfish](https://adventofcode.com/2021/day/6) | [10µs](2021/06p1.odin) | [13µs](2021/06p2.odin) | ⭐⭐ |
| [Day 7: The Treachery of Whales](https://adventofcode.com/2021/day/7) | [317µs](2021/07p1.odin) | [635µs](2021/07p2.odin) | ⭐⭐ |
| [Day 8: Seven Segment Search](https://adventofcode.com/2021/day/8) | [48µs](2021/08p1.odin) | [1.246ms](2021/08p2.odin) | ⭐⭐ |
| [Day 9: Smoke Basin](https://adventofcode.com/2021/day/9) | [162µs](2021/09p1.odin) | [2.807ms](2021/09p2.odin) | ⭐⭐ |
| [Day 10: Syntax Scoring](https://adventofcode.com/2021/day/10) | [325µs](2021/10p1.odin) | [449µs](2021/10p2.odin) | ⭐⭐ |
| [Day 11: Dumbo Octopus](https://adventofcode.com/2021/day/11) | [103µs](2021/11p1.odin) | [245µs](2021/11p2.odin) | ⭐⭐ |
| [Day 12: Passage Pathfinding](https://adventofcode.com/2021/day/12) | [2.276ms](2021/12p1.odin) | [56.047ms](2021/12p2.odin) | ⭐⭐ |
| [Day 13: Transparent Oragami](https://adventofcode.com/2021/day/13) | [448µs](2021/13p1.odin) | [1.412ms](2021/13p2.odin) | ⭐⭐ |
<!-- 2021TableEnd -->
