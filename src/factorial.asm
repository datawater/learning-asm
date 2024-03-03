%include "src/libc.inc"

SECTION .text

global _start

factorial:
    ; counter = 1, result = 1, clears rdx
    mov rcx, 1
    mov rax, 1
    mov rdx, 0

    ; if (input <= 0) goto error
    cmp rdi, 0
    jnge .error

    inc rdi

    jmp .loop

.loop:
    ; makes a backup of rdx
    mov r8, rdx
    
    mul rcx
    
    cmp r8, rdx
    jne .mulled_into_rdx

.loop_tail:
    inc rcx
    cmp rcx, rdi
    je .ret
    jmp .loop

.mulled_into_rdx:
    mov rax, rdx
    jmp .loop_tail

.error:
    mov rdi, factorial_zero_error
    call puts
    jmp .ret

.ret:
    ret

_start:
    mov rdi, [n]
    call factorial

    mov rdi, printf_format
    mov rsi, [n]
    mov rdx, rax
    mov al, 0
    call printf

    mov rdi, 0
    call exit

SECTION .data

n dq 5
printf_format db "%d! = %d", 10, 0
factorial_zero_error db "[ERROR] The function factorial can not accept inputs that are less or equal to 0", 0