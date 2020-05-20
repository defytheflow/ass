;
; Prints a number on each line up to COUNT.
;

%include 'stdlib.asm'

%define COUNT 100

section .text
    global _start

_start:
    mov  rcx, 0

.loop:
    inc  rcx

    mov  rdi, rcx
    push rcx
    call intprintln
    pop  rcx

    cmp  rcx, COUNT
    jne  .loop

    mov  rdi, 0
    call exit
