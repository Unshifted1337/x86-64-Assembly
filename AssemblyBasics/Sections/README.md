We must now discuss sections of an executable program, as we must define these ourselves when writing assembly code.

Sections are parts of an executable that have different purposes. They are separated for sake of organization and permission differences when mapped into virtual memory upon a program being run. You don't have to worry too much about what that means; just know each section has a defined usage, and we have to put our code in each section accordingly.

We will be using the following sections:

rodata : read only memory

data : read and writable memory

bss : memory allocated upon program execution

The Linux kernel allocates this memory when we run the process, but the values aren't actually stored in the executable file as in the data and rodata sections. You don't have to worry too much about what this means.

This section is typically used for global arrays and other large contiguous data structures in memory that don't have a predefined value at compile time.

text : code that is executed during runtime

You can think of the rodata section as storing global, constant variables; the data section as storing ordinary global variables, and the bss section as storing global arrays with uninitialized memory at the start of program execution.
