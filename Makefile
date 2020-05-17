# Makefile for compiling a simple nasm program.

%.o: %.asm
	nasm -g -f elf64 $<

%: %.o
	ld $< -o $@

clean:
	$(RM) *.o
