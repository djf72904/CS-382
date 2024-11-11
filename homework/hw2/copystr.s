/**
 * Name: Dylan Faulhaber
 * Pledge: I pledge my honor that I have abided by the Stevens Honor System
*/

.text
.global _start

_start:

ADR X0, src_str     //save address of source string to X0
ADR X1, dst_str     //save address of destination string to X1
MOV X2, 0           //save 0 into X2 which will be counter var

begin:
LDRB W3, [X0, X2]   //Load single char of source string to W3
CBZ W3, end         //if it is a null char go to the end of the loop
STRB W3, [X1, X2]   //store the saved char of source string into the destination string
ADD X2, X2, 1       //add one to the counter variable for offset and length of string
B begin             //go to the beginning of the loop

end:
MOV X0, 1           //move 1 into X0
ADD X2, X2, 1       //include null char in size of string being printed
MOV X8, 64          //move 64 into X8
SVC 0               //Sys call to print. length of string is already in X2 and adr of string is in X1

MOV X0, 0           //move 0 int0 X0
MOV X8, 93          //Move 93 into X8
SVC 0               //Sys call to terminate program
