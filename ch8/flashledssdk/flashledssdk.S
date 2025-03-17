@ vi: ft=armv5

@ Assembler program to flash three LEDs connected to GPIO, using the SDK

.EQU LED_PIN1, 18
.EQU LED_PIN2, 19
.EQU LED_PIN3, 20
.EQU GPIO_OUT, 1
.EQU sleep_time, 200

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

.macro sleep
    LDR R0, =sleep_time
    BL sleep_ms
.endm

main:
    gpio_out LED_PIN1
    gpio_out LED_PIN2
    gpio_out LED_PIN3
loop:
    gpio_set LED_PIN1 1
    sleep
    gpio_set LED_PIN1 0
    gpio_set LED_PIN2 1
    sleep
    gpio_set LED_PIN2 0
    gpio_set LED_PIN3 1
    sleep
    gpio_set LED_PIN3 0
    B loop



