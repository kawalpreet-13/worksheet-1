%include "asm_io.inc"

section .data
    prompt_a db "Input first integer: ", 0
    prompt_b db "Input second integer: ", 0
    plus_sign db " + ", 0
    equal_sign db " = ", 0
    heading db "Result: ", 0

section .bss
    first_value resd 1
    second_value resd 1
    total resd 1

section .text
    global asm_main

asm_main:
    push ebp
    mov ebp, esp
    pusha

    mov eax, prompt_a
    call print_string
    call read_int
    mov [first_value], eax

    mov eax, prompt_b
    call print_string
    call read_int
    mov [second_value], eax

    add eax, [first_value]
    mov [total], eax

    mov eax, heading
    call print_string

    mov eax, [first_value]
    call print_int

    mov eax, plus_sign
    call print_string

    mov eax, [second_value]
    call print_int

    mov eax, equal_sign
    call print_string

    mov eax, [total]
    call print_int
    call print_nl

    popa
    xor eax, eax
    leave
    ret