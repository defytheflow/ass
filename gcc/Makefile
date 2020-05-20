# Makefile for compiling an assembly file with nasm and gcc.

%.o: %.asm
	nasm -g -f elf64  $<

%: %.o
	gcc -no-pie -o bin/$@ $<

clean:
	$(RM) *.o
