;
;  Prints a sum of it's command line arguments.
;

%include 'stdlib.asm'

section .text
    global _start

_start:
    pop  rcx          ; number of arguments
    pop  rdx          ; program name
    dec  rcx          ; decrease number of arguments (program name).
    xor  rdx, rdx     ; initialize data register to store additions.

.loop:
    cmp  rcx, 0       ; check to see if we have any arguments left
    jz   .finish
    pop  rdi          ; pop the next argument of the stack.
    push rcx
    call stoi
    pop  rcx
    add  rdx, rax     ; perform our addition logic.
    dec  rcx          ; decrease number of arguments left.
    jmp  .loop

.finish:
    mov  rdi, rdx
    call intprintln
    call exit
