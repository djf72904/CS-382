
/*  Name: Dylan Faulhaber
    Pledge: I pledge my honor that I have abided by the Stevens Honor System
 */

.global pringle


pringle:

//Allocate Stack for return address, params 2-8, and calle-saved regs
//8 bytes needed for return address in X30
//Regs X19-X28 used. 8*9 = 72 bytes needed for sp
//4 pointers + 3 long ints = 4*8 + 3*8 = 32+24 = 56 bytes need to be allocated for params 2-8
//8 + 72 + 56 = 136

SUB SP, SP, 136         //SUBTRACT 128 FROM STACK POINTER 
STR X30, [SP]           //STORE X30 (RETURN ADDRESS) ON STACK
STR X19, [SP, 8]        //STORE X19 (CALLEE-SAVED REG) ON STACK
STR X20, [SP, 16]       //STORE X20 (CALLEE-SAVED REG) ON STACK
STR X21, [SP, 24]       //STORE X21 (CALLEE-SAVED REG) ON STACK
STR X22, [SP, 32]       //STORE X22 (CALLEE-SAVED REG) ON STACK
STR X23, [SP, 40]       //STORE X23 (CALLEE-SAVED REG) ON STACK
STR X24, [SP, 48]       //STORE X24 (CALLEE-SAVED REG) ON STACK
STR X25, [SP, 56]       //STORE X25 (CALLEE-SAVED REG) ON STACK
STR X26, [SP, 64]       //STORE X26 (CALLEE-SAVED REG) ON STACK
STR X27, [SP, 72]       //STORE X27 (CALLEE-SAVED REG) ON STACK
STR X28, [SP, 80]       //STORE X28 (CALLEE-SAVED REG) ON STACK


//Odds are array pointers. Evens are array lengths 

STR X1, [SP, 88]        //STORE FIRST ARRAY POINTER ON STACK
STR X2, [SP, 96]        //STORE FIRST ARRAY LENGTH ON STACK
STR X3, [SP, 104]       //STORE SECOND ARRAY POINTER ON STACK
STR X4, [SP, 112]       //STORE SECOND ARRAY LENGTH ON STACK
STR X5, [SP, 120]       //STORE THIRD ARRAY POINTER ON STACK
STR X6, [SP, 128]       //STORE THIRD ARRAY LENGTH ON STACK 
STR X7, [SP, 136]       //STORE FOURTH ARRAY POINTER ON STACK 

//Count the specifiers in the string

MOV X19, X0             //COPY STRING POINTER TO X19
BL count_specs          //BRANCH TO COUNT_SPECS 
MOV X20, X0             //MOVE THE AMOUNT OF SPECS TO X20. THIS WILL BE A COUNTER

//Add all arrays to the string
//X17 = out string counter, X18 = current value, X19 = param string pointer, X20 = spec counter, 
//X21 = counter for array pointers (starts at [sp, 88] and increases by 16), X22 = counter for length of arrays (starts at [sp, 96] and increases by 16), 
//X23 = current array pointer, X24 = out string address, X25 = current array length, X26 = concat_array string pointer, 
//X27 = concatArray string counter, X28 = param string counter

MOV X17, 0              //INITALIZE OUT STRING COUNTER TO 0
MOV X21, 88             //88 IS THE SP OFFSET FOR FIRST ARRAY POINTER
MOV X22, 96             //96 IS THE SP OFFSET FOR FIRST ARRAY LENGTH
LDR X23, [SP, X21]      //LOAD THE FIRST ARRAY POINTER FROM STACK
ADR X24, outString      //SAVE THE ADDRESS OF THE outString TO X24
LDR X25, [SP, X22]      //LOAD THE FIRST ARRAY LENGTH FROM STACK
MOV X27, 0              //SET CONCAT_ARRAY STRING COUNTER TO 0
MOV X28, 0              //SET THE OUT STRING COUNTER TO 0

//Beginning of loop

editLoop:
CMP X20, 0              //CHECK IF THERE ARE NO SPECS LEFT IN THE STRING
B.EQ finishString       //IF THERE ARE NONE, THEN GO TO PRINT LABEL 
LDR X23, [SP, X21]      //LOAD THE FIRST ARRAY POINTER FROM STACK
LDR X25, [SP, X22]      //LOAD THE FIRST ARRAY LENGTH FROM STACK
MOV X0, X23             //MOVE THE INT ARRAY POINTER TO X0
MOV X1, X25             //MOVE INT ARRAY LENGTH TO X1
BL concat_array         //CALL concat_array PROC
MOV X26, X0             //MOVE RETURN VALUE STRING OF concat_array TO X26
MOV X27, 0              //SET CONCAT_ARRAY STRING COUNTER TO 0

//Find next spec loop

nextSpec:                
LDRB W18, [X19, X28]    //LOAD CHAR FROM PARAM STRING
CMP W18, 37             //CHECK IF CHAR IS A %
B.EQ checkSpec          //IF EQUAL THEN BRANCH TO checkSpec
ADD X28, X28, 1         //ADD ONE TO PARAM STRING COUNTER
STRB W18, [X24, X17]    //SAVE CHAR THAT IS NOT A SPEC INTO CORRECT PLACE IN OUT STR
ADD X17, X17, 1         //ADD ONE TO OUT STRING COUNTER
B nextSpec              //BRANCH TO BEGINNING OF LOOP

//Check if spec is valid 

checkSpec:
ADD X28, X28, 1         //ADD ONE TO PARAM STRING COUNTER
LDRB W18, [X19, X28]    //LOAD NEXT CHAR FROM PARAM STRING
CMP W18, 97             //CHECKS IF CHAR IS a
B.EQ addArray           //IF TRUE THEN BRANCH TO ADD ARRAY
STRB W18, [X24, X17]    //SAVE CHAR THAT IS NOT A SPEC INTO CORRECT PLACE IN OUT STR
ADD X17, X17, 1         //ADD ONE TO OUT STRING COUNTER
B nextSpec              //BRANCH TO BEGINNING OF LOOP 

//Add array to string 

addArray:
LDRB W18, [X26, X27]    //GET CHAR FROM concat_array STRING WITH OFFSET OF X27
CMP W18, 0              //CHECK IF CHAR IS NULL TERM
B.EQ updateCounts       //IF ZERO THEN BRANCH TO UPDATE COUNTS 
STRB W18, [X24, X17]    //SAVE CHAR FROM concat_array STRING TO outString
ADD X27, X27, 1         //ADD ONE TO concat_array STRING COUNTER
ADD X17, X17, 1         //ADD ONE TO outString COUNTER
B addArray              //BRANCH TO BEGINNING OF LOOP

//Update all counter regs

updateCounts:   
ADD X28, X28, 1         //ADD ONE TO PARAM STRING COUNTER
ADD X21, X21, 16        //ADD 16 TO ARRAY POINTERS COUNTER
ADD X22, X22, 16        //ADD 16 TO ARRAY LENGTH COUNTER
SUB X20, X20, 1         //SUBTRACT 1 FROM SPEC COUNTER
B editLoop              //BRANCH TO BEGINNING OF LOOP


finishString:
LDRB W18, [X19, X28]    //LOAD CHAR FROM PARAM STRING INTO W18
CMP W18, 0              //CHECK IF CHAR IS NULL TERM
B.EQ print              //IF SO THEN BRANCH TO PRINT 
STRB W18, [X24, X17]    //IF NOT THEN STORE THAT BYTE INTO outString
ADD X28, X28, 1         //ADD ONE TO PARAM STRING OFFSET
ADD X17, X17, 1         //ADD ONE TO outString OFFSET       
B finishString          //BRANCH TO BEGINNING OF LOOP  
    
print:

MOV X1, X24             //MOVE outString ADDRESS TO X0
MOV X2, 0               //SET OUT STRING COUNTER TO ZERO

countChars:
LDRB W18, [X1, X2]      //LOAD CHAR FROM outString WITH OFFSET OF X17
CMP W18, 0              //CHECK IF NULL TERM
B.EQ finish             //BRANCH TO FINISH 
ADD X2, X2, 1           //ADD ONE TO outString COUNTER
B countChars            //BRANCH TO BEGINNING OF LOOP

finish:
MOV X0, 1               //MOVE 1 INTO X0 FOR PRINTING
MOV X8, 64              //MOVE 64 INTO X8 FOR PRINTING 
SVC 0                   //SYS CALL TO PRINT 

MOV X0, X2              //MOVE LENGTH OF STRING TO X0 FOR RETURN VALUE


//Deallocate stack 
LDR X30, [SP]           //LOAD X30 (RETURN ADDRESS) FROM STACK
LDR X19, [SP, 8]        //LOAD X19 (CALLEE-SAVED REG) FROM STACK
LDR X20, [SP, 16]       //LOAD X20 (CALLEE-SAVED REG) FROM STACK
LDR X21, [SP, 24]       //LOAD X21 (CALLEE-SAVED REG) FROM STACK
LDR X22, [SP, 32]       //LOAD X22 (CALLEE-SAVED REG) FROM STACK
LDR X23, [SP, 40]       //LOAD X23 (CALLEE-SAVED REG) FROM STACK
LDR X24, [SP, 48]       //LOAD X24 (CALLEE-SAVED REG) FROM STACK
LDR X25, [SP, 56]       //LOAD X25 (CALLEE-SAVED REG) FROM STACK
LDR X26, [SP, 64]       //LOAD X26 (CALLEE-SAVED REG) FROM STACK
LDR X27, [SP, 72]       //LOAD X27 (CALLEE-SAVED REG) FROM STACK
LDR X28, [SP, 80]       //LOAD X28 (CALLEE-SAVED REG) FROM STACK

ADD SP, SP, 136          //ADD 136 TO STACK POINTER TO DEALLOCATE 

//Return 

RET                     //RETURN



/*
    Declare .data here if you need.
*/
.data

    outString:  .fill 1024, 1, 0
