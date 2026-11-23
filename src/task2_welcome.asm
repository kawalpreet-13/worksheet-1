%include "asm_io.inc"

section .data
    ask_name db "Enter your name: ", 0
    ask_count db "Enter repetition count (51-99): ", 0
    greeting db "Welcome to Operating Systems, ", 0
    error_msg db "Invalid count! Please enter a value from 51 to 99.", 0
    finished db "Welcome sequence completed.", 0

section .bss
    student_name resb 64
    remaining resd 1

section .text
    global asm_main

asm_main:
    push ebp
    mov ebp, esp
    pusha

    mov eax, ask_name
    call print_string

    xor edi, edi

read_name:
    call read_char

    cmp al, 10
    je name_complete

    cmp eax, -1
    je name_complete

    cmp edi, 63
    jae read_name

    mov [student_name + edi], al
    inc edi
    jmp read_name

name_complete:
    mov byte [student_name + edi], 0

    mov eax, ask_count
    call print_string
    call read_int

    cmp eax, 51
    jl invalid_count

    cmp eax, 99
    jg invalid_count

    mov [remaining], eax

display_welcome:
    mov eax, greeting
    call print_string

    mov eax, student_name
    call print_string
    call print_nl

    dec dword [remaining]
    jnz display_welcome

    mov eax, finished
    call print_string
    call print_nl

    jmp exit_program

invalid_count:
    mov eax, error_msg
    call print_string
    call print_nl

exit_program:
    popa
    xor eax, eax
    leave
    ret