```arm-asm
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
```
Basic asm code to add two to a number.

### Key concepts:

1. **RDI** = first argument (input to function)
2. **RAX** = return value
3. **CALL** = pushes return address to stack
4. **RET** = pops return address, jumps back
5. **SYS_EXIT** requires:
    - `RDI` = exit code
    - `RAX` = 60

| Action                       | Instruction                 | Notes                                        |
| ---------------------------- | --------------------------- | -------------------------------------------- |
| Move a value into a register | `mov`                       | e.g., `mov rdi, 5` sets argument             |
| Add/subtract numbers         | `add`, `sub`                | e.g., `add rdi, 2`                           |
| Return a value               | `mov rax, <reg>` then `ret` | Return value always goes in `rax`            |
| Call a function              | `call <label>`              | Pushes return address on stack automatically |
| Create space for locals      | `sub rsp, <bytes>`          | Optional, if you need stack locals           |
| Restore stack                | `add rsp, <bytes>`          | Optional, before returning                   |
| Exit program (Linux)         | `mov rax, 60` + `syscall`   | Only needed if doing bare `_start`           |

