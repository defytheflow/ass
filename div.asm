;
; Divides values in two registers.
;

%include 'stdlib.asm'

section .data
    msg db ' remainder ', 0

section .text
    global _start

_start:
    mov  rax, 90
    mov  rbx, 9
    div  rbx
    call int_print
    mov  rax, msg
    call str_print
    mov rax, rdx   ; move remainder into rax
    call int_println
    call exit
