
/*
 * Name: Dylan Faulhaber and Jack Patterson
 * Pledge: I pledge my honor that I have abided by the Stevens Honor System
 */

.text
.global _start 

_start:

    ADR X10, side_a     //Load address of side_a into X10  
    ADR X11, side_b     //Load address of side_b into X11
    ADR X12, side_c     //Load address of side_c into X12

    LDR X10, [X10]      //Load value of X10 (side_a) back into X10
    LDR X11, [X11]      //Load value of X11 (side_b) back into X11
    LDR X12, [X12]      //Load value of X12 (side_c) back into X12

    MUL X13, X10, X10   //Multiply X10 (side_a) by itself and save into X13
    MUL X14, X11, X11   //Multiply X11 (side_b) by itself and save into X14
    MUL X15, X12, X12   //Multiply X12 (side_c) by itself and save into X15
    ADD X16, X13, X14   //Add X13 (a^2) and X14 (b^2) and save into X16

    CMP X16, X15        //Compare X16 (a^2 + b^2) and X15 (c^2)
    B.EQ Equal          //Jump to the Equal label if CMP is equal

    MOV X0, 1           //Copy 1 into X0
    ADR X1, no          //Copy address of no into X1
    ADR X2, len_no      //Copy address of len_no int X2
    LDR X2, [X2]        //Load value of X2 (len_no) into the register X2
    MOV X8, 64          //Copy 64 into X8            
    SVC 0               //Sys call
    B End               //Branches to end of program

Equal:
    MOV X0, 1           //Copy 1 into X0
    ADR X1, yes         //Copy address of yes into X1
    ADR X2, len_yes     //Copy address of len_yes int X2
    LDR X2, [X2]        //Load value of X2 (len_yes) into the register X2
    MOV X8, 64          //Copy 64 into X8
    SVC 0               //Sys call


End:
    //Terminate
    MOV X0, 0       // Copy 0 into X0
    MOV X8, 93      // Copy 93 into X8
    SVC 0           // Sys Call
    
.data
    side_a: .quad 3                             //One side of triangle
    side_b: .quad 4                             //Second side of triangle
    side_c: .quad 5                             //Third and longest side of triangle
    yes: .string "It is a right triangle.\n"    //Message that is printed if there is a right triangle
    len_yes: .quad 24                           //Length of string yes
    no: .string "It is not a right triangle.\n" //Message that is printed if there is not a right triangle 
    len_no: .quad 28                            //Length of string no
