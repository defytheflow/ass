;
; Standard Library.
;

; #################################
; int slen (string msg)
;
; Calculates length of a string.
;
; #################################
slen:
    push rbx
    mov rbx, [rsp + 8]  ; address of msg

nextchar:
    cmp byte[rbx], 0    ; check if rbx points to 0.
    jz finish
    inc rbx
    jmp nextchar

finish:
    sub rax, rbx
    pop rbx
    ret

; #################################
; void exit (int status)
;
; Exits the program.
;
; #################################
exit:
    mov rax, 60          ; sys_exit
    mov rdi, [rsp + 8]   ; exit code
    syscall
