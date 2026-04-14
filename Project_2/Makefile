# ============================================================================
#  Makefile — Project 2: Custom UNIX Utilities
#  Operating Systems Lab (NSCS210/CSC211) | Group G5
# ============================================================================

CC       = gcc
CFLAGS   = -Wall -Wextra -std=c11

# ---------- directory layout ------------------------------------------------
CMD_DIR  = custom_commands
SHELL_DIR = Shell
BIN_DIR  = bin

# ---------- source files ----------------------------------------------------
CMD_SRCS = $(CMD_DIR)/custom_cat.c  \
           $(CMD_DIR)/custom_cp.c   \
           $(CMD_DIR)/custom_grep.c \
           $(CMD_DIR)/custom_ls.c   \
           $(CMD_DIR)/custom_mv.c   \
           $(CMD_DIR)/custom_rm.c   \
           $(CMD_DIR)/custom_wc.c

SHELL_SRC = $(SHELL_DIR)/shell.c

# ---------- binary targets --------------------------------------------------
CMD_BINS = $(BIN_DIR)/custom_cat  \
           $(BIN_DIR)/custom_cp   \
           $(BIN_DIR)/custom_grep \
           $(BIN_DIR)/custom_ls   \
           $(BIN_DIR)/custom_mv   \
           $(BIN_DIR)/custom_rm   \
           $(BIN_DIR)/custom_wc

SHELL_BIN = $(BIN_DIR)/g5_shell

ALL_BINS  = $(CMD_BINS) $(SHELL_BIN)

# ============================================================================
#  TARGETS
# ============================================================================

.PHONY: all clean help

## Build everything (all utilities + shell)
all: $(BIN_DIR) $(ALL_BINS)
	@echo ""
	@echo "✅  Build complete! All binaries are in ./$(BIN_DIR)/"
	@echo "    Run the shell:  ./$(BIN_DIR)/g5_shell"
	@echo ""

## Create the output directory
$(BIN_DIR):
	mkdir -p $(BIN_DIR)

# ---------- custom commands -------------------------------------------------

$(BIN_DIR)/custom_cat: $(CMD_DIR)/custom_cat.c | $(BIN_DIR)
	$(CC) $(CFLAGS) -o $@ $<

$(BIN_DIR)/custom_cp: $(CMD_DIR)/custom_cp.c | $(BIN_DIR)
	$(CC) $(CFLAGS) -o $@ $<

$(BIN_DIR)/custom_grep: $(CMD_DIR)/custom_grep.c | $(BIN_DIR)
	$(CC) $(CFLAGS) -o $@ $<

$(BIN_DIR)/custom_ls: $(CMD_DIR)/custom_ls.c | $(BIN_DIR)
	$(CC) $(CFLAGS) -o $@ $<

$(BIN_DIR)/custom_mv: $(CMD_DIR)/custom_mv.c | $(BIN_DIR)
	$(CC) $(CFLAGS) -o $@ $<

$(BIN_DIR)/custom_rm: $(CMD_DIR)/custom_rm.c | $(BIN_DIR)
	$(CC) $(CFLAGS) -o $@ $<

$(BIN_DIR)/custom_wc: $(CMD_DIR)/custom_wc.c | $(BIN_DIR)
	$(CC) $(CFLAGS) -o $@ $<

# ---------- custom shell ----------------------------------------------------

$(BIN_DIR)/g5_shell: $(SHELL_DIR)/shell.c | $(BIN_DIR)
	$(CC) $(CFLAGS) -o $@ $<

# ---------- utilities -------------------------------------------------------

## Remove all compiled binaries
clean:
	rm -rf $(BIN_DIR)
	@echo "🧹  Cleaned — $(BIN_DIR)/ removed."

## Show available targets
help:
	@echo ""
	@echo "  make          — Build all utilities and the shell"
	@echo "  make clean    — Remove all compiled binaries"
	@echo "  make help     — Show this help message"
	@echo ""
	@echo "  Individual targets:"
	@echo "    make $(BIN_DIR)/custom_cat"
	@echo "    make $(BIN_DIR)/custom_cp"
	@echo "    make $(BIN_DIR)/custom_grep"
	@echo "    make $(BIN_DIR)/custom_ls"
	@echo "    make $(BIN_DIR)/custom_mv"
	@echo "    make $(BIN_DIR)/custom_rm"
	@echo "    make $(BIN_DIR)/custom_wc"
	@echo "    make $(BIN_DIR)/g5_shell"
	@echo ""
