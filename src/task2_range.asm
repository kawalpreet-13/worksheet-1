%include "asm_io.inc"

section .data
    lower_prompt db "Enter starting position (1-100): ", 0
    upper_prompt db "Enter ending position (1-100): ", 0
    result_msg db "Calculated range total: ", 0
    error_msg db "Error: Selected range is not valid.", 0

section .bss
    values resd 100
    lower_limit resd 1
    upper_limit resd 1

section .text
    global asm_main

asm_main:
    push ebp
    mov ebp, esp
    pusha

    ; Initialize array with values 1-100
    mov edi, values
    mov ecx, 100
    mov eax, 1

populate:
    mov [edi], eax
    add edi, 4
    inc eax
    loop populate

    ; Read starting position
    mov eax, lower_prompt
    call print_string
    call read_int
    mov [lower_limit], eax

    ; Read ending position
    mov eax, upper_prompt
    call print_string
    call read_int
    mov [upper_limit], eax

    ; Validate selected range
    mov eax, [lower_limit]
    mov ebx, [upper_limit]

    cmp eax, 1
    jl reject_range

    cmp ebx, 100
    jg reject_range

    cmp eax, ebx
    jg reject_range

    ; Calculate number of selected elements
    mov ecx, ebx
    sub ecx, eax
    inc ecx

    ; Locate first selected element
    dec eax
    lea esi, [values + eax * 4]

    xor edx, edx

accumulate:
    add edx, [esi]
    add esi, 4
    loop accumulate

    ; Display result
    mov ebx, edx
    mov eax, result_msg
    call print_string

    mov eax, ebx
    call print_int
    call print_nl

    jmp finish

reject_range:
    mov eax, error_msg
    call print_string
    call print_nl

finish:
    popa
    xor eax, eax
    leave
    ret