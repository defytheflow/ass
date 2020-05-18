;
; Multiplies values in two registers.
;

%include 'stdlib.asm'

section .text
    global _start

_start:
    mov  rax, 90
    mov  rbx, 9
    mul  rbx
    call int_println
    call exit
