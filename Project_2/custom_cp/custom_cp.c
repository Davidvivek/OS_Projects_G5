#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/stat.h>
#include <string.h>
#include <errno.h>

#define BUFFER_SIZE 4096

int copy_file(const char *src, const char *dst) {
    int src_fd, dst_fd;
    ssize_t bytes_read, bytes_written;
    char buffer[BUFFER_SIZE];
    struct stat src_stat;

    // Open source file
    src_fd = open(src, O_RDONLY);
    if (src_fd < 0) {
        fprintf(stderr, "custom_cp: cannot open '%s': %s\n", src, strerror(errno));
        return 1;
    }

    // Get source file permissions
    if (fstat(src_fd, &src_stat) < 0) {
        fprintf(stderr, "custom_cp: cannot stat '%s': %s\n", src, strerror(errno));
        close(src_fd);
        return 1;
    }

    // Check if source is a directory
    if (S_ISDIR(src_stat.st_mode)) {
        fprintf(stderr, "custom_cp: '%s' is a directory (not copied)\n", src);
        close(src_fd);
        return 1;
    }

    // Open destination file
    dst_fd = open(dst, O_WRONLY | O_CREAT | O_TRUNC, src_stat.st_mode);
    if (dst_fd < 0) {
        fprintf(stderr, "custom_cp: cannot create '%s': %s\n", dst, strerror(errno));
        close(src_fd);
        return 1;
    }

    // Copy contents
    while ((bytes_read = read(src_fd, buffer, BUFFER_SIZE)) > 0) {
        bytes_written = write(dst_fd, buffer, bytes_read);
        if (bytes_written != bytes_read) {
            fprintf(stderr, "custom_cp: write error to '%s': %s\n", dst, strerror(errno));
            close(src_fd);
            close(dst_fd);
            return 1;
        }
    }

    if (bytes_read < 0) {
        fprintf(stderr, "custom_cp: read error from '%s': %s\n", src, strerror(errno));
        close(src_fd);
        close(dst_fd);
        return 1;
    }

    printf("custom_cp: '%s' -> '%s' copied successfully\n", src, dst);
    close(src_fd);
    close(dst_fd);
    return 0;
}

int main(int argc, char *argv[]) {
    if (argc < 3) {
        fprintf(stderr, "Usage: custom_cp <source> <destination>\n");
        fprintf(stderr, "       custom_cp <source1> <source2> ... <directory>\n");
        exit(1);
    }

    // Check if last argument is a directory
    struct stat dst_stat;
    int dst_is_dir = 0;
    if (stat(argv[argc-1], &dst_stat) == 0 && S_ISDIR(dst_stat.st_mode)) {
        dst_is_dir = 1;
    }

    // Multiple sources must go into a directory
    if (argc > 3 && !dst_is_dir) {
        fprintf(stderr, "custom_cp: target '%s' is not a directory\n", argv[argc-1]);
        exit(1);
    }

    int ret = 0;
    for (int i = 1; i < argc - 1; i++) {
        char dst_path[1024];
        if (dst_is_dir) {
            // Get just the filename from source
            char *filename = strrchr(argv[i], '/');
            filename = filename ? filename + 1 : argv[i];
            snprintf(dst_path, sizeof(dst_path), "%s/%s", argv[argc-1], filename);
        } else {
            snprintf(dst_path, sizeof(dst_path), "%s", argv[argc-1]);
        }
        ret |= copy_file(argv[i], dst_path);
    }

    return ret;
}
