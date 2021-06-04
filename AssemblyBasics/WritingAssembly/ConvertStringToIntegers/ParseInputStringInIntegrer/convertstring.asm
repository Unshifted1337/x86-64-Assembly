; soln.asm

section .data
    inputfilename  db "input.txt", 0
    inputfile      db 0
    inputbufferlen equ 1024
    intarraylen    equ 200
    numberbuflen   equ 32

section .bss
    ; When we run the program, allocate inputbufferlen
    ; worth of bytes for inputbuffer
    inputbuffer    resb inputbufferlen
    ; Allocate intarraylen worth of dwords for
    ; our intarray. This allows us to store 200 integers
    intarray       resd intarraylen
    numberbuf      resb numberbuflen

section .text
    global main
    global atoi

main:
    ; ...

    ; Old debug print code that printed the inputbuffer to stdout.
    ; Comment this out for now
    ;
    ; mov rax, NR_WRITE
    ; mov rdi, STDOUT
    ; lea rsi, [inputbuffer]
    ; syscall

    ; Clear rax, rcx, rdx for the integer parsing loop
    xor rax, rax
    xor rcx, rcx
    xor rbx, rbx

    ; Load the address of inputbuffer into rsi
    lea rsi, [inputbuffer]

.int_parse:
    mov al, byte [rsi]          ; Get the next byte
    inc rsi                     ; Increment our inputbuffer string index
    cmp al, 0xa                 ; Check if the byte is a newline; if so, we are done
    je .end_of_num              ; gathering the substring

    mov [numberbuf+rcx], al     ; Load the byte into numberbuf at the rcx-th index
    inc rcx                     ; Increase our numberbuf index
    jmp .int_parse              ; Loop to next byte

.end_of_num:
    lea rdi, [numberbuf]        ; Load the address of numberbuf into rdi
    call atoi                   ; Call the atoi function on our numberbuf string
    mov [intarray+rbx*4], eax   ; Move the parsed number into the array

    ; Zero out the bytes we used in numberbuf
    xor rax, rax                ; Clear rax to 0
    lea rdi, [numberbuf]        ; move the address of numberbuf into rdi
    repe stosb                  ; Zero out the first rcx bytes of numberbuf

    ; Prepare for next loop
    inc rbx                     ; Increment our intarray index
    xor rcx, rcx                ; Clear rcx for next loop
    cmp rbx, intarraylen        ; Check if we have parsed all of the numbers
    jl .int_parse               ; If we have not parsed all the numbers, loop

    ; For now, just write the intarray to stdout to verify this works
    mov rax, NR_WRITE
    mov rdi, STDOUT
    lea rsi, [intarray]
    mov rdx, intarraylen * 4
    syscall

    ; ...
