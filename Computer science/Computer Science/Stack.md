The stack is a downwards moving part of memory. ie we start at the top of the memory and move down. The stack is pretty much where return addresses, local  variables and  saved register/context live which will then be used by the CU (see [[CPU]]).
How the stack works is like this
```
func main()
{
a = 10
Foo(a)
}

func Foo(int x)
{
a = x+2
Bar(a)
}

func Bar(int x)
{
a = x - 5
}
```
In this basic code snippet we call Foo inside main and then Bar inside Foo.
The stack will 

```
R0 = R1
R1 then takes result from SUBTRACT
SUBTRACT x, 5
initialise register R1 for result
register R0 for x
return adress for Bar()

R0 = R1
R! then takes result from the ADD
ADD x, 2
initalize register R1 for result
register R0 for x 
return address for Foo

set a = 10 into a register
Return address for main()
```
The return address for each function is used to return the result back to the original main().

