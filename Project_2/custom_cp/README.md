# custom_cp - File Copy Utility

A simplified implementation of the Unix cp command written in C from scratch.

## Features
- Copy a single file to a destination file
- Copy a single file into a directory
- Copy multiple files into a directory
- Preserves original file permissions
- Handles errors gracefully

## Build
Run: make

## Usage
./custom_cp source destination
./custom_cp source1 source2 directory

## Examples
./custom_cp file1.txt file2.txt
./custom_cp file1.txt mydir/
./custom_cp a.txt b.txt c.txt mydir/
