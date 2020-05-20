%include 'stdlib.asm'

section .data
    a  dq  42
    b  dq  24

section .text
    global _start

_start:
    mov rax, a
    mov rbx, [a]
    call exit
