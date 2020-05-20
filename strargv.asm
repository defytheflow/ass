;
; Prints it's command-line arguments to stdout.
;

%include 'stdlib.asm'

section .text
    global _start

_start:
    pop  rcx          ; pop number of arguments of the stack.
    pop  rdx          ; pop program's name.
    dec  rcx          ; decrease number of arguments left

.loop:
    cmp  rcx, 0       ; do we have any arguments left?
    jz   .finish
    pop  rdi          ; pop the next argument of the stack.

    push rcx
    call strprintln
    pop  rcx

    dec  rcx          ; decrease number of arguments left by 1.
    jmp  .loop

.finish:
    mov  rdi, 0       ; exit success.
    call exit
