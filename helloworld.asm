;
; Writes 'Hello world' to stdout.
;

section .data
    msg db "Hello, World", 10, 0

section .text
    global _start

_start:
    mov rax, 1    ; sys_write
    mov rdi, 1    ; stdout
    mov rsi, msg  ; string address
    mov rdx, 13   ; number of bytes
    syscall

exit:
    mov rax, 60   ; sys_exit
    mov rdi, 0    ; exit code
    syscall
