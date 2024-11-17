toolchain := "arm-none-eabi"
elf2uf2 := "~/Projects/Embedded/Pico/blink/elf2uf2/elf2uf2"

default: all

all:
    just clean
    just assemble
    just build

assemble:
    {{ toolchain }}-as --warn --fatal-warnings -mcpu=cortex-m0plus -mthumb -g init.s -o init.o

build:
    odin build . -build-mode:obj -target:freestanding_arm32 -microarch:cortex-m0plus -out:main.o -o:size
    {{ toolchain }}-ld -nostdlib --entry 0x20000000 -T link.ld main.o init.o /usr/lib/gcc/arm-none-eabi/14.1.0/libgcc.a -o firmware.elf
    {{ toolchain }}-objdump -D firmware.elf > firmware.list
    {{ toolchain }}-objcopy -O binary firmware.elf firmware.bin
    {{ elf2uf2 }} firmware.elf firmware.uf2

clean:
    rm -f *.o *.elf *.bin *.uf2 *.list
