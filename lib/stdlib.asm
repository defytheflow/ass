;
; Standard Library.
;
; Author: Artyom Danilov
;
; Synopsis:
;
;   Function parameters are passed in RDI, RSI, RDX, RCX, R8, R9.
;   RAX is used for integer return values.
;

; #############################################################################
; Constants.
; #############################################################################

; file descriptors.
%define STDIN         0
%define STDOUT        1

; syscall opcodes.
%define SYS_READ      0
%define SYS_WRITE     1
%define SYS_OPEN      2
%define SYS_EXIT     60
%define SYS_CREAT    85

; ascii values.
%define ASCII_NL     10

; file access modes.
%define O_RDONLY      0
%define O_WRONLY      1
%define O_RDWR        2

; exit codes.
%define EXIT_SUCCESS  0

; #############################################################################
; Description:
;   Prints a character to stdout.
;
; Arguments:
;   rdi - characater value.
; #############################################################################

chprint:
    push rdi

    mov rdi, STDOUT
    mov rsi, rsp
    mov rdx, 1
    mov rax, SYS_WRITE
    syscall

    pop rdi
    ret

; #############################################################################
; Description:
;   Calculates length of a string.
;
; Arguments:
;   rdi - string address.
;
; Return:
;   rax - string length.
; #############################################################################

strlen:
    mov  rax, rdi

.loop:
    cmp  byte[rax], 0  ; have we reached the end of the string?
    jz   .finish
    inc  rax           ; move forward one character.
    jmp  .loop

.finish:
    sub  rax, rdi      ; calculate length of the string.
    ret

; #############################################################################
; Description:
;   Prints a string to stdout.
;
; Arguments:
;   rdi - string address.
; #############################################################################

strprint:
    call strlen
    mov  rdx, rax      ; string length.
    mov  rsi, rdi      ; string address.
    mov  rdi, STDOUT
    mov  rax, SYS_WRITE
    syscall
    ret

; #############################################################################
; Description:
;   Prints a string and a new line to stdout.
;
; Arguments:
;   rdi - string address.
; #############################################################################

strprintln:
    call strprint
    mov  rdi, ASCII_NL
    call chprint
    ret

; #############################################################################
; Description:
;   Prints an integer to stdout.
;
; Arguments:
;   rdi - integer value.
; #############################################################################

intprint:

    mov  rax, rdi         ; initialize rax with our number.
    mov  rcx,  0          ; initialize counter.
    mov  rsi, 10          ; initialize divisor.

.divide_loop:
    inc  rcx              ; increment number of bytes to print.
    xor  rdx, rdx         ; clear remainder.
    idiv rsi              ; divide rax by divisor (10).
    add  rdx, '0'         ; convert remainder to ascii.
    push rdx              ; save remainder on the stack.
    cmp  rax, 0           ; can we divide more?
    jnz  .divide_loop

.print_loop:
    dec  rcx              ; decrement number of bytes to print.
    pop  rdi              ; last pushed ascii value onto the stack.
    push rcx
    call chprint
    pop  rcx
    cmp  rcx, 0           ; have we print all bytes we pushed onto the stack?
    jnz  .print_loop

    ret

; #############################################################################
; Description:
;   Prints an integer and a new line to stdout.
;
; Arguments:
;   rdi - integer value.
; #############################################################################

intprintln:
    call intprint
    mov  rdi, ASCII_NL
    call chprint
    ret

; #############################################################################
; Desctiption:
;     Converts a string to an integer.
;
; Arguments:
;   rdi - string address.
;
; Return:
;   rax - integer value.
; #############################################################################

stoi:
    push rbx

    mov rsi, rdi        ; address of the string.
    mov rax, 0          ; integer value.
    mov rcx, 0          ; initialize counter.

.multiply_loop:
    xor rbx, rbx        ; clear rbx.
    mov bl, [rsi + rcx] ; move a single byte into rbx register's lower half.
    cmp bl, '0'
    jl  .finish
    cmp bl, '9'
    jg .finish

    sub bl, '0'
    add rax, rbx
    mov rbx, 10
    mul rbx             ; multiply rax by rbx to get place value.
    inc rcx
    jmp .multiply_loop

.finish:
    mov rbx, 10
    div rbx

    pop rbx
    ret

; #############################################################################
; Description:
;   Exits the program.
;
; Arguments:
;   rdi - exit code.
; #############################################################################

exit:
    mov  rax, SYS_EXIT
    syscall
