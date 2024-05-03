%include "src/libc.inc"

SECTION .text

global _start

_start:
    mov rdi, hello_world
    call puts

    xor rdi, rdi
    call exit

SECTION .data

hello_world db "Hello, World!", 0