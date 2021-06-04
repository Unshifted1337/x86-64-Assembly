    mov rax, 2      ; move the number 2 into rax
    cmp rax, 1      ; compare the values of rax and 1
    jle sub_one     ; if rax is less than or equal to 1, jump to sub_one
    add rax, 1      ; add one to rax -- the 'if' path
    jmp exit        ; jump to exit
sub_one:            ; the sub_one label
    sub rax, 1      ; subtract one from rax -- the 'else' path
exit:               ; the exit label
