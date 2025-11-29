global _start

section .text
_start:
call main
mov rdi, rax
mov rax, 60
syscall
   ;; Calls ComputeA and B
main:
    call computeA
    mov rdi, rax
    call computeB
    add rdi, rax
    mov rax, rdi

helper:
    add rdi, 3
    mov rax, rdi
    ret

    ;; Calls helper and returns a_local and helper_result
computeA:
    mov rdi, 5
    call helper
    add rdi, rax
    mov rax, rdi
    ret

    ;; Returns b_localk
computeB:
    mov rdi, 10
    add rdi, 2
    mov rax, rdi
    ret
