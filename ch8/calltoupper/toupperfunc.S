@ vi: ft=armv5

.thumb_func
.global mytoupper

@ function: mytoupper
@   Converts string to upper case, separate output destination
@   Assumes destination contains enough space, no error checking
@ parameters on entry:
@   R0  - address of input string
@   R1  - address of output string
@ additional registers used during execution:
@   R2  - no need to save - current character value
@   R3  - no need to save - current character index
@ return value on exit:
@   R0 - string length

mytoupper:

    MOV R3, #0
do_until:   @ continue until we've processed the null-terminator
    LDRB R2, [R0, R3]
    CMP R2, #'a'
    BLT not_lower
    CMP R2, #'z'
    BGT not_lower
    @ process an uppercase char
    SUB R2, #('a'-'A')
not_lower:
    STRB R2, [R1, R3]
    ADD R3, #1
    CMP R2, #0  @ check for null-terminator
    BNE do_until
    MOV R0, R3
    SUB R0, #1  @ remove null terminator from length

    BX LR

