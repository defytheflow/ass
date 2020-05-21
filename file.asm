;
; Creates a file using sys_creat call.
;

%include 'stdlib.asm'

section .data
    filename  db  'output.txt', 0
    message   db  'Hello World!', 0

section .text
    global _start

_start:
    ; Create a file.
    mov  rdi, filename
    mov  rsi, 0777
    mov  rax, SYS_CREAT
    syscall

    ; Write to file
    mov  rdi, rax        ; descriptor.
    mov  rsi, message
    mov  rdx, 12         ; length.
    mov  rax, SYS_WRITE
    syscall

    ; Open file.
    mov  rdi, filename
    mov  rdx, O_RDONLY    ; mode.
    mov  rax, SYS_OPEN
    syscall

    ; Print returned file descriptor.
    mov  rdi, rax
    call intprintln

    mov  rdi, 0
    call exit
