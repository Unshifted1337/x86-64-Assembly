; soln.asm

; tell nasm that we are writing a 64 bit program
bits 64

; read only data
section .rodata

; data
section .data
; Note that the 0 at the end appends a null-byte
; to terminate the string
hello_world db "Hello, world!", 0

; uninitialized memory
section .bss

; code
section .text
    global main     ; export main

; our main function
main:
    ; Push the stack pointer. Don't worry too much about this
    push rbp
    mov rbp, rsp

    ; Load the number 1 into rax. This denotes that we want to perform the
    ; WRITE system call.
    mov rax, 0x1
    ; Move the number 1 into rdi. This denotes the file we want to
    ; write to, and STDOUT has a file descriptor of 1 for (virtually)
    ; all Linux processes
    mov rdi, 0x1
    ; Load the memory address of the hello_world string into rsi
    lea rsi, [hello_world]
    ; Load the number of bytes we want to write into rdx, which is the length
    ; of our hello world string:
    mov rdx, 13
    ; Invoke the syscall
    syscall

    ; Pop the stack pointer back off and return from the main function.
    ; Don't worry too much about this.
    leave
    ret
