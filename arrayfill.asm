;
; Fills array with consecutive numbers and prints them.
;

%include 'stdlib.asm'

%define SIZE  10

section .bss
array  resd  SIZE

section .text
global _start

_start:
    mov  rcx, 0                  ; int i = 0
.fill_loop:
    mov  [array + rcx * 4], ecx  ; array[i] = 0
    inc  rcx                     ; ++i
    cmp  rcx, SIZE               ; i < SIZE
    jl   .fill_loop

    mov  rcx, 0                  ; i = 0
.print_loop:
    push rcx
    mov  edi, [array + rcx * 4]
    call intprintln              ; print(array[i])
    pop rcx

    inc  rcx                     ; ++i
    cmp  rcx, SIZE               ; j < SIZE;
    jl   .print_loop

.finish:
    mov  rdi, 0
    call exit
