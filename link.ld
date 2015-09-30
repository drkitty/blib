OUTPUT_FORMAT(ihex)

MEMORY {
    vectflash : ORIGIN = 0x0, LENGTH = 0x46
    progflash : ORIGIN = 0x46, LENGTH = 128K - 0x46
    intsram : ORIGIN = 0x800100, LENGTH = 4K
}

SECTIONS {
    .vect : { vect.o(.text) } >vectflash
    .text : { *(.text) } >progflash
    .data : { *(.data) } >intsram
}
