;
; For every integer between 1 and 100, if that integer is divisible by
; 3 - prints Fizz, by 5 - Buzz, 3 and 5 - FizzBuzz.
;

%include 'stdlib.asm'

section .data
    fizz  db  'Fizz', 0
    buzz  db  'Buzz', 0

section .text
    global _start

_start:
    mov  rcx, 0      ; counter.
    mov  r8,  0      ; .check_fizz division remainder.
    mov  r9,  0      ; .check_buzz division remainder.

.next_num:
    inc  rcx

.check_fizz:
    xor  rdx, rdx      ; clear rdx (will store remainder).
    mov  rax, rcx
    mov  rbx, 3        ; divisor.
    idiv rbx           ; divide rax by 3.
    mov  r8, rdx       ; save remainder.
    cmp  rdx, 0        ; compare remainder to 0.
    jnz  .check_buzz

; print fizz.
    push rcx
    mov  rdi, fizz
    call strprint
    pop  rcx

.check_buzz:
    xor  rdx, rdx      ; clear rdx (will store remainder).
    mov  rax, rcx
    mov  rbx, 5        ; divisor.
    idiv rbx           ; divide rax by 5.
    mov  r9, rdx       ; save remainder.
    cmp  rdx, 0        ; compare remainder to 0.
    jnz .check_int

; print buzz.
    push rcx
    mov  rdi, buzz
    call strprint
    pop  rcx

.check_int:
    cmp  r8, 0         ; have we divided evenly by 3?
    jz   .continue
    cmp  r9, 0         ; have we divided evenly by 5?
    jz   .continue

; print number.
    push rcx
    mov  rdi, rcx
    call intprint
    pop rcx

.continue:
; print newline.
    push rcx
    mov  rdi, ASCII_NL
    call chprint
    pop  rcx

    cmp  rcx, 100      ; have we reached the last number?
    jne  .next_num

    call exit
