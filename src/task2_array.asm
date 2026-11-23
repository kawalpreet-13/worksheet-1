%include "asm_io.inc"

section .data
    array_size equ 100
    title_msg db "Array elements initialized: ", 0
    total_msg db "Total of integers from 1 to 100: ", 0

section .bss
    values resd array_size
    total resd 1

section .text
    global asm_main

asm_main:
    push ebp
    mov ebp, esp
    pusha

    ; Initialize array
    mov ecx, array_size
    mov edi, values
    mov eax, 1

fill_array:
    mov [edi], eax
    add edi, 4
    inc eax
    loop fill_array

    ; Calculate array sum
    mov ecx, array_size
    mov esi, values
    xor edx, edx

calculate_total:
    add edx, [esi]
    add esi, 4
    loop calculate_total

    mov [total], edx

    ; Display array size
    mov eax, title_msg
    call print_string

    mov eax, array_size
    call print_int
    call print_nl

    ; Display calculated total
    mov eax, total_msg
    call print_string

    mov eax, [total]
    call print_int
    call print_nl

    popa
    xor eax, eax
    leave
    ret