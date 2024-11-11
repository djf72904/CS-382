    
/*
 * Name: Dylan Faulhaber and Jack Patterson
 * Pledge: I pledge my honor that I have abided by the Stevens Honor System
 */

.text
.global _start
.extern scanf

_start:
    
    ADR   X0, fmt_str   // Load address of formated string
    ADR   X1, left      // Load &left
    ADR   X2, right     // Load &right
    ADR   X3, target    // Load &target
    BL    scanf         // scanf("%ld %ld %ld", &left, &right, &target);

    ADR   X1, left      // Load &left
    LDR   X1, [X1]      // Store left in X1
    ADR   X2, right     // Load &right
    LDR   X2, [X2]      // Store right in X2
    ADR   X3, target    // Load &target
    LDR   X3, [X3]      // Store target in X3

//Lower Check
    CMP X3, X1          //Compare X3 (target) and X1 (left)
    B.LE Outside        //Jump to Outside label if target is less than the left bound and outside the range

//Upper Check
    CMP X3, X2          //Compare X3 (target) and X2 (right)
    B.GE Outside        //Jump to Outside label if target is greater than the right bound and outside the range

    MOV X0, 1           //Copy 1 into X0
    ADR X1, yes         //Copy address of yes into X1
    ADR X2, len_yes     //Copy address of len_yes int X2
    LDR X2, [X2]        //Load value of X2 (len_yes) into the register X2
    MOV X8, 64          //Copy 64 into X8  
    SVC 0               //Sys call
    B exit              //Branches to the exit

Outside:
    MOV X0, 1           //Copy 1 into X0
    ADR X1, no          //Copy address of no into X1
    ADR X2, len_no      //Copy address of len_no int X2
    LDR X2, [X2]        //Load value of X2 (len_no) into the register X2
    MOV X8, 64          //Copy 64 into X8  
    SVC 0               //Sys call

exit:
    MOV   X0, 0        // Pass 0 to exit()
    MOV   X8, 93       // Move syscall number 93 (exit) to X8
    SVC   0            // Invoke syscall

.data
    left:    .quad     0                            //Left bound
    right:   .quad     0                            //Right bound
    target:  .quad     0                            //Target num
    fmt_str: .string   "%ld%ld%ld"                  //String formatter
    yes:     .string   "Target is in range\n"       //Message that is printed if target is in range
    len_yes: .quad     19                           //Length of string yes
    no:      .string   "Target is not in range\n"   //Message that is printed if target is not in range
    len_no:  .quad     23                           //Length of string no
