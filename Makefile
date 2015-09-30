MAKEFLAGS += --no-builtin-rules

.SUFFIXES:
.SECONDEXPANSION:


SRC := vect.s prog.s

OBJ := $(SRC:%.s=%.o)


PROG = prog.ihex


$(OBJ): $$(patsubst %.o,%.s,$$@)
	avr-as -mmcu=atmega128 -o $@ $<

$(PROG): $(OBJ)
	avr-ld -mavr51 -T link.ld -o $@ $^

clean:
	rm -f $(OBJ) $(PROG)


.DEFAULT_GOAL := $(PROG)
.PHONY: all clean
