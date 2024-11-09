package main

import "core:fmt"
import "utils"
import "core:slice"

D09P2 :: proc() {
	lines, backing := utils.read_lines("./inputs/09.txt")
	defer delete(lines)
	defer delete(backing)

	product_of_basin_sizes := get_product_of_basin_sizes(lines)
	fmt.printfln("Product of basin sizes is: %v", product_of_basin_sizes)
}

get_product_of_basin_sizes :: proc(input: []string) -> int {
    heightmap := parse_heightmap(input)
    low_points := get_low_points(heightmap, len(input), len(input[0]))
    basin_sizes := get_basin_sizes(low_points, heightmap, len(input), len(input[0]))
    defer delete(heightmap)
    defer delete(low_points)
    defer delete(basin_sizes)

    // sort basin sizes and get product of top 3
    slice.sort(basin_sizes[:])
    return basin_sizes[len(basin_sizes) - 1] * basin_sizes[len(basin_sizes) - 2] * basin_sizes[len(basin_sizes) - 3]
}

get_basin_sizes :: proc(
    low_points: [dynamic]int,
    heightmap: [dynamic]int,
    dimension_x: int,
    dimension_y: int,
) -> (
    basin_sizes: [dynamic]int,
) {
    for start in low_points {
        visited := map[int]bool{ start = true }
        stack := [dynamic]int{ start }
        defer delete(visited)
        defer delete(stack)

        basin_size := 1
        for len(stack) > 0 {
            current := pop(&stack)
            i := current / dimension_y
            j := current % dimension_y

            north := (i - 1) * dimension_y + j
            east := i * dimension_y + (j + 1)
            south := (i + 1) * dimension_y + j
            west := i * dimension_y + (j - 1)

            if current < 0 || current >= len(heightmap) {
                continue
            }

            if i > 0 && heightmap[north] > heightmap[current] && !visited[north] {
                visited[north] = true
                if heightmap[north] != 9 {
                    append(&stack, north)
                    basin_size += 1
                }
            }
            if j < dimension_y - 1 && heightmap[east] > heightmap[current] && ! visited[east] {
                visited[east] = true
                if heightmap[east] != 9 {
                    append(&stack, east)
                    basin_size += 1
                }
            }
            if i < dimension_x - 1 && heightmap[south] > heightmap[current] && ! visited[south] {
                visited[south] = true
                if heightmap[south] != 9 {
                    append(&stack, south)
                    basin_size += 1
                }
            }
            if j > 0 && heightmap[west] > heightmap[current] && !visited[west] {
                visited[west] = true
                if heightmap[west] != 9 {
                    append(&stack, west)
                    basin_size += 1
                }
            }
        }

        append(&basin_sizes, basin_size)
    }
    return
}
