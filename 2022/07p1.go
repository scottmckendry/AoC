package main

import (
	"fmt"

	"aoc2022/utils"
)

type file struct {
	name string
	size int64
}

type directory struct {
	name           string
	parent         *directory
	totalSize      int64
	files          []file
	subdirectories map[string]*directory
}

func D07P1() {
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

	directoriesLessThan100kSum := getDirectoriesLessThan100k(&root)

	fmt.Printf("Total size of root directory: %d\n", root.totalSize)
	fmt.Printf("Total size of all directories less than 100k: %d\n", directoriesLessThan100kSum)
}

func getDirectoriesLessThan100k(directory *directory) int64 {
	var total int64

	if directory.totalSize < 100000 {
		total += directory.totalSize
	}

	for _, subdirectory := range directory.subdirectories {
		total += getDirectoriesLessThan100k(subdirectory)
	}

	return total
}
