@ vim:ft=armv5
@ Add these two numbers:
@   0x12345678 0x23456789 0x3456789a
@   0x456789ab 0x56789abc 0xfedcba98

.thumb_func
.global main
main:
    @ BL stdio_init_all
after:
    @ Get W0s into R0, R1
    MOV R0, #0x34
    LSL R0, #24
    MOV R7, #0x56
    LSL R7, #16
    ADD R0, R7
    MOV R7, #0x78
    LSL R7, #8
    ADD R0, R7
    MOV R7, #0x9a
    ADD R0, R7

    MOV R1, #0xfe
    LSL R1, #24
    MOV R7, #0xdc
    LSL R7, #16
    ADD R1, R7
    MOV R7, #0xba
    LSL R7, #8
    ADD R1, R7
    MOV R7, #0x98
    ADD R1, R7

    @ Get W1s into R2, R3
    MOV R2, #0x23
    LSL R2, #24
    MOV R7, #0x45
    LSL R7, #16
    ADD R2, R7
    MOV R7, #0x67
    LSL R7, #8
    ADD R2, R7
    MOV R7, #0x89
    ADD R2, R7

    MOV R3, #0x56
    LSL R3, #24
    MOV R7, #0x78
    LSL R7, #16
    ADD R3, R7
    MOV R7, #0x9a
    LSL R7, #8
    ADD R3, R7
    MOV R7, #0xbc
    ADD R3, R7

    @ Get W2s into R4, R5
    MOV R4, #0x12
    LSL R4, #24
    MOV R7, #0x34
    LSL R7, #16
    ADD R4, R7
    MOV R7, #0x56
    LSL R7, #8
    ADD R4, R7
    MOV R7, #0x78
    ADD R4, R7

    MOV R5, #0x45
    LSL R5, #24
    MOV R7, #0x67
    LSL R7, #16
    ADD R5, R7
    MOV R7, #0x89
    LSL R7, #8
    ADD R5, R7
    MOV R7, #0xab
    ADD R5, R7

    @ Add W0s, R0 = R0 + R1
    ADD R0, R1

    @ Add W1s with carry, R2 = R2 + R3 + carry
    ADC R2, R3

    @ Add W2s with carry, R4 = R4 + R5 + carry
    ADC R4, R5

loop:
    b loop

