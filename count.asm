;
; Description:
;   Prints a number on each line up to <limit>.
;
; Usage:
;  count <limit>
;

%include 'stdlib.asm'

section .data
    usage_msg  db  'Usage: count <limit>.', 0

section .text
    global _start

_start:
    pop  rcx         ; pop number of arguments.
    pop  rdx         ; pop program name.
    dec  rcx         ; decrease number of args.

; Check required argument.
    cmp  rcx, 1
    jne  .usage
    mov  rcx, 0

; Convert limit to int.
    pop  rbx         ; pop limit.
    mov  rdi, rbx
    call stoi
    mov  rbx, rax

    xor  rcx, rcx    ; clear counter.

.count_loop:
    cmp  rcx, rbx    ; have we reached the limit?
    je   .finish

    push rcx
    mov  rdi, rcx
    call intprintln
    pop  rcx

    inc  rcx
    jmp  .count_loop

.usage:
    mov  rdi, usage_msg
    call strprintln
    mov  rdi, 1
    call exit

.finish:
    mov rdi, 0
    call exit
