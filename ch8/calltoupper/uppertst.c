// C program to call assembly language toupper routine

#include <stdio.h>
#include "pico/stdlib.h"

extern int mytoupper(char *in, char *out);

#define MAX_BUFFSIZE 255

void main() {
    char *str = "This is a test.";
    char outBuf[MAX_BUFFSIZE];
    int len;
    stdio_init_all();
    len = mytoupper(str, outBuf);
    printf("Before str: %s\n", str);
    printf("After str : %s\n", outBuf);
    printf("Str len = %d\n", len);
    for(;;);
}
