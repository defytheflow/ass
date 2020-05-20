;
; Divides values in two registers.
;

%include 'stdlib.asm'

section .data
    msg db ' remainder ', 0

section .text
    global _start

_start:
    mov  eax, 90
    mov  ebx, 9
    div  ebx
    call int_print
    mov  eax, msg
    call str_print
    mov  eax, edx   ; move remainder into eax
    call int_println
    call exit
