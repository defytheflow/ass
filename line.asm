;
; Writes a line of '*' to stdout.
;
; Assemble: nasm -f elf64 line.asm
;

section .data
    star db '*'
    nl   db 10

section .text
    global _start

_start:
    mov r8, 0   ; r1 is our counter

loop:
    cmp r8, 10   ; we want to repeat it 5 times
    je  exit

print:
    mov rax, 1
    mov rdi, 1
    mov rsi, star
    mov rdx, 1
    syscall

    inc r8
    jmp loop

exit:
    mov rax, 1
    mov rdi, 1
    mov rsi, nl
    mov rdx, 1
    syscall

    mov rax, 60 ; sys_exit
    mov rdi, 0  ; exit code
    syscall
