# Makefile for compiling a simple nasm program.

%.o: %.asm lib/stdlib.asm
	nasm -g -f elf64 -I lib/ $<

%: %.o
	ld $< -o bin/$@

clean:
	$(RM) *.o bin/*
