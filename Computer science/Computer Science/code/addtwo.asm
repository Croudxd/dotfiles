global _start

section .text
_start:
mov rdi, 5
call addTwo
mov rdi, rax
mov rax, 60
syscall


addTwo:
    add rdi, 2
    mov rax, rdi
    ret
