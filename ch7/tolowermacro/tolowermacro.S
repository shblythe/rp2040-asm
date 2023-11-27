@ vi: ft=armv5

@ function: tolowerfunc
@   Converts string to lower case, separate output destination
@   Assumes destination contains enough space, no error checking
@ parameters on entry:
@   R0  - address of input string
@   R1  - address of output string
@ additional registers used during execution:
@   R2  - no need to save
@ return value on exit:
@   none

.MACRO tolowermacro instr, outstr

    LDR R0, =\instr
    LDR R1, =\outstr
1:   @ continue until we've processed the null-terminator
    LDRB R2, [R0]
    CMP R2, #'A'
    BLT 2f
    CMP R2, #'Z'
    BGT 2f
    @ process an uppercase char
    ADD R2, #('a'-'A')
2:
    STRB R2, [R1]
    ADD R0, #1
    ADD R1, #1
    CMP R2, #0  @ check for null-terminator
    BNE 1b
.ENDM

