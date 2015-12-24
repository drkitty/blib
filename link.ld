MEMORY {
    flash : ORIGIN = 0x0, LENGTH = 128K
    intsram : ORIGIN = 0x800100, LENGTH = 4K
}

SECTIONS {
    .text : { *(.text) } >flash
    .data : { *(.data) } >intsram
	/DISCARD/ : { *(*) }
}
