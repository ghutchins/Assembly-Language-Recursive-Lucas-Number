/* NOIS II Recursive Lucas Program */
/* Georgina Hutchins 02/22/15 */

.global lucas
.text	

lucas:
	beq r4,r0,case0		/*base case: if(N==0) branch to 			case0*/
	addi r16,r0,1		/*store value 1 in r16*/
	beq r4,r16,case1	/*base case: if(N==1) branch to 			case1*/

/* save values from 4 calling routine registers to memory and offset the stack pointer */
	subi sp,sp,12		/*offset sp by 12 to save 3 regstrs*/
	stw ra,0(sp)		/*save return address*/
	stw r4,4(sp)		/*save r4 (N) in memory */

/* recurse -> call lucas for N-1 and N-2 */
	subi r4,r4,1		/*store N-1 in r4*/
	call lucas			/*lucas(N-1)*/

	stw r2,8(sp)	/*save temp answer in memory*/

	subi r4,r4,1		/*set r4 to N-2*/
	call lucas			/*lucas(N-2)*/
	
	ldw r18,8(sp)		/*load temp answer from mem. to r18*/

	add r2,r2,r18		/*store final sum in r2 (add 				lucas(N-1)+lucas(N-2) into r2)*/
	br done			/*branch to done--restore registers*/

/* branch here if N == 0 */	
	case0:
		addi r2,r0,2	/*store a 2 in r2 and return*/
		ret
/* branch here if N == 1 */
	case1:
		addi r2,r0,1	/*store a 1 in r2 and return*/
		ret
/* branch to restore registers and return */
done:
	ldw ra,0(sp)
	ldw r4,4(sp)
	addi sp,sp,12		/*return sp to original position*/
	ret
