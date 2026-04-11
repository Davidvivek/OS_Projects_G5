#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"
#include "kernel/fs.h"
#include "kernel/fcntl.h"


#define COLOR_DIR   "\033[38;5;51m"   // Neon Cyan
#define COLOR_DEV   "\033[38;5;226m"  // Bright Yellow
#define COLOR_EXEC  "\033[38;5;198m"  // Hot Pink
#define COLOR_RESET "\033[0m"         // Default text / reset


int total_dirs = 0;
int total_files = 0;
int total_bytes = 0;

// Command line option flags
int flag_l = 0;
int flag_s = 0;

int has_extension(const char *name) {
    int len = strlen(name);
    for (int i = len - 1; i > 0; i--) {
        if (name[i] == '.') {
            return 1;
        }
        if (name[i] == '/') {
            break; // Hit a path separator, stop searching for extension
        }
    }
    return 0; 
}


char* fmtname(char *path) {
    char *p;
    
    // Find the first character after last slash.
    for(p=path+strlen(path); p >= path && *p != '/'; p--)
        ;
    p++;
    
    return p;
}

void print_file(char *path, struct stat *st, char *name) {
    char *color = COLOR_RESET;
    
    // Determine color based on requirements
    if (st->type == T_DIR) {
        color = COLOR_DIR;
    } else if (st->type == T_DEVICE) {
        color = COLOR_DEV;
    } else if (st->type == T_FILE) {
        if (!has_extension(name)) {
            color = COLOR_EXEC; // Files with no extension are green executables
        }
    }
    
    if (flag_l) {
        printf("%s%s%s", color, name, COLOR_RESET);
        
        int len = strlen(name);
        for(int i = len; i < DIRSIZ; i++) {
            printf(" ");
        }
        
        char *type_str = (st->type == T_DIR)    ? "DIR " : 
                         (st->type == T_DEVICE) ? "DEV " : "FILE";
                         
        printf(" %s ", type_str);
        printf("%d %d\n", st->ino, (int)st->size);
    } else {
        printf("%s%s%s  ", color, name, COLOR_RESET);
    }
}

void custom_ls(char *path) {
    char buf[512], *p;
    int fd;
    struct dirent de;
    struct stat st;

    if((fd = open(path, O_RDONLY)) < 0) {
        fprintf(2, "custom_ls: cannot open %s\n", path);
        return;
    }

    // Attempt to stat the file/directory metadata
    if(fstat(fd, &st) < 0) {
        fprintf(2, "custom_ls: cannot stat %s\n", path);
        close(fd);
        return;
    }

    // Switch case to handle different entity types
    switch(st.type) {
    case T_DEVICE:
    case T_FILE:
        // Update summary metrics for the given single file argument
        if (st.type == T_FILE) {
            total_files++;
            total_bytes += st.size;
        } else {
            total_files++; // Treating device endpoints as files for the summary count
        }
        
        print_file(path, &st, fmtname(path));
        
        if (!flag_l) {
            printf("\n");
        }
        break;

    case T_DIR:
        // Check structural bounds before concatenating paths
        if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf) {
            printf("custom_ls: path too long\n");
            break;
        }
        
        // Set up the path extraction buffer
        strcpy(buf, path);
        p = buf+strlen(buf);
        *p++ = '/';
        
        // Iterate directory entries (Pass 2 tracking dynamically)
        while(read(fd, &de, sizeof(de)) == sizeof(de)) {
            // Unallocated inode block 0
            if(de.inum == 0) continue;
            
            memmove(p, de.name, DIRSIZ);
            p[DIRSIZ] = 0;
            
            // Stat the underlying directory entry
            if(stat(buf, &st) < 0) {
                printf("custom_ls: cannot stat %s\n", buf);
                continue;
            }
            
            // Increment the summary according to file types!
            if (st.type == T_FILE || st.type == T_DEVICE) {
                total_files++;
                if (st.type == T_FILE) total_bytes += st.size;
            } else if (st.type == T_DIR) {
                total_dirs++;
            }
            
            // Delegate responsibility to format and output with ANSI colors
            print_file(buf, &st, fmtname(buf));
        }
        
        if (!flag_l) {
            printf("\n");
        }
        break;
    }
    
    close(fd);
}

// Main Entry Point
int main(int argc, char *argv[]) {
    int paths_start = 1;
    
    // Iteratively parse execution flags (-l, -s) seamlessly!
    for(int i = 1; i < argc; i++) {
        if(argv[i][0] == '-') {
            for(int j = 1; argv[i][j] != '\0'; j++) {
                if(argv[i][j] == 'l') flag_l = 1;
                else if(argv[i][j] == 's') flag_s = 1;
                else {
                    fprintf(2, "custom_ls: unknown flag -%c\n", argv[i][j]);
                    exit(1);
                }
            }
            paths_start++;
        } else {
            // Terminate option parsing as soon as a non-flag text is seen.
            break;
        }
    }

    if(paths_start == argc) {
        custom_ls("."); 
    } else {
        for(int i = paths_start; i < argc; i++) {
            custom_ls(argv[i]);
            if (!flag_l && i < argc - 1) {
                printf("\n");
            }
        }
    }

    if (flag_s) {
        printf("\n\033[38;5;201m"); // Vivid Magenta
        printf("========================================\n");
        printf("           SUMMARY          \n");
        printf("========================================\n");
        printf("\033[0m"); 
        
        printf("  Total Directories : %d\n", total_dirs);
        printf("  Total Files       : %d\n", total_files);
        printf("  Total Bytes       : %d\n", total_bytes);
        
        printf("\033[38;5;201m"); // Vivid Magenta
        printf("========================================\n");
        printf("\033[0m"); 
    }

    exit(0);
}
