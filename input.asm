;
; Reads input from stdin.
;

%include 'stdlib.asm'

%define SIZE 255

section .data
    prompt  db  'Please enter your name: ', 0
    answer  db  'Hello, ', 0

section .bss
    input  resb  SIZE

section .text
    global _start

_start:
    mov  rdi, prompt
    call strprint

    mov  rdi, STDIN
    mov  rsi, input
    mov  rdx, SIZE
    mov  rax, SYS_READ
    syscall

    mov  rdi, answer
    call strprint

    mov  rdi, input
    call strprint

    call exit
