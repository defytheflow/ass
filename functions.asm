; int strlen(string msg)
; Calculates length of a string.
strlen:
    push rbx
    mov  rbx, rax

nextchar:
    cmp  byte[rax], 0
    jz   finished
    inc  rax
    jmp  nextchar

finished:
    sub rax, rbx
    pop rbx
    ret

; void strprint(string msg)
; Prints a string to stdout.
strprint:
    push rdx
    push rax

    call strlen
    mov  rdx, rax ; how many bytes to write
    pop  rax

    mov rdi, 1    ; stdout
    mov rsi, rax  ; use string address in rax
    mov rax, 1    ; sys_write call number
    syscall

    pop rdx
    ret

; void strprintln(string msg)
; Prints a string to stdout and a new line.
strprintln:
    call strprint

    push 0Ax
    mov rax, 1   ; sys_write call number
    mov rdi, 1   ; stdout
    mov rsi, rsp ; use char on stack
    mov rdx, 1   ; write 1 char
    syscall
    add rsp, 8   ; restore sp

    ret

; void exit()
; Exits program with error code 0.
exit:
    mov rbx, 0
    mov rax, 1
    syscall
    ret
