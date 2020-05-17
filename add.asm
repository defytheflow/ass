;
; Addition example.
;

section .data
    a dq 175
    b dq 40230

section .text
    global _start

_start:
    mov rax, [a]   ; mov value in a to rax
    add rax, [b]   ; add value in b to rax

exit:
    mov rax, 60
    mov rdi, 0
    syscall
