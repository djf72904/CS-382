/*
 * Name: Dylan Faulhaber
 * Pledge: I pledge my honor that I have abided by the Stevens Honor System
 */


.text
.global _start
_start:
    //Print
    MOV X0, 1       // Copy 1 into X0
    ADR X1, msg     // Copy address of msg into X1
    ADR X2, len     // Copy address of len into X2
    LDR X2, [X2]    // Load value of X2 into the register X2
    MOV X8, 64      // Copy 64 into X8
    SVC 0           // Sys call 

    //Terminate
    MOV X0, 0       // Copy 0 into X0
    MOV X8, 93      // Copy 93 into X8
    SVC 0           // Sys Call

.data
    msg: .string "Hello World!\n" // Saves the string "Hello World" into msg
    len: .quad 14                 // Saves the number 14 into len of size quadword
