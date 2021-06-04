; soln.asm

bits 64

section .rodata
    ; syscall numbers
    NR_READ        equ 0
    NR_WRITE       equ 1
    NR_OPEN        equ 2
    NR_CLOSE       equ 3

    ; file access modes
    O_RDONLY       equ 0
    O_WRONLY       equ 1
    O_RDWR         equ 2

    ; default file descriptors
    STDIN          equ 0
    STDOUT         equ 1
    STDERR         equ 2

section .data
    inputfilename  db "input.txt", 0
    inputfile      db 0
    inputbufferlen equ 1024

section .bss
    ; When we run the program, allocate inputbufferlen
    ; worth of bytes for inputbuffer
    inputbuffer    resb inputbufferlen

section .text
    global main

main:
    push rbp
    mov rbp, rsp

    ; open the input file
    mov rax, NR_OPEN            ; set our syscall to 'open'
    lea rdi, [inputfilename]    ; load the address of the filename
    mov rsi, O_RDONLY           ; set read only
    syscall

    ; if the syscall succeeded, rax will be a positive number
    ; representing the file descriptor. if it failed, it will
    ; be a negative number indicating the error.
    cmp rax, 0                  ; compare rax to 0
    jl .exit                    ; if rax < 0, there was an error, so exit

    ; read the input file
    mov [inputfile], rax        ; move the file descriptor into the global variable
    mov rdi, [inputfile]        ; load the file descriptor into rdi
    mov rax, NR_READ            ; set our syscall to 'read'
    lea rsi, [inputbuffer]      ; load the address of our buffer into rsi
    mov rdx, inputbufferlen     ; load the length of our buffer into rdx
.read:
    syscall                     ; read from the file

    ; if the read succeeded, the number of bytes read will be put into rax
    ; if it failed, rax will hold a negative number
    ; we must check for the error and also continue reading until rax holds
    ; 0, indicating that there are no bytes to read
    cmp rax, 0
    jl .cleanup                 ; if rax < 0, there was an error, so exit
    je .read_done               ; if rax == 0, we are done, so stop reading
    ; calculate the next offset in the buffer to read into and adjust the
    ; buffer length accordingly
    add rsi, rax
    sub rdx, rax
    mov rax, NR_READ
    jmp .read

.read_done:
    ; Add a zero to the end of the input from the buffer
    ; to terminate the string
    inc rsi
    mov [rsi], byte 0
    ; calculate the length of the string we read
    mov rdx, rsi
    sub rdx, inputbuffer

    ; For now, just write the buffer to stdout so we can verify this worked
    mov rax, NR_WRITE
    mov rdi, STDOUT
    lea rsi, [inputbuffer]
    syscall

.cleanup:
    ; we must now close the input file descriptor if we opened it
    ; if it is not 0, then we have opened the file and must close it
    mov rdi, [inputfile]
    cmp rdi, 0                  ; check if we opened the file
    je .exit                    ; if inputfile == 0, we did not
    ; we opened the file, so must close it using the 'close' syscall
    mov rax, NR_CLOSE           ; set our syscall to 'close'
    ; note that we already put the file descriptor into rdi
    syscall

.exit:
    leave
    ret
