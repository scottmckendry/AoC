package main

import "core:fmt"
import "core:slice"
import "core:strconv"
import "core:strings"

disk_file :: struct {
	is_file:     bool,
	file_id:     int,
	block_size:  int,
	block_start: int,
}

D09P2 :: proc() {
	input_string := #load("inputs/09.txt", string)
	fs_checksum := get_filesystem_checksum_p2(input_string)
	fmt.printf("Filesystem checksum: %d\n", fs_checksum)
}

get_filesystem_checksum_p2 :: proc(input: string) -> (checksum: u64) {
	fragmented := parse_disk_contents_p2(input)
	defer delete(fragmented)
	defragment_disk_p2(&fragmented)

	digit_index := 0
	for file, _ in fragmented {
		if file.is_file {
			for i := 0; i < file.block_size; i += 1 {
				checksum += auto_cast (file.file_id * digit_index)
				digit_index += 1
			}
		} else {
			digit_index += file.block_size
		}
	}
	return
}

parse_disk_contents_p2 :: proc(disk_map: string) -> (files: [dynamic]disk_file) {
	disk_map_parts := strings.split(disk_map, "", context.temp_allocator)
	file_id := 0
	block_index := 0
	for char, i in disk_map_parts {
		is_file := i % 2 == 0
		size := strconv.atoi(char)

		if is_file {
			append(&files, disk_file{is_file, file_id, size, block_index})
		} else {
			append(&files, disk_file{is_file, -1, size, block_index})
		}

		block_index += size

		if is_file {
			file_id += 1
		}
	}

	return
}

defragment_disk_p2 :: proc(fragmented: ^[dynamic]disk_file) {
	for i := 0; i < len(fragmented); i += 1 {
		space := fragmented[i]

		if !space.is_file {
			sz := space.block_size

			// reverse through the file slice to find a file that fits
			for j := len(fragmented) - 1; j >= 0; j -= 1 {
				if !fragmented[j].is_file {
					continue
				}

				if fragmented[j].block_size <= sz &&
				   space.block_start < fragmented[j].block_start {
					// move the file
					file := fragmented[j]
					old_start := file.block_start
					old_size := file.block_size

					file.block_start = space.block_start
					fragmented[j] = file

					// create new free space where the file was
					new_free := disk_file {
						is_file     = false,
						file_id     = -1,
						block_start = old_start,
						block_size  = old_size,
					}
					append(fragmented, new_free)

					// resize or remove the destination free space block
					if file.block_size == sz {
						ordered_remove(fragmented, i)
						// go back one step to avoid skipping a block
						i -= 1
					} else {
						new_space := disk_file {
							is_file     = false,
							file_id     = -1,
							block_start = space.block_start + file.block_size,
							block_size  = sz - file.block_size,
						}
						fragmented[i] = new_space
					}

					// sort after each move to maintain contiguous blocks
					slice.sort_by(fragmented[:], proc(a, b: disk_file) -> bool {
						return a.block_start < b.block_start
					})
					break
				}
			}
		}
	}

	// final sort to ensure everything is in order
	slice.sort_by(fragmented[:], proc(a, b: disk_file) -> bool {
		return a.block_start < b.block_start
	})
}
