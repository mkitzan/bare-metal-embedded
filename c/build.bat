@echo off
make
arm-none-eabi-ld -T stm32f0x.ld -o program.elf *.o
arm-none-eabi-objcopy -O binary program.elf program.bin
openocd -s scripts/ -f board/st_nucleo_f0.cfg -c "program program.bin reset exit 0x8000000"
