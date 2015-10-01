MAKEFLAGS += --no-builtin-rules

.SUFFIXES:
.SECONDEXPANSION:


SRC := vect.s prog.s

OBJ := $(SRC:%.s=%.o)


PROG := prog
all: $(PROG).elf $(PROG).raw

LDFLAGS := -A atmega128 -m avr51 -T link.ld -s


$(OBJ): $$(patsubst %.o,%.s,$$@)
	avr-gcc -mmcu=atmega128 -x assembler-with-cpp -c -o $@ $<

$(PROG).elf: $(OBJ)
	avr-ld $(LDFLAGS) -o $@ $^

$(PROG).raw: $(PROG).elf
	avr-objcopy -O binary $< $@

clean:
	rm -f $(OBJ) $(PROG).elf $(PROG).raw


.DEFAULT_GOAL := $(PROG).raw
.PHONY: all clean
