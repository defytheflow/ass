;
; Writes 'Hello world' to stdout.
;

section .data
    msg db "Hello, World", 10, 0

section .text
    global _start

_start:
    mov eax, 1    ; sys_write
    mov edi, 1    ; stdout
    mov esi, msg  ; string address
    mov edx, 13   ; number of bytes
    syscall

exit:
    mov eax, 60   ; sys_exit
    mov edi, 0    ; exit code
    syscall
