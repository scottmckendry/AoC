package main

import (
	"fmt"

	"aoc2022/utils"
)

func D07P2() {
	root := directory{
		name:           "/",
		parent:         nil,
		totalSize:      0,
		subdirectories: make(map[string]*directory),
	}
	currentDirectory := &root
	printingContents := false
	lines := utils.ReadLines("./inputs/07.txt")

	for _, line := range lines {
		if line[:4] == "$ cd" {
			printingContents = false
			cdTo := line[5:]

			switch cdTo {
			case "/":
				currentDirectory = &root
			case "..":
				currentDirectory = currentDirectory.parent
			default:
				currentDirectory = currentDirectory.subdirectories[cdTo]
			}
		}

		if line[:4] == "$ ls" {
			printingContents = true
			continue
		}

		if printingContents {
			if line[0] == 'd' {
				directoryName := line[4:]
				newDirectory := directory{
					name:           directoryName,
					parent:         currentDirectory,
					totalSize:      0,
					subdirectories: make(map[string]*directory),
				}
				currentDirectory.subdirectories[directoryName] = &newDirectory
			} else {
				var currentFile file
				for i := 0; i < len(line); i++ {
					if line[i] == ' ' {
						currentFile.name = line[i+1:]
						currentDirectory.totalSize += currentFile.size

						temp := currentDirectory
						for currentDirectory.parent != nil {
							currentDirectory = currentDirectory.parent
							currentDirectory.totalSize += currentFile.size
						}

						currentDirectory = temp
						break
					} else {
						currentFile.size = currentFile.size*10 + int64(line[i]-'0')
					}
				}
				currentDirectory.files = append(currentDirectory.files, currentFile)
			}
		}
	}

	diskSize := 70000000
	spaceRequired := 30000000
	spaceFree := diskSize - int(root.totalSize)
	spaceToFree := spaceRequired - spaceFree

	closestDirectory := findRightSizeDirectory(root, spaceToFree, root)

	fmt.Printf("Directory to delete: %v\n", closestDirectory.name)
	fmt.Printf("Size of directory: %v\n", closestDirectory.totalSize)
}

func findRightSizeDirectory(dir directory, size int, closestDirectory directory) directory {
	for _, subdirectory := range dir.subdirectories {
		if subdirectory.totalSize > int64(size) {
			if subdirectory.totalSize < closestDirectory.totalSize {
				closestDirectory = *subdirectory
			}
			closestDirectory = findRightSizeDirectory(*subdirectory, size, closestDirectory)
		}
	}
	return closestDirectory
}
