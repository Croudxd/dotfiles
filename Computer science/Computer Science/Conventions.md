Sysv AMD64 Conventions (Linux)

First 6 arguments go into:

| argument | register |
| -------- | -------- |
| 1st      | RDI      |
| 2nd      | RSI      |
| 3rd      | RDX      |
| 4th      | RCX      |
| 5th      | R8       |
| 6th      | R9       |
Anything after 6 goes into stack.
Floating-point args go in XMM0–XMM7 (see [[Registers]])
### Return value
- Returned in **RAX**
- If the function returns something bigger than 8 bytes, like a struct, then a hidden pointer to a caller-allocated memory area is passed in RDI, and the callee writes into that.

When a function starts:
```asm
push rbp          ; save caller's base pointer
mov  rbp, rsp     ; set our own base pointer
sub  rsp, N       ; reserve space for locals
```

```asm
leave   ; restores rbp and rsp
ret
```

### Callee vs Caller registers

| Type                            | Registers                       | Who must restore |
| ------------------------------- | ------------------------------- | ---------------- |
| **Caller-saved (volatile)**     | RAX, RCX, RDX, RSI, RDI, R8–R11 | caller           |
| **Callee-saved (non-volatile)** | RBX, RBP, R12–R15               | callee           |
Meaning:
- If you (the caller) want to keep something in RAX while calling another function, **you must save it** (push it or spill it).
- If the callee uses RBX or R12–R15, **it must save/restore them before return**.
This is what makes nested calls safe.

```asm
main()
  RDI = 10                ; argument for Foo
  CALL Foo
---------------------------
STACK after CALL:
  return_to_main
---------------------------
Foo starts
  push rbp
  mov  rbp, rsp
  sub  rsp, 16            ; locals
  RDI = 10 (arg1)
  RSI = <maybe another>   ; arg2 if any
  ... compute ...
  mov  rax, result
  leave
  ret
```

