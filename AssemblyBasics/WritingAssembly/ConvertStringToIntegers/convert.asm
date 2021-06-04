; soln.asm

; ...
section .text
    global main
    global atoi

main:
    ; ...
    leave
    ret

; Interprets a string and returns its content as a positive integral number.
; NOTE: the string should contain only ASCII digits and be null terminated.
; NOTE: this assumes *little endian* format.
; NOTE: this function does not handle negative integers.
;
; Parameters:
;   * `rdi` : pointer to the start of the string
;
; Returns:
;   * `rax` : 8 byte integer
atoi:
    ; set up the stack frame
    push rbp
    mov rbp, rsp

    ; set rdx and rax to 0
    xor rax, rax
    xor rdx, rdx

; We are going to loop through all of the bytes of the string,
; turn the ASCII digit into a number from 0-9, multiply the
; existing number by 10, and then add it to the total number
;
; We will know to stop looping when the current byte is '0',
; the null byte terminating the string
;
; This total number will be stored in rax for the duration
; of the loop
.next_byte:
    mov dl, byte [rdi]          ; Get the next byte
    cmp rdx, 0                  ; If rdx is the null byte, we are done
    je .exit                    ; jump to exit
    sub rdx, 0x30               ; subtract 0x30 from the ASCII digit to map it to 0-9
    imul rax, 0xa               ; multiply the number by 10 to make space in the one's digit
    add rax, rdx                ; add the digit to the sum
    inc rdi                     ; increment our byte pointer to the next byte in the string
    jmp .next_byte              ; loop

; Upon exit, the 8 byte number is stored in rax
.exit:
    leave
    ret
