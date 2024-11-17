.cpu cortex-m0plus
.thumb

    // vector table
    .section .vectors, "ax"
    .align 2
    .global _vectors

_vectors:
    .word 0x20001000
    .word _reset


// reset handler
.thumb_func
.global _reset
_reset:
    // initialize stack pointer
    ldr r0, =0x20001000
    mov sp, r0

    // reset IO_BANK0
    ldr r3, =0x4000f000
    movs r2, #32
    str r2, [r3, #0]

    // set GPIO25 to SIO control
    ldr r3, =0x400140cc
    movs r2, #5
    str r2, [r3, #0]

    // set SIO output enable for GPIO25
    ldr r3, =0xd0000020
    movs r2, #128
    lsl r2, r2, #18
    str r2, [r3, #0]

    b _main
    b .

.align 4
