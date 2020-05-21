;
; Defines an array of numbers and prints it.
;

%include 'stdlib.asm'

section .data
numbers:
    dd  10
    dd  42
    dd  34
    dd  56
    dd  12
    dd   0

section .text
global _start

_start:
    mov  rcx, 0

.loop:
    push rcx
    mov  edi, [numbers + rcx * 4]
    call intprintln
    pop  rcx

    inc  rcx
    cmp  dword[numbers + rcx * 4], 0
    jne  .loop

    mov  rdi, 0
    call exit
