#include <stdio.h>
#include <ctype.h>

void count_file(char *filename, int *total_lines, int *total_words, int *total_chars) {
    FILE *fp = fopen(filename, "r");

    if (fp == NULL) {
        printf("Error opening file: %s\n", filename);
        return;
    }

    int lines = 0, words = 0, chars = 0;
    int in_word = 0;
    char ch;

    while ((ch = fgetc(fp)) != EOF) {
        chars++;

        if (ch == '\n')
            lines++;

        if (isspace(ch)) {
            in_word = 0;
        } else if (!in_word) {
            in_word = 1;
            words++;
        }
    }

    fclose(fp);

    printf("File: %s\n", filename);
    printf("Lines: %d\n", lines);
    printf("Words: %d\n", words);
    printf("Characters: %d\n\n", chars);

    *total_lines += lines;
    *total_words += words;
    *total_chars += chars;
}

int main(int argc, char *argv[]) {

    if (argc < 2) {
        printf("Usage: %s file1 [file2 ...]\n", argv[0]);
        return 1;
    }

    int total_lines = 0, total_words = 0, total_chars = 0;

    for (int i = 1; i < argc; i++) {
        count_file(argv[i], &total_lines, &total_words, &total_chars);
    }

    // ✅ THIS IS THE KEY FIX
    if (argc >= 3) {   // means 2 or more files
        printf("TOTAL\n");
        printf("Lines: %d\n", total_lines);
        printf("Words: %d\n", total_words);
        printf("Characters: %d\n", total_chars);
    }

    return 0;
}
