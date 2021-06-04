Now that we know what an instruction is, let us look at some common and useful assembly instructions that we will make use of:

``mov [dest] [src]`` : move data from the source to the destination

``lea [dest] [mem]`` : loads a memory address into the destination register

``xor [src] [dest]`` : xor the data in the src register with the value given as dest

``add [dest] [src]`` : add the number, register, or number in memory to the destination register

``sub [dest] [src]`` : subtract the number, register, or number in memory from the destination register

``imul [src]`` : do a signed multiplication between rax and the src register.

Note that there are other forms of imul for smaller register sizes; if you use a 32 bit, 16 bit, or 8 bit register as the src, then the corresponding size of the rax register will be used in the signed multiplication

``mul [src]`` : do an unsigned multiplication between rax and the src register

The size correspondence as explained right above also applies here

``cmp [src] [dest]`` : compare the value in the src register to the value given in dest and set the corresponding flags

We will discuss flags in the next subsection.

``jmp [label]`` : unconditionally jump to the given label

``jl [label]`` : jump to a given label if the B (below) flag is set

``jg [label]`` : jump to a given label if the A (above) flag is set

``je [label]`` : jump to a given label if the E (equal) flag is set

``jne [label]`` : jump to a given label if the NE (not equal) flag is set

``call [label]`` : call a function called label

``syscall`` : Perform a syscall.

We will discuss what a syscall is later.
