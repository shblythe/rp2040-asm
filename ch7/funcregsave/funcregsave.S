@ vi: ft=armv5

@ Suppose the function "func" uses registers R4, R5, R6, R8, R9, and calls other functions
@ Code the prologue and epilogue to store and restore the correct regs

@ To call a function, we use "BL"  which puts the address of the next instruction
@ (the return address) into the link register, LR, before branching.
@ If our function calls other functions, then LR is one of the registers we'll need to
@ save and restore.
@ Conventions for register use with the SDK:
@   * RO-R3 are function parameters and they can be used freely by any function.
@       The onus is on the calling function to save these if they are needed
@   * R4-R11 can be used freely by called routines, but they are expected to return unchanged.
@       The onus is on the called function to save these if they are used
@   * R12 - intraprocedure scratch register - don't use
@   * SP - can be used by called routine, but should return with the same value by balancing
@       pushes and pops
@   * LR - link register, must be preserved by the called routine
@   * CPSR - no assumptions allowed, no need to save
@
@ Summary of function call algorithm:
@ (though note that stack operations can be combined)
@   Calling function:
@       1. If we need the values in any of R0-R3, save them
@       2. Put the first four params in R0-R3
@       3. Push additional params on to the stack
@       4. Call the function with BL
@       5. Evaluate the return code in R0
@       6. Restore saved values of R0-R3
@
@   Called function:
@       1. If we call other functions, PUSH LR
@       2. PUSH any of R4-R11 that we are going to change
@       3. Do our stuff!
@       4. Put return code in R0
@       5. POP those of R4-R11 that we pushed
@       6. If we call other functions, POP PC, otherwise BX LR
@
@ Note that PUSH/POP don't work with R8-R11 - so we need to MOV to another reg first
.thumb_func
.global main
main:
    MOV R4, #0x44
    MOV R5, #0x88
    MOV R6, #0x99
    MOV R8, R5
    MOV R9, R6
    MOV R5, #0x55
    MOV R6, #0x66
    BL func

end:
    B end

func:
    PUSH {R4,R5,R6,LR}   @ save the link register, plus R4-R6
    MOV R4, R8
    MOV R5, R9
    PUSH {R4,R5}        @ save the R8, R9 values

    @ do our stuff!
    MOV R5, #0x80
    MOV R6, #0x90
    MOV R8, R5
    MOV R9, R6
    MOV R4, #0x40
    MOV R5, #0x50
    MOV R6, #0x60
    BL func2

    POP {R4,R5}
    MOV R8, R4          @ restore the R8, R9 values
    MOV R9, R5
    POP {R4,R5,R6,PC}   @ restore PC, plus R4-R6

func2:
    @ this function doesn't call other functions, so we
    @ don't need to push LR, therefore it's more efficient
    @ to return using BX LR, which branches to the contents of LR
    BX LR



