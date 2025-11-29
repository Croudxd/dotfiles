CPU is made from 3 parts.
- Control Unit (CU)
- ALU
- Registers
# ALU
ALU's are made up of adders', Adders are made up of gates, gates are made up of tons of tiny transistors (literally electricity on and off). Adders (Not just called adders, but subtractors, logic gates etc etc but i call them adders) are basically small modules with a function. Ie to ADD or XOR or OR or AND and more. Tons of these adders make up the ALU
An ALU also has registers which are used to store small amounts of data.
# Control Unit
We then have the control unit, which reads OPCODE (Opcode has a set standard from each CPU to CPU architecutre, this is called the ISA). The CU which is hard wired in will tell the ALU which adder to use. The CU will take the code from memory and then decode it, and from this will send electric control signals based on the instructions. Signals such as: Getting inputs and routing them from registers or memory to ALU's internal registers using buses. Activate the adders inside of the ALU and making sure that output registers are empty and ready to recieve output from ALU.
# [[Registers]]
Registers are able to hold small amounts of data in binary usually 64 bits, again depends on architecture.
