;
; Prints 'Hello World' to stdout using printf.
;

section .data
    fmt  db  '%s', 0
    msg  db  'Hello World!', 10, 0

section .text
    global main
    extern printf

main:
    push  rbp
    mov   rbp, rsp

    mov   rdi, fmt
    mov   rsi, msg
    call  printf

    xor   rax, rax   ; return 0.
    pop   rbp
    ret
