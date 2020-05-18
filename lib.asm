;
; Standard Library.
;

%define STDOUT        1
%define SYS_WRITE     1
%define SYS_EXIT     60
%define EXIT_SUCCESS  0
%define NL           10

;##########################################
; Calculates length of a string.
; Input  string - rax.
; Return length - rax.
;##########################################
slen:
    push rbx
    mov  rbx, rax       ; copy address of string.

next_char:
    cmp byte[rax], 0    ; check if we have reached the end of the string.
    jz  finish
    inc rax             ; move forward one character.
    jmp next_char

finish:
    sub rax, rbx        ; save length of sthe tring in rax.
    pop rbx
    ret
;##########################################
; Prints a string to stdout.
; Input string - rax.
;##########################################
sprint:
    push rdx
    push rax            ; save string address on the stack.

    call slen           ; returns string len in rax.
    mov  rdx, rax       ; how many bytes to write.
    pop  rax            ; restore address of the string.

    mov rdi, STDOUT
    mov rsi, rax        ; address of the string.
    mov rax, SYS_WRITE
    syscall

    pop rdx
    ret
;##########################################
; Prints a string to stdout and a new line.
; Input string - rax.
;##########################################
sprintln:
    call sprint

    mov rax, SYS_WRITE
    mov rdi, STDOUT,
    mov byte[rsi], NL
    mov rdx, 1          ; how many bytes to write.
    syscall

    ret
;##########################################
; Exits the program.
;##########################################
exit:
    mov rax, SYS_EXIT
    mov rdi, EXIT_SUCCESS
    syscall
