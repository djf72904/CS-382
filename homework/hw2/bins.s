/**
 * Name: Dylan Faulhaber 
 * Pledge: I pledge my honor that I have abided by the Stevens Honor System
*/


.text
.global _start

_start:

ADR X0, arr         //save address of array into X0
ADR X1, length      //save address of length into X1    
LDR X1, [X1]        //save value of X1 into X1 (length)
ADR X2, target      //save address of target into X2    
LDR X2, [X2]        //save value of X2 into X2 (target)
MOV X3, 0           //move 0 into X3 (left bound index)    
MOV X5, X1          //move length into X1 (right bound)    
SUB X5, X5, 1       //subtract one from X5 (right bound index)    
MOV X10, 2          //move 2 into X10 (division by 2)    
MOV X11, 8          //move 8 into X11 (size of quadword)    

begin:
CMP X3, X5          //Compare left and right bound  
B.GT noSolution     //if left bound > right bound then jump to noSolution
SUB X4, X5, X3      //save difference of bounds into X4    
SDIV X4, X4, X10    //divide difference by 2
ADD X4, X3, X4      //add difference to left bound
MUL X9, X4, X11     //multiply index by 8 for array index    
LDR X6, [X0, X9]    //load value of array at desired index    

CMP X6, X2          //compare target with array value we are checking
B.EQ end            //if they are the same jump to end since value is found 
B.LT less           //if the target is greater then jump to less    
B.GT greater        //if target is less than jump to greater    

less:               // TARGET > ARR
ADD X3, X4, 1       //make the left bound the index being checked + 1
B begin             //go back to beginning of loop

greater:            //TARGET < ARR
SUB X5, X4, 1       //make the right bound the index being checked - 1
B begin             //go back to beginning of loop

end:
MOV X0, 1           //move 1 into X0
ADR X1, msg1        //move address of msg1 into X1
MOV X2, 24          //move 24 into X2 which is length of string
MOV X8, 64          //move 64 into X8
SVC 0               //Sys call to print
B term              //jump to term for program termination

noSolution:
MOV X0, 1           //move 1 into X0
ADR X1, msg2        //move address of msg2 inro X2
MOV X2, 28          //move 28 into X2 which is length of string
MOV X8, 64          //move 64 into X8
SVC 0               //Sys call to print

term:
MOV X0, 0           //move 0 int0 X0
MOV X8, 93          //Move 93 into X8
SVC 0               //sys call to terminate programs
