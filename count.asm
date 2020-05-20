;
; Counts to a number.
;

%include 'stdlib.asm'

%define COUNT 100

section .text
    global _start

_start:
    mov  ecx, 0

.next_num:
    inc  ecx

    mov  eax, ecx
    call int_println
    cmp  ecx, COUNT
    jne  .next_num

    call exit
