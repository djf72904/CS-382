/*******************************************************************************
* Filename: lab1.cpp
* Author : Dylan Faulhaber and Jack Patterson
* Version : 1.0
* Date : 9/12/2023
* Description: Displays a binary number after manipulating it 
* Pledge : I pledge my Honor that I have abided by the Stevens Honor System
******************************************************************************/

#include <stdio.h>
#include <stdlib.h>

void display(int8_t bit) {
putchar(bit + 48);
}

void display_32(int32_t num) {
    int binary[32];

    int count = 0;

L1: if(count < 32){
        binary[count] = num & 1;
        num = num >> 1;
        count++;
        goto L1;
    }

    else{
        int i = 31;

L2:     if(i>=0){
        display(binary[i]);
        i--;
        goto L2;
    }  
    else{
        printf("\n");
    } 
    }
}

int main(int argc, char const *argv[]) {
display_32(382);
return 0;
}