MAKEFLAGS += --no-builtin-rules

.SUFFIXES:
.SECONDEXPANSION:


SSRC := vect.s prog.s
CSRC :=

SOBJ := $(SSRC:%.s=%.o)
COBJ := $(CSRC:%.c=%.o)


PROG := prog
all: $(PROG).elf $(PROG).raw

GCCFLAGS := -mmcu=atmega128
CFLAGS := -std=c99 -Wall -Wextra -Werror -Wno-unused-function
LDFLAGS := -A atmega128 -m avr51 -T link.ld -s


$(SOBJ): $$(patsubst %.o,%.s,$$@)
	avr-gcc $(GCCFLAGS) -x assembler-with-cpp -c -o $@ $<

$(COBJ): $$(patsubst %.o,%.c,$$@)
	avr-gcc $(GCCFLAGS) $(CFLAGS) -c -o $@ $<

$(PROG).elf: $(SOBJ) $(COBJ)
	avr-ld $(LDFLAGS) -o $@ $^

$(PROG).raw: $(PROG).elf
	avr-objcopy -O binary $< $@

clean:
	rm -f $(SOBJ) $(COBJ) $(PROG).elf $(PROG).raw


.DEFAULT_GOAL := $(PROG).raw
.PHONY: all clean
