MAKEFLAGS += --no-builtin-rules

.SUFFIXES:
.SECONDEXPANSION:


SRC := vect.s prog.s

OBJ := $(SRC:%.s=%.o)


PROG := prog
all: $(PROG).bin $(PROG).raw

LDFLAGS := -A atmega128 -m avr51 -T link.ld -s


$(OBJ): $$(patsubst %.o,%.s,$$@)
	avr-as -mmcu=avr51 -o $@ $<

$(PROG).bin: $(OBJ)
	avr-ld $(LDFLAGS) -o $@ $^

$(PROG).raw: $(PROG).bin
	avr-objcopy -O binary $< $@

clean:
	rm -f $(OBJ) $(PROG).ihex $(PROG).bin


.DEFAULT_GOAL := $(PROG).raw
.PHONY: all clean
