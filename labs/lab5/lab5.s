/**************************************************************************
* Name: Dylan Faulhaber
* Date: 10/17/23
* Pledge: I pledge my honor that I have abided by the Stevens Honor System
 **************************************************************************/


.text
.global _start
.extern printf


/* char _uppercase(char lower) */
_uppercase:
    SUB sp, sp, 8       //Allocate stack pointer
    STR X30, [sp]       //Save return address

    SUB W0, W0, 32      //Turn lowercase letter into uppercase by subtracting 32

    LDR X30, [sp]       //Load return address
    ADD sp, sp, 8       //Deallocate stack pointer
    RET                 //return 


/* int _toupper(char* string) */
_toupper:

    SUB sp, sp, 8       //Allocate stack pointer   
    STR X30, [sp]       //Save return address

    MOV X10, 0          //Put 0 into register 10
    MOV X1, X0          //Put the string in X0 into X1
begin:
    LDRB W0, [X1, X10]  //load the first character of the lower case string into W0
    CBZ W0, end         //check if it is null terminator
    BL _uppercase       //branch to _uppercase procedure 
    STRB W0, [X1, X10]  //store new uppercase letter into string in X1
    ADD X10, X10, 1     //Add 1 to X10 which is the counter
    B begin             //go back to begin label for loop
end:
    MOV X0, X10         //Move the count variable into X0 for return value

    LDR X30, [sp]       //Load return address
    ADD sp, sp, 8       //Deallocate stack pointer
    RET                 //return 
 

_start:

    ADR X0, str         //Load address of string into X0
    BL _toupper         //call _toupper procedure with str
    
    MOV X2, X1          //Move the uppercase string into X2 as third paramater
    MOV X1, X0          //Move the counter into X1 as second parameter
    ADR X0, outstr      //load the address of outstr as first parameter

    BL printf           //printf from c

    MOV  X0, 0          //copy 0 into X0
    MOV  X8, 93         //copy 93 into X8
    SVC  0              //sys call


.data
str:    .string   "helloworld" //string to be converted
outstr: .string   "Converted %ld characters: %s\n"  //output string 
