@ vi: ft=armv5

.thumb_func
.global main
main:
    LDR R0, =instr  @ address of current char (input)
    LDR R1, =outstr @ address of current char (output)

do_until:   @ continue until we've processed the null-terminator
    LDRB R2, [R0]
    CMP R2, #'A'
    BLT not_upper
    CMP R2, #'Z'
    BGT not_upper
    @ process an uppercase char
    ADD R2, #('a'-'A')
not_upper:
    STRB R2, [R1]
    ADD R0, #1
    ADD R1, #1
    CMP R2, #0  @ check for null-terminator
    BNE do_until

end:    b end


.data
.align 1
instr:  .asciz  "Convert THIS WHOLE STRING, Stephen Blythe, to lower case"
.align 1
outstr: .fill 80,1,0xff

