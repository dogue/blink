MEMORY {
    SRAM(rx)    : ORIGIN = 0x20000000, LENGTH = 256K
}

SECTIONS {
    . = ORIGIN(SRAM);
    .text : {
        *(.vectors)
        *(.entry)
        *(.text)
    } > SRAM
}
