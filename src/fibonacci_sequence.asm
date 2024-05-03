%include "src/libc.inc"

SECTION .text

global _start

fibonacci:
    ; a = 0, b = 1, counter = 2
    xor r8, r8
    mov r9, 1
    mov r11, 2

    cmp rdi, 1
    je .one
    jl .less_than_one

    jmp .loop
.loop:
    ; c = b
    ; b += a
    ; a = c
    mov r10, r9
    add r9, r8
    mov r8, r10
    
    ; counter ++; 
    inc r11

    ; if (counter < input) {
    ;   goto loop;
    ; }
    cmp r11, rdi
    jl .loop

    jmp .end

.one:
    xor r9, r9
    jmp .end

.less_than_one:
    mov rdi, fib_less_than_one_error
    call puts

    xor r9, r9
    jmp .end

.end:
    mov rax, r9 
    ret

_start:
    mov rdi, [fib_limit]
    call fibonacci

    mov rdi, printf_format
    mov rsi, [fib_limit]
    mov rdx, rax
    xor al, al
    call printf

    xor rdi, rdi
    call exit

SECTION .data

fib_limit dq 2
printf_format db "f(%d) = %d", 10, 0
fib_less_than_one_error db "[ERROR] The n'th fibonacci number function can not take in arguments less than one"