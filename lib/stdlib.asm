;
; Standard Library.
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
%define SYS_EXIT     60

; ascii values.
%define ASCII_NL     10

; exit codes.
%define EXIT_SUCCESS  0

; #############################################################################
; Calculates length of a string.
; Input: string address in rax.
; Return: string length in rax.
; #############################################################################

str_len:
    push rbx
    mov  rbx, rax       ; copy address of string.

.next_char:
    cmp byte[rax], 0    ; check if we have reached the end of the string.
    jz  .finish
    inc rax             ; move forward one character.
    jmp .next_char

.finish:
    sub rax, rbx        ; save length of sthe tring in rax.
    pop rbx
    ret

; #############################################################################
; Prints a character to stdout.
; Input: character in rax.
; #############################################################################

char_print:
    push rcx  ; for whatever reason sys_write messes up rcx.
    push rax

    mov rax, SYS_WRITE
    mov rdi, STDOUT
    mov rsi, rsp
    mov rdx, 1
    syscall

    pop rax
    pop rcx
    ret

; #############################################################################
; Prints an integer to stdout.
; Input: integer in rax.
; #############################################################################

int_print:
    push rax              ; input integer.
    push rcx              ; counter.
    push rdx              ; division remainder.
    push rsi              ; divisor.

    mov  rcx,  0          ; initialize counter.
    mov  rsi, 10          ; initialize divisor.

.divide_loop:
    inc  rcx              ; increment number of bytes to print.
    mov  rdx, 0           ; clear rdx.
    idiv rsi              ; divide rax by divisor (10).
    add  rdx, '0'         ; convert remainder to ascii.
    push rdx              ; save remainder on the stack.
    cmp  rax, 0           ; can we divide more?
    jnz  .divide_loop

.print_loop:
    dec  rcx              ; decrement number of bytes to print.
    pop  rax              ; last pushed ascii value onto the stack.
    call char_print
    cmp  rcx, 0           ; have we print all bytes we pushed onto the stack?
    jnz  .print_loop

    pop  rsi
    pop  rdx
    pop  rcx
    pop  rax
    ret

; #############################################################################
; Prints an integer and a new line to stdout.
; Input: integer in rax.
; #############################################################################

int_println:
    call int_print

    mov  rax, ASCII_NL
    call char_print

    ret

; #############################################################################
; Prints a string to stdout.
; Input: string address in rax.
; #############################################################################

str_print:
    push rax            ; string address.

    call str_len        ; returns string len in rax.
    mov  rdx, rax       ; how many bytes to write.
    pop  rax            ; restore address of the string.

    mov rdi, STDOUT
    mov rsi, rax        ; address of the string.
    mov rax, SYS_WRITE
    syscall

    ret

; #############################################################################
; Prints a string and a new line to stdout.
; Input: string address in rax.
; #############################################################################

str_println:
    call str_print

    mov  rax, ASCII_NL
    call char_print

    ret

; #############################################################################
; Exits the program.
; #############################################################################

exit:
    mov rax, SYS_EXIT
    mov rdi, EXIT_SUCCESS
    syscall

; #############################################################################
; Converts string to an integer.
; Input: string address in rax.
; #############################################################################

str_to_int:
    push rbx
    push rcx            ; counter.
    push rdx
    push rsi

    mov rsi, rax        ; address of the string.
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

    pop rsi
    pop rdx
    pop rcx
    pop rbx
    ret
