package main

import "core:fmt"
import "core:strconv"
import "core:testing"

@(test)
d09p1 :: proc(t: ^testing.T) {
	disk_map := "2333133121414131402"
	want: u64 = 1928
	got := get_filesystem_checksum(disk_map)
	testing.expect(t, got == want, fmt.aprintf("Got: %v | Want: %v", got, want))

	free_all()
}

@(test)
d09p2 :: proc(t: ^testing.T) {
	disk_map := "2333133121414131402"
	want: u64 = 2858
	got := get_filesystem_checksum_p2(disk_map)
	testing.expect(t, got == want, fmt.aprintf("Got: %v | Want: %v", got, want))

	free_all()
}

@(test)
test_parse_disk_contents :: proc(t: ^testing.T) {
	disk_map := "2333133121414131402"
	want_rendered := "00...111...2...333.44.5555.6666.777.888899"
	got := parse_disk_contents(disk_map)

	got_rendered_slice: [dynamic]u8
	for block in got {
		if !block.is_file {
			append(&got_rendered_slice, '.')
		} else {
			buf := [1]byte{}
			id_str := strconv.itoa(buf[:], block.file_id)
			append(&got_rendered_slice, id_str[0])
		}
	}

	got_rendered := transmute(string)got_rendered_slice[:]

	testing.expect(
		t,
		want_rendered == got_rendered,
		fmt.aprintf("Got: %s | Want: %s", got_rendered, want_rendered),
	)

	free_all()
}

@(test)
test_parse_disk_contents_p2 :: proc(t: ^testing.T) {
	disk_map := "2333133121414131402"
	want_rendered := "00...111...2...333.44.5555.6666.777.888899"
	got := parse_disk_contents_p2(disk_map)

	got_rendered_slice: [dynamic]u8
	for file in got {
		if !file.is_file {
			for _ in 0 ..< file.block_size {
				append(&got_rendered_slice, '.')
			}
		} else {
			for _ in 0 ..< file.block_size {
				buf := [1]byte{}
				id_str := strconv.itoa(buf[:], file.file_id)
				append(&got_rendered_slice, id_str[0])
			}
		}
	}

	got_rendered := transmute(string)got_rendered_slice[:]

	testing.expect(
		t,
		want_rendered == got_rendered,
		fmt.aprintf("Got: %s | Want: %s", got_rendered, want_rendered),
	)

	free_all()
}

@(test)
test_defragment_disk :: proc(t: ^testing.T) {
	disk_map := "2333133121414131402"
	want_rendered := "0099811188827773336446555566"
	fragmented := parse_disk_contents(disk_map)
	defragment_disk(&fragmented)

	got_rendered_slice: [dynamic]u8
	for block in fragmented {
		if !block.is_file {
			append(&got_rendered_slice, '.')
		} else {
			buf := [1]byte{}
			id_str := strconv.itoa(buf[:], block.file_id)
			append(&got_rendered_slice, id_str[0])
		}
	}

	got_rendered := transmute(string)got_rendered_slice[:]

	testing.expect(
		t,
		want_rendered == got_rendered,
		fmt.aprintf("Got: %s | Want: %s", got_rendered, want_rendered),
	)

	free_all()
}

@(test)
test_defragment_disk_p2 :: proc(t: ^testing.T) {
	disk_map := "2333133121414131402"
	want_rendered := "00992111777.44.333....5555.6666.....8888.."

	fragmented := parse_disk_contents_p2(disk_map)
	defragment_disk_p2(&fragmented)

	got_rendered_slice: [dynamic]u8
	for file in fragmented {
		if !file.is_file {
			for _ in 0 ..< file.block_size {
				append(&got_rendered_slice, '.')
			}
		} else {
			for _ in 0 ..< file.block_size {
				buf := [1]byte{}
				id_str := strconv.itoa(buf[:], file.file_id)
				append(&got_rendered_slice, id_str[0])
			}
		}
	}

	got_rendered := transmute(string)got_rendered_slice[:]
	testing.expect(
		t,
		want_rendered == got_rendered,
		fmt.aprintf("Got: %s | Want: %s", got_rendered, want_rendered),
	)

	free_all()
}
