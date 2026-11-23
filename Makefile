AS = nasm
CC = gcc

ASFLAGS = -f elf32 -I src/
CFLAGS = -m32 -fno-pie
LDFLAGS = -m32 -no-pie

SOURCE_DIR = src
OUTPUT_DIR = build

PROGRAMS = task1 task1_2 task2_welcome task2_array task2_range
EXECUTABLES = $(addprefix $(OUTPUT_DIR)/,$(PROGRAMS))

COMMON_OBJECTS = $(OUTPUT_DIR)/driver.o $(OUTPUT_DIR)/asm_io.o

.PHONY: all clean

all: $(EXECUTABLES)

$(OUTPUT_DIR):
	mkdir -p $(OUTPUT_DIR)

$(OUTPUT_DIR)/driver.o: $(SOURCE_DIR)/driver.c | $(OUTPUT_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

$(OUTPUT_DIR)/%.o: $(SOURCE_DIR)/%.asm $(SOURCE_DIR)/asm_io.inc | $(OUTPUT_DIR)
	$(AS) $(ASFLAGS) $< -o $@

$(EXECUTABLES): $(OUTPUT_DIR)/%: $(OUTPUT_DIR)/%.o $(COMMON_OBJECTS)
	$(CC) $(LDFLAGS) $^ -o $@

clean:
	rm -rf $(OUTPUT_DIR)