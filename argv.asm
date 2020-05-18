;
; Prints its command-line arguments.
;

%include 'lib.asm'

section .text
    global _start

_start:
    pop  r8           ; pop number of arguments of the stack.

next_arg:
    cmp  r8, 0        ; check to see if we have any arguments left.
    jz   no_more_args
    pop  rax          ; pop the next argument of the stack.
    call sprintln
    dec  r8           ; decrease number of arguments left by 1.
    jmp  next_arg

no_more_args:
    call exit
