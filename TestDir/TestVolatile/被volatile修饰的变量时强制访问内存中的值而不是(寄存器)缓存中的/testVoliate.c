#include <stdio.h>
int main(void)
{
    int b;
    int c;
    volatile int* a = (int*)0x30000000;
    
    b = *a;
    c = *a;
    
    return c + b;
}














