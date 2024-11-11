/*  
    Name: Dylan Faulhaber
    Pledge: I pledge my honor that I have abided by the Stevens Honor System 
 */

.global itoascii

itoascii:
//Allocate Stack
SUB SP, SP, 8        //SUBTRACT 8 FROM STACK POINTER 
STR X30, [SP]        //STORE X30 (RETURN ADDRESS) ON STACK


//Find the num of digits in integer
// X1 = long int, X2 = 10, X3 = counter

MOV X1, X0           //COPY INT PARAM INTO X1
MOV X2, 10           //LOAD 10 INTO X2 FOR DIVISON 
MOV X3, 0            //LOAD 0 INTO X3 FOR COUNTER

CBZ X1, zeroCase     //BRANCH TO ZERO CASE IF INT PARAM IS 0

//Count digits of int parameter

counterLoop:
CMP X1, 0            //CHECK IF INT IS ZERO 
B.EQ exitCounterLoop //IF ZERO THEN EXIT LOOP
ADD X3, X3, 1        //ADD ONE TO COUNTER
UDIV X1, X1, X2      //DIVIDE INT BY 10 TO REMOVE PLACE VALUE
B counterLoop        //BRANCH TO BEGINNING OF LOOP
exitCounterLoop:

//Find the ascii value of each digit and add to buffer
//X0 = adr of buffer, X1 = long int, X2 = 10, X3 = counter (digits in X1)
//X4 = copy of counter (for MSD), X5 = number being reduced, X6 = ascii of digit,
//X7 = number being extended for addition, X8 = offset for storing string 

MOV X1, X0           //COPY INT PARAM INTO X1
ADR X0, buffer       //SAVE THE ADDRESS OF buffer INTO X0
MOV X4, X3           //COPY COUNTER (DIGITS) OF X3 INTO X4
MOV X5, 0            //SAVE 0 INTO X5 TO ZERO OUT
MOV X8, 0            //SAVE 0 (STR OFFSETT) INTO X8

calcLoop:
MOV X4, X3           //COPY COUNTER (DIGITS) OF X3 INTO X4
MOV X5, X1           //COPY CURRENT INT IN X1 INTO X5 (VALUE REG)
CMP X3, 0            //CHECK IF INT IN X3 IS 0
B.EQ exitCalcLoop    //IF ZERO THEN EXIT ENTIRE LOOP

//Reduce int to MSD

reduceLoop:
CMP X4, 1            //CHECK IF MSD COUNTER IS 1
B.EQ exitReduceLoop  //IF 1 THEN DONE REDUCING AND EXIT LOOP
UDIV X5, X5, X2      //DIVIDE X5 VALUE BY 10 TO REMOVE PLACE VALUE
SUB X4, X4, 1        //SUBTRACT ONE TO MSD COUNTER
B reduceLoop         //BRANCH TO BEGINNING OF LOOP
exitReduceLoop:

//Calculate ascii value

ADD X6, X5, 48       //ADD 48 TO NUMBER IN X5 TO FIND ASCII VALUE AND SAVE INTO X6
MOV X4, X3           //COPY COUNTER OF X3 INTO X4 FOR REXTENSION
MOV X7, 1            //SET 1 INTO X7 FOR EXTENSION

//Extend number back to full length

extendLoop:
CMP X4, 1            //CHECK IF COUNTER IN X4 IS 1
B.EQ exitExtendLoop  //IF EQUAL TO 1 THEN EXIT LOOP
MUL X7, X7, X2       //MULTIPLY X7 VALUE BY 10
SUB X4, X4, 1        //SUB 1 FROM X4 COUNTER
B extendLoop         //BRANCH TO BEGINNING OF LOOP
exitExtendLoop:

//Reduce size of number 

MUL X5, X5, X7       //MULTIPLY SINGLE DIGIT INT IN X5 BY X7 TO GET NUMBER TO SUBTRACT
SUB X1, X1, X5       //ELIMINATE MSD FROM X1 INT

SUB X3, X3, 1        //REDUCE X3 BY 1 (AMOUNT OF DIGITS IN X1)

//Store ascii into buffer

STRB W6, [X0, X8]    //STORE ASCII VALUE INTO BUFFER STRING WITH OFFSETT 8
ADD X8, X8, 1        //ADD 1 TO STRING OFFSET

B calcLoop           //BRANCH TO BEGINNING OF LOOP
exitCalcLoop:
B deallocate         //BRANCH TO STACK DEALLOCATION

zeroCase:
MOV X6, 48           //MOVE ASCII VALUE OF 0 INTO X6
ADR X0, buffer       //SAVE THE ADDRESS OF buffer INTO X0
STRB W6, [X0]        //STORE ASCII VALUE OF W6 INTO BUFFER STRING

//Deallocate Stack

deallocate:
LDR X30, [SP]        //LOAD VALUE OF X30 (RETURN ADDRESS) ONTO STACK
ADD SP, SP, 8        //ADD 8 TO STACK POINTER

//Return 

RET                  //RETURN BUFFER STRING WITH INT IN ASCII FORM

.data
    /* Put the converted string into buffer,
       and return the address of buffer */
    buffer: .fill 128, 1, 0

