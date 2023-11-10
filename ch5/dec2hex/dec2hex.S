@ vi: ft=armv5
.thumb_func
.global main
main:
    @ load the number to be converted, 0x8765abcd, into R4
    MOV R4, #0x87
    LSL R4, #24
    MOV R7, #0x65
    LSL R7, #16
    ADD R4, R7
    MOV R7, #0xab
    LSL R7, #8
    ADD R4, R7
    MOV R7, #0xcd
    ADD R4, R7

    LDR R1, =outstr
    ADD R1, #9   @ destination address in R1

    MOV R7, #8   @ loop counter
    MOV R2, #0xf @ digit mask
forloop:        @ for r7 = 8 to 1 step -1
    MOV R0, R4  @ digit to convert in R0
    AND R0, R2
    CMP R0, #10 @ if digit < 10 then
    BGE else
    ADD R0, #'0'
    B   endif
else:
    ADD R0, #'A'-10
endif:
    STRB R0, [R1]
    SUB R1, #1
    LSR R4, #4
    SUB R7, #1
    BNE forloop
loop:
    b loop

.align 4
.data
outstr: .asciz "0x00000000"

