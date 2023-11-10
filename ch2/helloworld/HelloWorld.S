@
@ Assembler program print out "Hello World"
@ using the Pico SDK.
@
@ R0 - first parameter to printf
@ R1 - second parameter to printf
@ R7 - index counter
@
.thumb_func                         @ Necessary because sdk uses BLX
.global main                        @ Provide program start addr to linker

main:
    MOV R7, #0                      @ Initialise counter to 0
    BL stdio_init_all               @ initialise uart or usb
loop:
    LDR R0, =helloworld             @ load address of string
    SUB R7, #1                      @ Decrement counter
    MOV R1, R7                      @ Move the counter to 2nd param
    BL printf                       @ Call pico_printf
    B loop                          @ loop forever

.data
    .align 4                        @ necessary alignment
helloworld:
    .asciz "Hello hex! %x\n"

