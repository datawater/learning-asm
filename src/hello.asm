%include "src/libc.inc"

SECTION .text

global _start

_start:
    mov rdi, hello_world
    call puts

    mov rdi, 0
    call exit

SECTION .data

hello_world db "Hello, World!", 0