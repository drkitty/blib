#include <avr/io.h>

.text

.org 0x0
		rjmp init

init:	ldi r16, lo8(RAMEND)
		out SPL-0x20, r16
		ldi r16, hi8(RAMEND)
		out SPH-0x20, r16
		clr r1
		rjmp _start
