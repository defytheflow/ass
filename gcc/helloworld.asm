;
; Prints 'Hello World' to stdout using puts.
;

section .data
    msg  db  'Hello World!', 0

section .text
    global main
    extern puts

main:
    push  rbp
    mov   rbp, rsp

    mov   rdi, msg    ; parameter for puts.
    call  puts

    xor   rax, rax    ; return 0.
    pop   rbp
    ret
