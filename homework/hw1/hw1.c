#include <stdio.h>

/*******************************************************************************
* Filename: hw1.c
* Author : Dylan Faulhaber
* Version : 1.0
* Date : 9/23/2023
* Pledge : I pledge my Honor that I have abided by the Stevens Honor System
* In task 3 I used Selection Sort
******************************************************************************/

// Copys a string letter by letter
void copy_str(char* src, char* dst) {
    int i = 0;

    //checks if the string is finished
L1: if(*(src + i) == '\0'){
        goto L2;
    }
    //copys a letter from one string to the other
    dst[i] = *(src+i);
    i++;
    goto L1;

L2: 
    //extra assignment to be sure to get the null terminator 
    dst[i] = *(src+i);      
}

//calculates the dot product of two vectors
int dot_prod(char* vec_a, char* vec_b, int length, int size_elem) {
    
    int sum = 0;
    int i = 0;

    //checks if the vectors are finished
L1: if(i == length){
        goto L2;
    }
    //assigns numbers are does vector math
    int* num1 = (int*)(vec_a + size_elem * i);
    int* num2 = (int*)(vec_b + size_elem * i);
    sum += (*num1) * (*num2);
    i += 1;
    goto L1;

    //returns the dot product sum
L2:  return sum;
}

//sorts the individual nibbles of an array of integers
void sort_nib(int* arr, int length) {
    
    //char array for individual nibbles of the correct size
    int nibsLength = length*8;
    char nibs[nibsLength];

    //assigns one nibble per character in nibs array
    for(int i=0; i<length; i++){
        for(int j=0; j<8; j++){
            nibs[(i*8) + j] = (arr[i] & 0b1111);
            arr[i] >>= 4;
        }
    }

    //selection sort algorithm
    for(int i=0; i<nibsLength-1; i++){
        char min = i;

        for(int j= i+1; j<nibsLength; j++){
            if(nibs[j] < nibs[min]){
                min = j;
            }  
        }

        if(min != i){
                char temp = nibs[min];
                nibs[min] = nibs[i];
                nibs[i] = temp;
            }
    }

    //puts the sorted nibbles back into the integer array as array 
    for(int i=0; i<length; i++){
        arr[i] = 0;
        for(int j=0; j<8; j++){
            arr[i] |= nibs[(i*8) + j];
            if(j<7){
                arr[i] <<= 4;
            }
        }
    }
    

}


int main(int argc, char** argv) {

    /**
     * Task 1
    **/

    char str1[] = "382 is the best!";
    char str2[100] = {0};
    copy_str(str1,str2);
    puts(str1);
    puts(str2);

    /**
     * Task 2
    **/  

    int vec_a[3] = {12, 34, 10};
    int vec_b[3] = {10, 20, 30};
    int dot = dot_prod((char*)vec_a, (char*)vec_b, 3, sizeof(int));
    printf("%d\n",dot);

    /**
     * Task 3
    **/ 
    int arr[3] = {0x12BFDA09, 0x9089CDBA, 0x56788910};
    sort_nib(arr, 3);
    for(int i = 0; i<3; i++) {
        printf("0x%08x ", arr[i]);
    }
    puts(" ");

    return 0;
 
}
