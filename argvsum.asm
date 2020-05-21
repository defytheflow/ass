;
;  Prints the sum of it's command line arguments.
;

%include 'stdlib.asm'

section .text
global _start

_start:
    pop  rcx          ; int argc = ?
    pop  rdx          ; argv[0]
    dec  rcx          ; --argc
    mov  rdx, 0       ; int sum = 0;

.loop:
    cmp  rcx, 0       ; argc == 0
    jz   .finish
    pop  rdi          ; argv[?]

    push rcx
    call stoi         ; stoi(argv[?])
    pop  rcx

    add  rdx, rax     ; sum += stoi(argv[?])
    dec  rcx          ; --argc
    jmp  .loop

.finish:
    mov  rdi, rdx
    call intprintln   ; print(sum)
    call exit
