%include "asm_io.inc"

section .data
    value_a dd 32
    value_b dd 48
    message db "Calculated total: ", 0

section .text
    global asm_main

asm_main:
    push ebp
    mov ebp, esp
    pusha

    mov eax, message
    call print_string

    mov eax, [value_a]
    add eax, [value_b]

    call print_int
    call print_nl

    popa
    xor eax, eax

    leave
    ret