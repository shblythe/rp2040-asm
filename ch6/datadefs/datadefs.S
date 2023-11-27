@ vi: ft=armv5
.thumb_func
.global main

main:
    @ make sure they're kept, not optimised out
    LDR R0, =aas
    b main


.align 4
.data

aas: .fill 10, 1, 0xaa
bytes:
.byte 10, 0x4a, 'S', 042, 42, 0, -33, ~0b00111001, 9
.align 2
ascii:
.ascii "Not null-terminated"
.ascii "Null-terminated!"
.align 4
double_pi_ish:
.double 3.14159265
float_not_pi:
.float 3.14
.align 4
quad:
.quad   0x123456789abcdef0
.align 4
oct:
.octa   0x112233445566778899aabbccddeeff00
short:
.short  0x1234
.align 4
word:
.word   0x12345678
repeated_byte_sequences:
.align 3
.rept 3
.byte 0, 1, 2
.endr

