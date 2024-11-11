
/*  Name: Dylan Faulhaber
    Pledge: I pledge my honor that I have abided by the Stevens Honor System
 */

.global count_specs

count_specs:
//Allocate Stack
SUB SP, SP, 8        //SUBTRACT 8 FROM STACK POINTER 
STR X30, [SP]        //STORE X30 (RETURN ADDRESS) ON STACK


//Go through string counting specs
//X0 = counter of specs, X1 = address of string, X2 = string offset
//X3 = current value
//37 = ASCII for '%', 97 = ASCII for 'a'

MOV X1, X0          //COPY VALUE OF X0 INTO X1 (ADDRESS OF STRING)
MOV X0, 0           //SET COUNTER TO 0 
MOV X2, 0           //SET STRING OFFSET TO 0
MOV X3, 0

//Loop through each char of string 

stringLoop:
LDRB W3, [X1, X2]   //LOAD CHAR OF OFFSET X2 FROM X1 (STRING) INTO W3
CMP W3, 0           //CHECK IF CHAR IS NULL CHAR
B.EQ exitStringLoop //IF EQUAL THEN BRANCH OUT OF LOOP
CMP W3, 37          //COMPARE VALUE IN W3 TO 37 (%)
B.EQ checkA         //IF EQUAL THEN BRANCH TO checkA
ADD X2, X2, 1       //ADD ONE TO STRING COUNTER IN X2
B stringLoop        //BRANCH TO BEGINNING OF LOOP

//If current char is '%' then check if next is 'a'

checkA:
ADD X2, X2, 1       //ADD ONE TO COUNTER FOR NEXT CHAR
LDRB W3, [X1, X2]   //LOAD CHAR OF OFFSET X2 FROM X1 (STRING) INTO W3
CMP W3, 0           //CHECK VALUE IN W3 IS NULL CHAR
B.EQ exitStringLoop //IF SO THEN EXIT LOOP
CMP W3, 97          //IF NOT THEN CHECK IF CHAR IN W3 IS EQUAL TO 97 (a)
B.EQ updateCount    //IF THEY ARE EQUAL THEN BRANCH TO updateCount
ADD X2, X2, 1       //IF NOT THEN ADD ONE TO OFFSET
B stringLoop        //BRANCH TO BEGINNING OF LOOP

//Update counter if there is a spec

updateCount:
ADD X0, X0, 1       //ADD ONE TO SPEC COUNTER
B stringLoop        //BRANCH TO BEGINNING OF LOOP

exitStringLoop:

//Deallocate Stack

LDR X30, [SP]        //LOAD VALUE OF X30 (RETURN ADDRESS) ONTO STACK
ADD SP, SP, 8        //ADD 8 TO STACK POINTER

//Return 

RET                  //RETURN BUFFER STRING WITH INT IN ASCII FORM

/*
    Declare .data here if you need.
*/

