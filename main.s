/*

	Read the (18 bit) integer N stored in the switches,
	compute lucas(N), and display lucas(N) in the 18 red leds.
	
	David John
	February 2015
	
*/

.global  _start

.extern  lucas

_start:


/* display personal HEX logo */

	movia r8,mylogo
	ldw r8,0(r8)
	movia r9,0x10000020 
	stwio r8,0(r9)

/* initialize sp register, needed for store/load in calling convention  */

	movia  sp,0x007ffffc     /*top SRAM  address*/

/* get value of N  (18 bits) from switches  */
	movia  r8,0x10000040     /*address of slider switches*/
	ldwio  r4,0(r8)          /*grab value and place in r4*/
	
	/* call lucas(N)  */
	call   lucas
	
	/* display returned value (18 bits) in red leds  */
	movia  r8,0x10000000     /* address of red leds  */
	stwio  r2,0(r8)
	

stop:
		br stop

.data 

/* Personal logo ("GBH") in HEX */

mylogo:
	.word 0x7D7F7600

.end