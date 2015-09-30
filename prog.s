.global start

.text

start:      ldi r16, 0xFF
            out 0x17, r16
            ldi r16, 0x55
            out 0x18, r16
loop:       jmp loop
