#include "avr/io.h"


.text


.org 0x00 * 2
init:       ldi r16, lo8(RAMEND)
            out SPL-0x20, r16
            ldi r16, hi8(RAMEND)
            out SPH-0x20, r16
            clr r1 ; gcc's AVR ABI says r1 should be zero

            ldi r24, 0xFF ; all output / loop index / flip all bits
            out DDRB - 0x20, r24 ; DDRB
            ldi r16, 0x55 ; 0n01010101

flip:       eor r16, r24
            out PORTB - 0x20, r16 ; PORTB
            ldi r17, 0x10
delay:      sbiw r24, 1
            brne delay
            ldi r24, 0xFF
            ldi r25, 0xFF
            dec r17
            brne delay
            rjmp flip
