   /*
 * Name: Dylan Faulhaber and Jack Patterson
 * Pledge: I pledge my honor that I have abided by the Stevens Honor System
 */

 .text
 .global _start
 _start:

   ADR X0, dot       //saves the address of dot in X0
   ADR X1, vec1      //saves the address of vec1 in X1
   ADR X2, vec2      //saves the address of vec2 in X2

   LDR X10, [X0]     //loads the value of dot into X10

   LDR X3, [X1]      //loads the first vec1 value into X3
   LDR X4, [X2]      //loads the first vec2 value into X2
   MUL X5, X3, X4    //multiplies the first vector values and saves it into X5
   ADD X10, X5, X10  //adds the multiplied value into dot in X10

   LDR X3, [X1, 8]   //loads the second vec1 value into X3
   LDR X4, [X2, 8]   //loads the second vec2 value into X2
   MUL X5, X3, X4    //multiplies the second vector values and saves it into X5
   ADD X10, X5, X10  //adds the multiplied value into dot in X10

   LDR X3, [X1, 16]  //loads the third vec1 value into X3
   LDR X4, [X2, 16]  //loads the third vec2 value into X2
   MUL X5, X3, X4    //multiplies the third vector values and saves it into X5
   ADD X10, X5, X10  //adds the multiplied value into dot in X10

   STR X10, [X0]     //stores the value of dot into its correct memory address

    //Terminate
    MOV X0, 0        // Copy 0 into X0
    MOV X8, 93       // Copy 93 into X8
    SVC 0            // Sys Call

 .data
    vec1:  .quad 10, 20, 30   //vector of values saved as quadwords
    vec2:  .quad 1, 2, 3      //vector of values saved as quadwords
    dot:   .quad 0            //value of dot product saved as quadword 
