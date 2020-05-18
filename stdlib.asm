;
; Standard Library.
;

; #############################################################################
;                                  Constants.
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
%define ASCII_ZERO   48

; exit codes.
%define EXIT_SUCCESS  0

; #############################################################################
;                        Calculates length of a string.
;                        Input: string address in rax.
;                        Return: string length in rax.
; #############################################################################

str_len:
    push rbx
    mov  rbx, rax       ; copy address of string.

next_char:
    cmp byte[rax], 0    ; check if we have reached the end of the string.
    jz  finish
    inc rax             ; move forward one character.
    jmp next_char

finish:
    sub rax, rbx        ; save length of sthe tring in rax.
    pop rbx
    ret

; #############################################################################
;                        Prints a character to stdout.
;                       Input: character in rax.
; #############################################################################

char_print:
    push rax

    mov rax, SYS_WRITE
    mov rsi, rsp
    mov rdx, 1
    syscall

    pop rax
    ret

; #############################################################################
;                         Prints an integer to stdout.
;                            Input: integer in rax.
; #############################################################################

iprint:
    push rax              ; passed integer.
    push rbx              ; counter.
    push rdx              ; division remainder.

    mov  rbx, 0           ; initialize counter to 0.

divide_loop:
    inc  rbx              ; increment number of bytes to print.
    mov  rdx, 0           ; empty rdx.
    ;idiv 10               ; divide rax by 10.
    add  rdx, ASCII_ZERO  ; convert remainder to ascii.
    push rdx              ; save remainder on the stack.
    cmp  rax, 0           ; can we divide more?
    jnz  divide_loop

print_loop:
    dec  rbx              ; decrement number of bytes to print.
    mov  rax, rsp         ; address of last pushed ascii value onto the stack.
    call char_print
    pop  rax              ; remove the last character from the stack.
    cmp  rbx, 0           ; have we print all bytes we pushed onto the stack?
    jnz  print_loop

    pop rdx
    pop rbx
    pop rax

    ret

; #############################################################################
;                 Prints an integer and a new line to stdout.
;                            Input: integer in rax.
; #############################################################################

iprintln:
    ; print an integer.
    call iprint

    ; print a new line char.
    push ASCII_NL
    mov rax, rsp
    call char_print

    ret

; #############################################################################
;                         Prints a string to stdout.
;                        Input: string address in rax.
; #############################################################################

str_print:
    push rdx            ; counter.
    push rax            ; string address.

    call str_len           ; returns string len in rax.
    mov  rdx, rax       ; how many bytes to write.
    pop  rax            ; restore address of the string.

    mov rdi, STDOUT
    mov rsi, rax        ; address of the string.
    mov rax, SYS_WRITE
    syscall

    pop rdx
    ret

; #############################################################################
;                  Prints a string and a new line to stdout.
;                        Input: string address in rax.
; #############################################################################

str_println:
    call str_print

    mov  rax, ASCII_NL
    call char_print

    ret

; #############################################################################
;                              Exits the program.
; #############################################################################

exit:
    mov rax, SYS_EXIT
    mov rdi, EXIT_SUCCESS
    syscall
