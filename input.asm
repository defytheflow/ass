;
; Gets input from stdin.
;

%include 'stdlib.asm'

section .data
    prompt db 'Please enter your name: ', 0
    answer db 'Hello, ', 0

section .bss
    sinput resb 255   ; reserve a 255 byte space in memory for user input.

section .text
    global _start

_start:
    mov rax, prompt
    call str_print

    mov rax, SYS_READ
    mov rdi, STDIN
    mov rsi, sinput
    mov rdx, 255
    syscall

    mov rax, answer
    call str_print

    mov rax, sinput
    call str_print

    call exit
