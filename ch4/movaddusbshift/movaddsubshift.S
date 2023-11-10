@
@ Examples of the MOV/ADD/SUB/Shift instructions
@

.thumb_func
.global main
main:   BL stdio_init_all
after:  MOV R2, #3
        MOV R1, R2
        MOVS R1, R2     @ Explicitly states that we're moving between two low
                        @ regs, and want CPSR to update
        MOV R9, R2
        @ Not safe
        @ MOV SP, R10
        @ MOV PC, R11
        ADD R4, R2, #7  @ R4=R2+7 - immediate value is up to 3 bits
        ADD R4, R4, #255    @ Adding to same reg, up to 8 bits allowed
        ADD R4, #255        @ same as above
        MOV R7, #23         @ Can't load R8-15 immediate, so load to R7 first
        MOV R11, R7
        MOV R7, #54
        MOV R10, R7

        ADD R10, R10, R11   @ The one ADD that allows high regs
        ADD SP, SP, #508    @ Safe, as we mirror it next
        SUB SP, SP, #508
        ADD R4, SP, #1020   @ 8-bit immediate, but mults of 4 because of SP, so 0-1020 valid

        MOV R3, #8
        MOV R2, #0xFF
        MOV R1, #4
        LSL R1, R1, #2      @ Shift R1 left 2 bits
        LSL R1, #2          @ equivalent
        LSR R1, R2, #8      @ Shift R2 right by one byte, result in R1
        LSR R1, R3          @ Shift R1 right by value in R3
        ASR R1, #8          @ Arithmetic shift right R1 by one byte
        ROR R1, R3          @ Rotate R1 right by the value of R3

        @ Load 0x12345678 into R3
        MOV R3, #0x12
        LSL R3, #24
        MOV R1, #0x34
        LSL R1, #16
        ADD R3, R1
        MOV R1, #0x56
        LSL R1, #8
        ADD R3, R1
        MOV R1, #0x78
        ADD R3, R1

        @ Other registers for our upcoming 64-bit addition
        MOV R2, #0x12
        MOV R4, #0x54
        MOV R5, #0xf0
        LSL R5, #24

        @ 64-bit addition (rigged to cause a carry)
        @   R2 R3   0x12 0x12345678
        @   R4 R5   0x54 0xF0000000
        @   -----   ---------------
        @   R0 R1   0x67 0x02345678

        ADD R1, R3, R5
        ADC R2, R4
        MOV R0, R2

        @ Save R0, R1 since printf will overwrite them
        MOV R6, R0
        MOV R7, R1
loop:   MOV R1, R6
        MOV R2, R7
        LDR R0, =sumstr
        BL printf
        B loop      @ loop in case uart monitoring not started

.data
.align 4
sumstr: .asciz  "The sum is %x %x\n"

