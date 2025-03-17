// C program which embeds assembly language toupper routine inline

#include <stdio.h>
#include <time.h>
#include "pico/stdlib.h"
#define MAX_BUFFSIZE 255

void main() {
    char *str = "This is a test.";
    char outBuf[MAX_BUFFSIZE];
    int len;
    stdio_init_all();
    asm
    (
        "   MOV R0, %1\n"
        "   MOV R4, %2\n"
        "loop:"
        "   LDRB R5, [R0]\n"
        "   ADD R0, #1\n"
        "   CMP R5, #'z'\n"
        "   BGT cont\n"
        "   CMP R5, #'a'\n"
        "   BLT cont\n"
        "   SUB R5, #('a'-'A')\n"
        "cont:"
        "   STRB R5, [%2]\n"
        "   ADD %2, #1\n"
        "   CMP R5, #0\n"
        "   BNE loop\n"
        "   SUB R0, %2, R4\n"
        "   MOV %0, R0\n"
        "   MOV %2, R4\n"
        : "=r"  (len)                   // OutputOperands
        : "r"   (str), "r" (outBuf)     // InputOperands
        : "r4", "r5", "r0"              // Clobbers
    );
    printf("Before str: %s\n", str);
    printf("After str : %s\n", outBuf);
    printf("Str len = %d\n", len);
    for(;;);
}

