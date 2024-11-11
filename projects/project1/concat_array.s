
/*  Name: Dylan Faulhaber
    Pledge: I pledge my honor that I have abided by the Stevens Honor System
 */

.global concat_array

concat_array:
//Allocate Stack
SUB SP, SP, 8        //SUBTRACT 8 FROM STACK POINTER 
STR X30, [SP]        //STORE X30 (RETURN ADDRESS) ON STACK

//Make string of numbers in array
//X0 = long int pointer to first element in array, X1 = length of array
//X10 = copy X0, X11 = copy of X1, X12 = address of out string, 
//X13 = 8 (for offset of long int pointer), X14 = counter for string offset
//X15 = current value, X16 = store counter 

MOV X10, X0          //COPY X0 INTO X10 (ARR POINTER)
MOV X11, X1          //COPY X1 INTO X11 (LEN OF ARRAY)
ADR X12, concat_array_outstr  //SAVE ADDRESS OF OUT STRING TO X12
MOV X13, 0           //OFFEST FOR OUT ARRAY POINTER
MOV X14, 0           //OFFSET FOR OUT STRING 
MOV X15, 0           //SET 0 INTO CURRENT VALUE 

//Clear the out string

clearLoop:
LDRB W15, [X12, X14] //LOAD X15 WITH CHAR IN OUT STRING OF OFFSET X14
CMP W15, 0           //CHECK IF VALUE IN X15 IS NULL CHAR
B.EQ exitClearLoop   //BRANCH OUT OF LOOP IF X15 IS NULL CHAR
STRB WZR, [X12, X14] //IF NOT ZERO THEN MAKE IT ZERO
ADD X14, X14, 1      //ADD ONE TO X14 (OUT STR COUNTER)
B clearLoop          //BRANCH TO BEGINNING OF LOOP 
exitClearLoop:

//Convert the array into string

MOV X14, 0           //RESET OUT STR COUNTER TO 0

convertLoop:
CMP X11, 0           //CHECK IF X11 (ARRAY LENGTH) IS 0
B.EQ exitConvertLoop //IF EQUAL THEN BRANCH OUT OF LOOP
LDR X15, [X10, X13]  //IF NOT THEN CONTIUNE BY LOADING VALUE OF ARRAY OF OFFSET X13 INTO X15

//Call itoascii proc

MOV X0, X15          //MOVE VALUE IN X15 TO X0 TO CALL itoascii PROC
BL itoascii          //CALL itoascii

//X0 is now the address of the string of the int in X15

//Save new acii value into out string

MOV X16, 0           //MOV 0 INTO X16 (STORE COUNTER)
storeLoop:
LDRB W15, [X0, X16]  //LOAD ASCII VALUE OF DIGIT IN CURRENT NUMBER
CMP W15, 0           //CHECK IF W15 HAS NULL CHARACTER
B.EQ exitStoreLoop   //BRANCH OUT OF STORE LOOP IF 0
STRB W15, [X12, X14] //IF NOT THEN STORE ASCII VALUE OF X15 INTO OUT STRING WITH OFFSET OF X14
ADD X16, X16, 1      //ADD 1 TO STORE COUNTER
ADD X14, X14, 1      //ADD 1 TO OUT STRING COUNTER
B storeLoop          //BRANCH TO BEGINNING OF LOOP
exitStoreLoop:

//Add space into out string

MOV X15, 32          //MOVE 32 (ASCII FOR SPACE) INTO X15
STRB W15, [X12, X14] //STORE ASCII VALUE OF X15 INTO OUT STRING WITH OFFSET OF X14

//Clear out ascii string from singular int

MOV X16, 0           //MOV 0 INTO X16 (STORE COUNTER)
clear2Loop:
LDRB W15, [X0, X16]  //LOAD X15 WITH CHAR IN OUT STRING OF OFFSET X16
CMP W15, 0           //CHECK IF VALUE IN X15 IS NULL CHAR
B.EQ exitClear2Loop  //BRANCH OUT OF LOOP IF X15 IS NULL CHAR
STRB WZR, [X0, X16]  //IF NOT ZERO THEN MAKE IT ZERO
ADD X16, X16, 1      //ADD ONE TO X16 (OUT STR COUNTER)
B clear2Loop         //BRANCH TO BEGINNING OF LOOP 
exitClear2Loop:

//Set Counters

SUB X11, X11, 1      //SUBTRACT 1 FROM X11 COUNTER (ARR LENGTH)
ADD X13, X13, 8      //ADD 8 TO X13 COUNTER (ARRAY COUNTER)
ADD X14, X14, 1      //ADD 1 TO X14 COUNTER (OUT STR COUNTER)

B convertLoop        //BRANCH TO BEGINNING OF LOOP
exitConvertLoop:

//Output the out string pointer

MOV X0, X12          //COPY THE OUT STR ADDRESS TO X0 FOR RETURN VALUE

//Deallocate Stack

LDR X30, [SP]        //LOAD VALUE OF X30 (RETURN ADDRESS) ONTO STACK
ADD SP, SP, 8        //ADD 8 TO STACK POINTER

//Return 

RET                  //RETURN BUFFER STRING WITH INT IN ASCII FORM


.data
    /* Put the converted string into concat_array_outstrer,
       and return the address of concat_array_outstr */
    concat_array_outstr:  .fill 1024, 1, 0


