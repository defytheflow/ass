default:
	nasm -f elf64 hello.asm
	ld hello.o -o hello

clean:
	$(RM) hello hello.o
