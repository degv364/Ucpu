CC ?= mips-linux-gnu-gcc-6

luca.s: luca.c
	$(CC) luca.c -feliminate-unused-debug-types -nodefaultlibs -O0 -nostdlib --std=gnu99 -march=mips1 -nostartfiles --no-pie -mno-abicalls -mno-shared -mgp32 -mfp32 -msoft-float -mcode-readable=yes -mno-explicit-relocs -mno-embedded-data -S
	sed -i -e 's/^\s*\..*//' luca.s
	awk 'NF > 0' luca.s > temp.s
	sed -i -e 's/(/,/' temp.s
	sed -i -e 's/)//' temp.s
	sed -i -e 's/#nop/nop\n\tnop\n\tnop/' temp.s
	sed -i -e 's/0xff9c/65436/' temp.s
	python3 replace_that.py
	cat setup.s temp.s > luca.s
	echo "\n\tnop\n\tnop\n\tnop" >> luca.s
Module_ROM.v: luca.s
	maasm luca.s Module_ROM.v --asm-dict ../../tree.py --macros ../../macros.py

copy: Module_ROM.v
	cp Module_ROM.v ../cpu
testing:
	gcc luca.c -DTESTING -o luca
preprocess:
	sed -i -e 's/^\s*\..*//' luca.s
	sed -i -e 's/\taddiu\t$sp,$sp,-2//' luca.s
	awk 'NF > 0' luca.s > temp.s
	sed -i -e 's/(/,/' temp.s
	sed -i -e 's/)//' temp.s
	sed -i -e 's/#nop/nop\n\tnop\n\tnop/' temp.s
	python3 replace_that.py
	cat setup.s temp.s > luca.s
	echo "\n\tnop\n\tnop\n\tnop" >> luca.s
clean:
	rm -f luca luca.s
