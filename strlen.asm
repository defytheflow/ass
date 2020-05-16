;
; Calculates length of a string.
;

section .data
    msg db "Everybody got a drug dealer on speed dial.", 0, 10

section .text
    global _start

_start:
    pop rcx        ; number of arguments

next_arg:
    cmp  rcx, 0    ; check if have arguments
    jz   exit

    pop  rax       ; pop the address of next argument.
    mov  rbx, rax  ; copy string address
    call strlen

    dec  rcx       ; decrease number of arguments
    jmp  next_arg

strlen:
    cmp byte[rbx], 0
    jz print
    inc rbx
    jmp strlen

print:
    sub rbx, rax    ; calculate length
    add rbx, 2      ; zero and newline

    mov rsi, rax    ; address of the string
    mov rax, 1      ; sys_write
    mov rdi, 1      ; stdout
    mov rdx, rbx    ; number of bytes
    syscall

exit:
    mov rax, 60     ; sys_exit
    mov rdi, 0      ; exit code
    syscall
