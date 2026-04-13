#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>

// Define O_BINARY so Windows compiles happily alongside UNIX
#ifndef O_BINARY
#define O_BINARY 0
#endif

// Process files in 4KB chunks for efficiency
#define BUFFER_SIZE   4096

int main(int argc, char *argv[]) {
    int source_fd, dest_fd;
    ssize_t bytes_read, bytes_written;
    char buffer[BUFFER_SIZE];

    // Ensure we got exactly: program_name source dest
    if (argc != 3) {
        fprintf(stderr, "Usage: %s <source_file> <destination_file>\n", argv[0]);
        return 1;
    }

    // Grab read-only access to the original file
    source_fd = open(argv[1], O_RDONLY | O_BINARY);
    if (source_fd < 0) {
        perror("custom_cp: Oops, error opening the source file");
        return 1;
    }

    // Open destination: write-only, create if missing, or overwrite if exists
    dest_fd = open(argv[2], O_WRONLY | O_CREAT | O_TRUNC | O_BINARY, 0644);
    if (dest_fd < 0) {
        perror("custom_cp: Couldn't open the destination file");
        close(source_fd);
        return 1;
    }

    // Keep grabbing chunks of data until there's nothing left
    while ((bytes_read = read(source_fd, buffer, BUFFER_SIZE)) > 0) {
        
        // Shove the chunk we just read right into the destination
        bytes_written = write(dest_fd, buffer, bytes_read);
        
        // Bail out if something prevented the full chunk from writing
        if (bytes_written != bytes_read) {
            perror("custom_cp: Encountered an error while writing out the copy");
            close(source_fd);
            close(dest_fd);
            return 1;
        }
    }

    // Double check we didn't stop early because of a weird read error
    if (bytes_read < 0) {
        perror("custom_cp: Something went wrong reading the source file");
    }

    // Clean up and give the file descriptors back!
    close(source_fd);
    close(dest_fd);

    return 0;
}
