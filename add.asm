;
; Adds values in two registers.
;

%include 'stdlib.asm'

section .text
    global _start

_start:
    mov  eax, 90
    mov  ebx, 9
    add  eax, ebx
    call int_println
    call exit
