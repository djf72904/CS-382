/**
 * Name: Dylan Faulhaber
 * Pledge: I pledge my honor that I have abided by the Stevens Honor System
*/

.text
.global _start

_start:

ADR X0, numstr      //save the address of the numstr string
MOV X1, 0           //save 0 into X1 (length of string)

countBegin:
LDRB W2, [X0, X1]   //save one byte of the string with X1 offset
CBZ W2, countEnd    //check if it is a null terminator. if so then jump to countEnd
ADD X1, X1, 1       //Add one to X1 to count size of string
B countBegin        //jump to beginning of count loop

countEnd:

MOV X8, 0           //set 0 into X8 (offset value)
begin:              
CMP X1, 0           //compare length of string with 0
B.EQ end            //if equal then branch to end since we have gone through the entire string 

MOV X2, X1          //copy X1 into X2
LDRB W5, [X0, X8]   //save one char from string with offset of X8


CMP W5, 48          //compare char with ascii value for 0 (48) 
B.EQ zero           //If equal then jump to zero 
CMP W5, 49          //compare char with ascii value for 1 (49) 
B.EQ one            //If equal then jump to one
CMP W5, 50          //compare char with ascii value for 2 (50)
B.EQ two            //If equal then jump to two
CMP W5, 51          //compare char with ascii value for 3 (51) 
B.EQ three          //If equal then jump to three
CMP W5, 52          //compare char with ascii value for 4 (52) 
B.EQ four           //If equal then jump to four
CMP W5, 53          //compare char with ascii value for 5 (53) 
B.EQ five           //If equal then jump to five
CMP W5, 54          //compare char with ascii value for 6 (54) 
B.EQ six            //If equal then jump to six
CMP W5, 55          //compare char with ascii value for 7 (55) 
B.EQ seven          //If equal then jump to seven
CMP W5, 56          //compare char with ascii value for 8 (56) 
B.EQ eight          //If equal then jump to eight
CMP W5, 57          //compare char with ascii value for 9 (57) 
B.EQ nine           //If equal then jump to nine

zero:
MOV X3, 0           //move 0 to X3
B addBegin          //branch to add begin
one:
MOV X3, 1           //move 1 to X3      
B addBegin          //branch to add begin
two:
MOV X3, 2           //move 2 to X3
B addBegin          //branch to add begin
three:
MOV X3, 3           //move 3 to X3
B addBegin          //branch to add begin
four:
MOV X3, 4           //move 4 to X3
B addBegin          //branch to add begin
five:
MOV X3, 5           //move 5 to X3
B addBegin          //branch to add begin
six:
MOV X3, 6           //move 6 to X3
B addBegin          //branch to add begin
seven:
MOV X3, 7           //move 7 to X3
B addBegin          //branch to add begin
eight:
MOV X3, 8           //move 8 to X3
B addBegin          //branch to add begin
nine:
MOV X3, 9           //move 9 to X3
B addBegin          //branch to add begin

addBegin:       
MOV X4, 1           //move 1 into X (start value of 10)
MOV X6, 10          //move 10 into X6 (multiplier)
SUB X2, X2, 1       //remove one from X2 counter to make number correct length

loopBegin:
CBZ X2, addEnd      //check if X2 is zero. if so branch to addEnd
MUL X4, X4, X6      //multiply X4 by 10
SUB X2, X2, 1       //take one away from X2 counter
B loopBegin         //branch to loopBegin

addEnd:     
MUL X9, X3, X4      //Multiply place value number by X4 (power of 10)
ADD X10, X10, X9    //Add to X10 which is sum value

SUB X1, X1, 1       //sub one from main counter
ADD X8, X8, 1       //add one to offsett
B begin

end:
ADR X11, number     //save the address of number into X11
STR X10, [X11]      //save the final number into number address




/* Do not change any part of the following code */
exit:
    MOV  X0, 1
    ADR  X1, number
    MOV  X2, 8
    MOV  X8, 64
    SVC  0
    MOV  X0, 0
    MOV  X8, 93
    SVC  0
    /* End of the code. */
