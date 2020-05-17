%include 'lib.asm'

SECTION .data
    msg1 db 'Hello', 10, 0

SECTION .text
    global _start

_start:
    push msg1
    call slen   ; it saves length of string in rax

    push rax    ; we call exit with exit code in rax (length).
    call exit
