Registers for x86 arch
|64-bit|32-bit|16-bit|8-bit|Typical use|
### x86-64 General Purpose Registers

| 64-bit | 32-bit | 16-bit | 8-bit | Typical use |
| --- | --- | --- | --- | --- |
| RAX | EAX | AX | AL | Accumulator / return value |
| RBX | EBX | BX | BL | Base register (callee-saved) |
| RCX | ECX | CX | CL | Counter / 4th arg (caller-saved) |
| RDX | EDX | DX | DL | Data / 3rd arg (caller-saved) |
| RSI | ESI | SI | SIL | Source index / 2nd arg |
| RDI | EDI | DI | DIL | Destination index / 1st arg |
| RBP | EBP | BP | BPL | Base pointer (callee-saved) |
| RSP | ESP | SP | SPL | Stack pointer |
| R8  | R8D | R8W | R8B | 5th arg |
| R9  | R9D | R9W | R9B | 6th arg |
| R10 | R10D | R10W | R10B | Caller-saved temp |
| R11 | R11D | R11W | R11B | Caller-saved temp |
| R12 | R12D | R12W | R12B | Callee-saved |
| R13 | R13D | R13W | R13B | Callee-saved |
| R14 | R14D | R14W | R14B | Callee-saved |
| R15 | R15D | R15W | R15B | Callee-saved |
### Instruction Pointer and Flags

| Register | Description |
| --- | --- |
| RIP | Instruction Pointer (address of the next instruction) |
| RFLAGS | Status/condition flags (Zero, Carry, Sign, Overflow, etc.) |

**Common RFLAGS bits:**
- CF — Carry flag  
- ZF — Zero flag  
- SF — Sign flag  
- OF — Overflow flag  
- PF — Parity flag  
- DF — Direction flag  

---

### Segment Registers (mostly legacy in 64-bit mode)

| Register | Purpose |
| --- | --- |
| CS | Code Segment |
| DS | Data Segment |
| ES | Extra Segment |
| FS | General purpose (often used for thread-local storage) |
| GS | General purpose (used for thread-local storage on Linux/Windows) |
| SS | Stack Segment |

---

### SIMD / Floating-Point Registers

| Type | Registers | Size | Use |
| --- | --- | --- | --- |
| XMM0–XMM15 | 16 registers | 128-bit | SSE / floating-point arithmetic |
| YMM0–YMM15 | 16 registers | 256-bit | AVX (extends XMM) |
| ZMM0–ZMM31 | 32 registers | 512-bit | AVX-512 (newer CPUs) |
| MXCSR | 1 register | 32-bit | SIMD control/status register |

---

### System / Control Registers (privileged mode only)

| Register | Use |
| --- | --- |
| CR0–CR4 | CPU control flags (paging, protection, etc.) |
| CR8 | Task priority register |
| GDTR | Global Descriptor Table base address |
| IDTR | Interrupt Descriptor Table base address |
| LDTR | Local Descriptor Table register |
| TR | Task register (for TSS) |
