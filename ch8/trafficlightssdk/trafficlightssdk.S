@ vi: ft=armv5

@ Assembler program to flash three LEDs connected to GPIO, using the SDK

.EQU LED_RED, 18
.EQU LED_AMBER, 19
.EQU LED_GREEN, 20
.EQU GPIO_OUT, 1
@ sleep times
.EQU short, 500
.EQU long, 2000

.thumb_func

.global main

.macro gpio_out pin
    MOV R0, #\pin
    BL gpio_init
    MOV R0, #\pin
    MOV R1, #GPIO_OUT
    BL link_gpio_set_dir
.endm

.macro gpio_set pin on_off
    MOV R0, #\pin
    MOV R1, #\on_off
    BL link_gpio_put
.endm

.macro sleep time
    LDR R0, =\time
    BL sleep_ms
.endm

main:
    gpio_out LED_RED
    gpio_out LED_AMBER
    gpio_out LED_GREEN
loop:
    gpio_set LED_RED 1
    sleep long
    gpio_set LED_AMBER 1
    sleep short
    gpio_set LED_RED 0
    gpio_set LED_AMBER 0
    gpio_set LED_GREEN 1
    sleep long
    gpio_set LED_GREEN 0
    gpio_set LED_AMBER 1
    sleep short
    gpio_set LED_AMBER 0
    B loop



