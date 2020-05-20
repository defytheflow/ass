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
    mov  ecx, 0                  ; int i = 0;
    mov  ebx, 0                  ; int j = 0:

.fill_array_loop:
    cmp  ecx, SIZE               ; i < SIZE;
    je   .print_array_loop
    mov  [array + ecx * 4], ecx  ; array[i] = i;
    inc  ecx                     ; ++i;
    jmp  .fill_array_loop

.print_array_loop:
    cmp  ebx, SIZE               ; j < SIZE;
    je   .finish
    mov  eax, [array + ebx * 4]  ; rax = array[j];
    call int_println             ; print(rax);
    inc  ebx                     ; ++j;
    jmp .print_array_loop

.finish:
    call exit                    ; return 0;
