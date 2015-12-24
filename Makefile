# Build process:
#   - Compile/assemble each source file into an object file.
#   - Link all object files into a single ELF binary.
#   - Convert the ELF binary to a raw binary.
#
# Once the raw binary is built, program the target device by running the
# flash.sh script.
#
# Unless you know what you're doing, you should only modify the marked sections
# of this makefile. All dependencies are automatically generated except those
# between ELF binaries and object files.


MAKEFLAGS += --no-builtin-rules

.SUFFIXES:
.SECONDEXPANSION:


#### Add source files here. ####
SSRC := prog.s
CSRC :=
#### ^^^^^^^^^^^^^^^^^^^^^^ ####

SOBJ := $(SSRC:%.s=%.o)
COBJ := $(CSRC:%.c=%.o)


PROG := prog
ELF := $(PROG:%=%.elf)
RAW := $(PROG:%=%.raw)

all: $(ELF) $(RAW)

GCCFLAGS := -mmcu=atmega128
CFLAGS := -std=c99 -Wall -Wextra -Werror -Wno-unused-function
LDFLAGS := -A atmega128 -m avr51 -T link.ld -s


$(SOBJ): $$(patsubst %.o,%.s,$$@)
	avr-gcc $(GCCFLAGS) -x assembler-with-cpp -c -o $@ $<

$(COBJ): $$(patsubst %.o,%.c,$$@)
	avr-gcc $(GCCFLAGS) $(CFLAGS) -c -o $@ $<

$(ELF):
	avr-ld $(LDFLAGS) -o $@ $^

prog.raw: $$(patsubst %.raw,%.elf,$$@)
	avr-objcopy -O binary $< $@

clean:
	rm -f $(SOBJ) $(COBJ) $(ELF) $(RAW)


#### Add additional dependencies here. ####
prog.elf: prog.o
#### ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ ####


.DEFAULT_GOAL := all
.PHONY: all clean
