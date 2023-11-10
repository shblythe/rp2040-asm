@ vi: ft=armv5
@ Subtract two 64-bit numbers:
@  0x67_02345678
@ -0x12_12345678
@  -------------
@  0x54_F0000000

.thumb_func
.global main
main:
    @ Load 0x67_02345678 into r0_r1
    MOV R0, #0x67
    MOV R1, #0x02
    LSL R1, #24
    MOV R7, #0x34
    LSL R7, #16
    ADD R1, R7
    MOV R7, #0x56
    LSL R7, #8
    ADD R1, R7
    ADD R1, #0x78

    @ Load 0x12_12345678 into r2_r3
    MOV R2, #0x12
    MOV R3, #0x12
    LSL R3, #24
    MOV R7, #0x34
    LSL R7, #16
    ADD R3, R7
    MOV R7, #0x56
    LSL R7, #8
    ADD R3, R7
    ADD R3, #0x78

    @ Subtract r4_r5 = r0_r1 - r2_r3
    SUB R5, R1, R3
    SBC R0, R2
    MOV R4, R0
loop:
    B loop
