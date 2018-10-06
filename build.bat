@echo off
make
arm-eabi-ld -T flash.ld -o program.elf *.o
arm-eabi-objcopy -O binary program.elf program.bin
openocd -s scripts/ -f board/st_nucleo_f0.cfg -c "program program.bin reset exit 0x8000000"
