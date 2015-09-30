.global start

.text

start:		ldi r16, 0xFF ; all output / loop index / flip all bits
			out 0x17, r16 ; DDRB
			ldi r17, 0x55 ; 0n01010101

flip:		eor r17, r16
			out 0x18, r17 ; PORTB
loop2:		dec r16
			brne loop2
			ldi r16, 0xFF ; loop index
			jmp flip
