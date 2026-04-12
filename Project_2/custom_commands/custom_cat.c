#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>

#define BUFFER_SIZE 4096

int main(int argc, char *argv[]) {
    // Check if the user provided a filename
    if (argc < 2) {
        printf("Usage: %s <filename>\n", argv[0]);
        return 1;
    }

    // Open the file in read-only mode
    int fd = open(argv[1], O_RDONLY);
    if (fd == -1) {
        perror("Error opening file");
        return 1;
    }

    char buffer[BUFFER_SIZE];
    ssize_t bytesRead;

    // Read from file and write to standard output (stdout = 1)
    while ((bytesRead = read(fd, buffer, BUFFER_SIZE)) > 0) {
        if (write(1, buffer, bytesRead) != bytesRead) {
            perror("Error writing to stdout");
            close(fd);
            return 1;
        }
    }

    if (bytesRead == -1) {
        perror("Error reading file");
    }

    close(fd);
    return 0;
}
