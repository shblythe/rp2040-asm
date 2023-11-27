@ vi: ft=armv5

.thumb_func
.global tolowerfunc

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

tolowerfunc:

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

    BX LR

