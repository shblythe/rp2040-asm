@ vi: ft=armv5

.thumb_func
.global main

main:
    MOV R7, #3
loop:

    @ select case, 1, 2, default
    CMP R7, #1
    BNE not1
    @ case 1
    MOV R0, #0x11
    B case_done
not1:
    CMP R7, #2
    BNE not2
    @ case 2
    MOV R0, #0x22
    B case_done
not2:
    @default
    MOV R0, #0xff
case_done:

    SUB R7, #1
    BNE loop

end:    B end

