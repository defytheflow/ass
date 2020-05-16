;
; Writes 'Hello world' to stdout.
;
; Assemble: nasm -f elf64 helloworld.asm
;

; Here you put yout constant data.
section .data
    msg db "Hello, World", 10, 0

; Here you put your code.
section .text
    global _start

_start:
    mov rax, 1    ; system call for write
    mov rdi, 1    ; stdout
    mov rsi, msg  ; address of string to output
    mov rdx, 13   ; number of bytes
    syscall
    mov rax, 60   ; system code for exit
    mov rdi, 0    ; exit code 0
    syscall
