;
; Prints a multiplication table to stdout.
;

%include 'stdlib.asm'

section .data
mul_fmt  db  ' x ', 0
 eq_fmt  db  ' = ', 0

section .text
global _start

_start:
    mov  r8, 0         ; int i = 0

.outer_loop:
    mov  r9, 0         ; int j = 0

.inner_loop:
    mov  rdi, r8
    call intprint      ; print(i)

    mov  rdi, mul_fmt
    call strprint      ; print(' x ')

    mov  rdi, r9
    call intprint      ; print(j)

    mov  rdi, eq_fmt
    call strprint      ; print(' = ')

    mov  rax, r8       ; i * j
    imul r9

    mov  rdi, rax
    call intprint      ; print(i * j)

    mov rdi, ASCII_NL  ; print('\n')
    call chprint

    inc  r9            ; ++j
    cmp  r9, 10        ; j < 10
    jl   .inner_loop

    mov rdi, ASCII_NL  ; print('\n')
    call chprint

    inc  r8            ; ++i
    cmp  r8, 10        ; i < 10
    jl   .outer_loop

    mov  rdi, 0        ; exit(0)
    call exit
