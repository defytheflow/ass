;
; Writes a message to stdout.
;

%include 'stdlib.asm'

section .data
    msg db "Assembler is very good for your mental health!", 0

section .text
    global _start

_start:
    mov rax, msg
    call str_println
    call exit
