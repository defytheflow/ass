;
; Prints the following pattern to stdout, depending on HEIGHT.
;
; #
; ##
; ###
; ####
; #####
;

%include 'stdlib.asm'

%define HEIGHT 5
%define BLOCK '#'

section .text
    global _start

_start:
    mov  r8, 1          ; int row  = 1

.next_row:
    mov  r9, 1          ; int star = 1

.next_star:
    mov  rdi, BLOCK
    call chprint        ; putchar('#')
    inc  r9             ; ++star
    cmp  r9, r8         ; star <= row
    jle  .next_star

    inc  r8             ; ++row
    mov  rdi, ASCII_NL
    call chprint        ; putchar('\n')
    cmp  r8, HEIGHT     ; row <= HEIGHT
    jle  .next_row

.finish:
    mov  rdi, 0         ; exit(0)
    call exit
