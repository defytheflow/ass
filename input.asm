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
    mov  eax, prompt
    call str_print

    mov  eax, SYS_READ
    mov  edi, STDIN
    mov  esi, sinput
    mov  edx, 255
    syscall

    mov  eax, answer
    call str_print

    mov  eax, sinput
    call str_print

    call exit
