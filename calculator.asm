;
; Takes several command line arguments and adds them together (numbers).
;

%include 'stdlib.asm'

section .text
    global _start

_start:
    pop  rcx          ; number of arguments
    pop  rdx          ; program name
    dec  rcx          ; decrease number of arguments (program name).
    xor  edx, edx     ; initialize data register to store additions.

.next_arg:
    cmp  ecx, 0       ; check to see if we have any arguments left
    jz   .finish
    pop  rax          ; pop the next argument of the stack.
    call str_to_int
    add  edx, eax     ; perform our addition logic.
    dec  ecx          ; decrease number of arguments left.
    jmp  .next_arg

.finish:
    mov  eax, edx     ; move data result into rax for printing
    call int_println
    call exit
