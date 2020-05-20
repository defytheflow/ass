;
; Prints 'Hello world' to stdout.
;

%include 'stdlib.asm'

section .data
    msg db 'Hello, World', 0

section .text
    global _start

_start:
    mov  rdi, msg
    call strprintln
    mov  rdi, 0
    call exit
