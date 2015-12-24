MAKEFLAGS += --no-builtin-rules

.SUFFIXES:
.SECONDEXPANSION:


SSRC := prog.s
CSRC :=

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


prog.elf: prog.o


.DEFAULT_GOAL := all
.PHONY: all clean
