;
; Swaps values between two memory locations.
;

%include 'stdlib.asm'

section .data
    a     dq  24
    b     dq  42
    s1    db  'Before: ', 0
    s2    db  'After: ', 0

section .text
    global _start

_start:

.print_before:
    mov   rax, s1
    call  str_print

    mov   rax, [a]
    call  int_print

    mov   rax, ' '
    call  char_print

    mov   rax, [b]
    call  int_println

.swap:
    mov rax, [a]
    mov rbx, [b]
    mov [a], rbx
    mov [b], rax

.print_after:
    mov   rax, s2
    call  str_print

    mov   rax, [a]
    call  int_print

    mov   rax, ' '
    call  char_print

    mov   rax, [b]
    call  int_println

    call  exit
