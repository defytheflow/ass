;
; Writes a msg to stdout, but calculates its length programatically.
;

section .data
    msg db "Everybody got a drug dealer on speed dial.", 10, 0

section .text
    global _start

_start:
    mov rax, msg        ; copy address of msg
    mov rbx, msg        ; another copy

next_char:
    cmp byte[rbx], 0    ; check if rbx points to 0.
    jz print            ; if it does, go to print
    inc rbx
    jmp next_char

print:
    sub rbx, rax        ; calculate length of the string

    mov rax, 1          ; sys_write
    mov rdi, 1          ; stdout
    mov rsi, msg        ; string address
    mov rdx, rbx        ; length
    syscall

exit:
    mov rax, 60         ; sys_exit
    mov rdi, 0          ; exit code
    syscall
