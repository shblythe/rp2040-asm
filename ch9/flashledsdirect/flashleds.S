@ vi: ft=armv5

@ Assember program to flash three LEDs by writing to registers directly
@
@ The SDK is used only for the delays

#include "hardware/regs/addressmap.h"
#include "hardware/regs/sio.h"
#include "hardware/regs/io_bank0.h"
#include "hardware/regs/pads_bank0.h"

.EQU LED_PIN1, 18
.EQU LED_PIN2, 19
.EQU LED_PIN3, 20
.EQU sleep_time, 200

.thumb_func
.global main

.align 4

main:
    @ Initialise each pin and set to output
    MOV R0, #LED_PIN1
    BL gpioinit
    MOV R0, #LED_PIN2
    BL gpioinit
    MOV R0, #LED_PIN3
    BL gpioinit
loop:
    @ Turn each pin on, sleep, then turn it off
    MOV R0, #LED_PIN1
    BL gpio_on
    LDR R0, =sleep_time
    BL sleep_ms
    MOV R0, #LED_PIN1
    BL gpio_off
    MOV R0, #LED_PIN2
    BL gpio_on
    LDR R0, =sleep_time
    BL sleep_ms
    MOV R0, #LED_PIN2
    BL gpio_off
    MOV R0, #LED_PIN3
    BL gpio_on
    LDR R0, =sleep_time
    BL sleep_ms
    MOV R0, #LED_PIN3
    BL gpio_off
    B loop

@ Initialise the GPIO to SIO.
@ r0 = pin to init
gpioinit:
    @ Initialise the internal GPIO pin using SIO
    MOV R3, #1
    LSL R3, R0          @ Shift over to pin position
    LDR R2, gpiobase    @ address we want
    STR R3, [R2, #SIO_GPIO_OE_SET_OFFSET]   @ set output enable for the pin
    STR R3, [R2, #SIO_GPIO_OUT_CLR_OFFSET]  @ set the pin to off

    @ Enable input and output for the external pin.
    @ This enables the physical connections with the GPIO pads,
    @ connecting the internal GPIO pin to the outside world.
    LDR R2, padsbank0
    LSL R3, R0, #2  @ pin * 4 for register address
    ADD R2, R3      @ actual set of regs for this pin
    MOV R1, #PADS_BANK0_GPIO0_IE_BITS
    LDR R4, setoffset
    ORR R2, R4
    STR R1, [R2, #PADS_BANK0_GPIO0_OFFSET]

    @ Set the function number to SIO
    @ This connects the internal GPIO pin to the SIO - single-cycle software control of I/O
    LSL R0, #3      @ each GPIO has 8 bytes of regs
    LDR R2, iobank0 @ address we want
    ADD R2, R0      @ add the offset for pin number
    MOV R1, #IO_BANK0_GPIO3_CTRL_FUNCSEL_VALUE_SIO_3
    STR R1, [R2, #IO_BANK0_GPIO0_CTRL_OFFSET]

    BX LR

@ Turn on a GPIO pin
gpio_on:
    MOV R3, #1
    LSL R3, R0          @ shift over to pin position
    LDR R2, gpiobase    @ address we want
    STR R3, [R2, #SIO_GPIO_OUT_SET_OFFSET]
    BX LR

gpio_off:
    MOV R3, #1
    LSL R3, R0          @ shift over to pin position
    LDR R2, gpiobase    @ address we want
    STR R3, [R2, #SIO_GPIO_OUT_CLR_OFFSET]
    BX LR

.align 4
gpiobase:   .word   SIO_BASE            @ Base of the GPIO registers
iobank0:    .word   IO_BANK0_BASE       @ base of I/O config regs
padsbank0:  .word   PADS_BANK0_BASE
setoffset:  .word   REG_ALIAS_SET_BITS

