;
; Prints the sum of all elements in the defined array to stdout.
;

%include 'stdlib.asm'

section .data
array:
    dd   1
    dd  10
    dd -12
    dd  42
    dd  54
    dd -23
    dd   0                          ; <- array end.

section .text
global _start

_start:
    mov  rcx, 0                     ; int i = 0
    mov  rax, 0                     ; int sum = 0

.sum_loop:
    add  eax, [array + rcx * 4]     ; sum += array[i]
    inc  rcx                        ; ++i
    cmp  dword[array + rcx * 4], 0  ; array[i] != 0
    jne  .sum_loop

    mov  rdi, rax
    call intprintln                 ; print(sum)

    mov  rdi, 0
    call exit
