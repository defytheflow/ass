;
; Prints it's command line arguments one character per line.
;

%include 'stdlib.asm'

section .text
    global _start

_start:
    pop  rcx             ; number of arguments.
    pop  rdx             ; program name.
    dec  rcx             ; decrease number of arguments left.

.arg_loop:
    cmp  rcx, 0          ; do we have any arguments left?
    jz   .finish
    pop  rbx             ; pop the next argument.
    dec  rcx             ; decrease number of arguments left.

.char_loop:
    cmp  byte[rbx], 0    ; have we reached the end of the arg?
    je   .arg_loop
    mov  dil, byte[rbx]  ; move char pointed by rbx into lower half of rdi.

    push rcx
    call chprint
    mov  rdi, ASCII_NL
    call chprint
    pop  rcx

    inc  rbx
    jmp  .char_loop

.finish:
    mov  rdi, 0
    call exit
