@ vi: ft=armv5

.include "tolowermacro.S"
.thumb_func
.global main

main:
    BL stdio_init_all

    tolowermacro instr0, outstr
    LDR R0, =instr0
    BL process_test_string

    tolowermacro instr1, outstr
    LDR R0, =instr1
    BL process_test_string

    tolowermacro instr2, outstr
    LDR R0, =instr2
    BL process_test_string

end:    b end

@ Function: process_test_string
@   Processes a test string, converting to lower and printing before and after
@ Parameters on entry
@   R0 - the address of the string
@ Registers used
@   R4 - stores the test string address between calls, needs saving
@ Return value on exit
@   None
process_test_string:
    PUSH {R4,LR}
    MOV R4, R0

    LDR R0, =divide
    BL println

    @ print before
    LDR R0, =before
    BL println
    MOV R0, R4
    BL println

    @ print after
    LDR R0, =after
    BL println
    LDR R0, =outstr
    BL println

    @ return
    POP {R4, PC}

@ Function: println
@   Prints an unformatted string and adds a CR at the end
@ Parameters on entry
@   R0 - the address of the string
@ Registers used
@   R1 - no need to save
@ Return value on exit
@   R0 - whatever printf returns
println:
    PUSH {LR}
    MOV R1, R0
    LDR R0, =str_cr
    BL printf
    POP {PC}

.data
.align 1
instr0:  .asciz  "Convert THIS WHOLE STRING, Stephen Blythe, to lower case"
.align 1
instr1:  .asciz  "Here's another as well, DEFINITELY needs to be in lower case!"
.align 1
instr2:  .asciz  "And, HERE, is YET ANOTHER that needs converting!"

.align 1
outstr: .fill 80,1,0xff
.align 1
str_cr: .asciz  "%s\n"
before: .asciz  "Before:"
after:  .asciz  "After:"
divide: .asciz  "--------------------------------------------------------"


