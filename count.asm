;
; Counts to a number.
;

%include 'stdlib.asm'

%define COUNT      100

section .test
    global _start

_start:
    mov r8, 0  ; initialize counter to 0.

next_num:
    inc r8

    mov rax, r8
    call int_println
    cmp r8, COUNT
    jne next_num

    call exit
