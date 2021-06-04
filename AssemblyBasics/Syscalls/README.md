I mentioned before that to perform many common operations, such as opening, reading from, writing to, and closing files, we will have to interface with the operating system. This is because the operating system manages all of the hardware in a computer, including storage, and thus the operating system manages the filesystem. Thus, if we want to interact with files, we must work with the operating system. Whenever you open a file in a higher level language, it is ultimately interfacing with the operating system in this way.

As we are working with Linux in our code, we will use the system call interface. This is ultimately rather simple. We will just have to move some data into specific registers to tell the Linux kernel what operation we want to perform, as well as supply data to perform that operation, and then we use the syscall instruction.

Each system call has a corresponding number. The ones that we will use are:

read -- 0 : read from a file
write -- 1 : write to a file
open -- 2 : open a file
close -- 3 : close a file
We move the number of the system call into rax, move other arguments into other specified registers, and then use syscall to perform the operation.

Think of a syscall as a function -- just a special function that the Linux kernel executes.
