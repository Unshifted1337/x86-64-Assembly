; soln.asm

section .data
    foundpairstr   db "Found pair: %d * %d = %d", 10, 0
    ; ...

; ...

section .text
    extern printf

    global main
    global atoi

main:
    ; ...

    ; For now, just write the intarray to stdout to verify this works
    ; mov rax, NR_WRITE
    ; mov rdi, STDOUT
    ; lea rsi, [intarray]
    ; mov rdx, intarraylen * 4
    ; syscall

    ; Our starting indices into intarray, held in r12 and r13
    mov r12, 0
    mov r13, 1
.find_pair:
    mov eax, [intarray+r12*4]   ; Move the first 4 byte number into eax
    add eax, [intarray+r13*4]   ; Add the second number to get the sum
    cmp eax, 2020               ; Check if their sum is 2020
    je .found_pair              ; If so, exit the loop
    inc r13                     ; Increment the inner loop variable
    cmp r13, intarraylen        ; Check if we just reached the last number
    jne .find_pair              ; If not, loop
    inc r12                     ; If so, increment the outer loop variable
    mov r13, r12                ; and set the inner loop variable to be one
    inc r13                     ; one more
    jmp .find_pair              ; Loop
.found_pair:
    ; Clear the following registers in case there is
    ; data in the top 32 bits that will change the
    ; numbers we will print
    xor rsi, rsi
    xor rdx, rdx
    xor rcx, rcx
    ; We have found the pair, so print them and their product out
    lea rdi, [foundpairstr]     ; Load the address of the string into rdi
    mov esi, [intarray+r12*4]   ; Load the first 4 byte number into esi
    mov edx, [intarray+r13*4]   ; Load the second 4 byte number into edx
    mov ecx, esi                ; Move the first number into ecx
    imul ecx, edx               ; Multiply by edx to get their product
    xor rax, rax                ; Clear rax (required by printf)
    call printf                 ; Call printf

    ; ...
