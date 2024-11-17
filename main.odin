package blink

import i "base:intrinsics"

IOBANK0_RESET :: cast(^u32)(uintptr(0x4000f000))
IOBANK0_RESET_DONE :: cast(^u32)(uintptr(0x4000c008))
GPIO25 :: cast(^u32)(uintptr(0x400140cc))
GPIO_OE :: cast(^u32)(uintptr(0xd0000020))
XOR_GPIO :: cast(^u32)(uintptr(0xd000001c))

write :: i.volatile_store
read :: i.volatile_load

@(export, link_name = "_main")
_main :: proc "contextless" () {
    write(IOBANK0_RESET, 1 << 5)

    for read(IOBANK0_RESET_DONE) & (1 << 5) == 0 {
        // wait for reset
    }

    write(GPIO25, 0x05)
    write(GPIO_OE, 1 << 25)

    for {
        write(XOR_GPIO, 1 << 25)
        for a := 0; a < 50000; {
            write(&a, a + 1)
        }
    }
}
