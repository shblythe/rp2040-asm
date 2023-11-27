@ vi: ft=armv5

.thumb_func
.global main
main:
    LDR R0, =instr  @ address of current char (input)
    LDR R1, =outstr @ address of current char (output)

do_until:   @ continue until we've processed the null-terminator
    LDRB R2, [R0]
    CMP R2, #0      @ make sure we don't replace the null-terminator with a space!
    BEQ zero
    CMP R2, #'A'
    BLT not_alpha
    CMP R2, #'z'
    BGT not_alpha
    CMP R2, #'Z'
    BLE alpha
    CMP R2, #'a'
    BGE alpha
not_alpha:
    @ process a non-alpha char
    MOV R2, #' '
alpha:
zero:
    STRB R2, [R1]
    ADD R0, #1
    ADD R1, #1
    CMP R2, #0  @ check for null-terminator
    BNE do_until

end:    b end


.data
.align 1
instr:  .asciz  "(|Convert any \b non-alpha char$ to spaces, even 1^2 numbers!)"
.align 1
outstr: .fill 80,1,0xff

