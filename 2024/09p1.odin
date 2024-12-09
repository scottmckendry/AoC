package main

import "core:fmt"
import "core:slice"
import "core:strconv"
import "core:strings"

disk_block :: struct {
	is_file: bool,
	file_id: int,
}

D09P1 :: proc() {
	input_string := #load("inputs/09.txt", string)
	fs_checksum := get_filesystem_checksum(input_string)
	fmt.printf("Filesystem checksum: %d\n", fs_checksum)
}

get_filesystem_checksum :: proc(input: string) -> (checksum: u64) {
	fragmented := parse_disk_contents(input)
	defer delete(fragmented)
	defragment_disk(&fragmented)

	for block, i in fragmented {
		if block.is_file {
			checksum += auto_cast (block.file_id * i)
		}
	}
	return
}

parse_disk_contents :: proc(disk_map: string) -> (blocks: [dynamic]disk_block) {
	disk_map_parts := strings.split(disk_map, "", context.temp_allocator)
	file_id := 0
	for char, i in disk_map_parts {
		is_file := i % 2 == 0
		size := strconv.atoi(char)
		for _ in 0 ..< size {
			if is_file {
				append(&blocks, disk_block{is_file, file_id})
			} else {
				append(&blocks, disk_block{is_file, -1})
			}
		}

		if is_file {
			file_id += 1
		}
	}

	return
}

defragment_disk :: proc(fragmented: ^[dynamic]disk_block) {
	file_blocks: [dynamic]int
	defer delete(file_blocks)
	file_count := 0

	for block in fragmented {
		if block.is_file {
			append(&file_blocks, block.file_id)
			file_count += 1
		}
	}

	slice.reverse(file_blocks[:])
	next_file_idx := 0

	i := 0
	for i < len(fragmented) {
		if !fragmented[i].is_file && next_file_idx < len(file_blocks) {
			fragmented[i] = disk_block{true, file_blocks[next_file_idx]}
			next_file_idx += 1
		}
		i += 1
	}

	resize(fragmented, file_count)
}
