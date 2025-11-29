Locals are variables that live in the [[stack]] rather than in registers.
for example.

```c
int foo(int x) {
    int y = x + 2;
    return y;
}
```
In this function we don't use a local only registers as we are not doing much x can live in a register RDI (one of the 16 registers in x86), `x+2` lives also inside a register (RAX) and so we can just return RAX.
but if we have a function like:
```c
int foo(int x) {
    int y = x + 2;
    int z = y * 3;
    int w = z + y;
    return w;
}
```
In this case we might use a local because of:
- it must survive a function call (because calls overwrite registers)
- there are no free registers left
- the language rules force it (like taking a variable’s address with `&a` in C)
So say the registers are all full.
So inside the stack:
```
[RSP-16] = z
[RSP-8] = y
return address
```
this we store the variables inside the stack (locals)
However, when we do the computation the variables will still be put into registers. The stack however will hold the values between computations.
Golden rule:

| register          | temporary, short term, fast math, Dies when next instrtuctction overwrites it | Dies when next instrtuctction overwrites it |
| ----------------- | ----------------------------------------------------------------------------- | ------------------------------------------- |
| **stack (local)** | needs to persist across calls, addressable, too many values to fit            | dies when function returns                  |
