.extern map_peripheral	/* external function for mapping the GPIO peripherals */
.extern abstasten
.extern main
.equ GPIO_rot, 17		/* The GREEN LED is connected to GPIO_PIN 47 on the PI+ plattforms */
.equ GPIO_gelb, 18
.equ GPIO_gruen, 27
.equ GPIO_tast, 25
.text
.balign 4
.global init
.func init
/* Initialisierung LEDs */
init:
	/* Step 2: map_peripheral returns the base address of the GPIO registers in r0 */
	bl map_peripheral
	mov r9, r0 //Basisadresse von GPIO in R9

	/* Step 3: set GPIO LED to output by manipulating the GPFSEL-register
	 * with a read-modify-write pattern. Each 32bit-GPFSEL-Register contains 10 pins, so
	 * the address of the register is simply calculated as BASE + 4 * (PinNumber/10).
	 * The Function Select of each pin is 3 bits wide (000=Input, 001=Output), that is
	 * bits 21-23 hold the mode of the x-7th pin (see BCM2835 ARM peripherals datasheet, page 89 ff.) */


	/* LEDs initialisieren auf Output */
	ldr r3, [r9, #(4 * (GPIO_rot/10))]		/* read GPFSEL4 to R3 */
	and r3, #~(7 << ((GPIO_rot%10)*3))		/* set bits 21-23 to 000, i.e. set pin as input */
	str r3, [r9, #(4 * (GPIO_rot/10))]		/* do we really need this intermediate write to GPFSEL4? */
	orr r3, #(1 << ((GPIO_rot%10)*3))		/* set bits 21-23 to 001, i.e. set pin as output */
	str r3, [r9, #(4 * (GPIO_rot/10))]		/* write R3 to GPFSEL4 */

	ldr r3, [r9, #(4 * (GPIO_gelb/10))]		/* read GPFSEL4 to R3 */
	and r3, #~(7 << ((GPIO_gelb%10)*3))		/* set bits 21-23 to 000, i.e. set pin as input */
	str r3, [r9, #(4 * (GPIO_gelb/10))]		/* do we really need this intermediate write to GPFSEL4? */
	orr r3, #(1 << ((GPIO_gelb%10)*3))		/* set bits 21-23 to 001, i.e. set pin as output */
	str r3, [r9, #(4 * (GPIO_gelb/10))]		/* write R3 to GPFSEL4 */

	ldr r3, [r9, #(4 * (GPIO_gruen/10))]	/* read GPFSEL4 to R3 */
	and r3, #~(7 << ((GPIO_gruen%10)*3))	/* set bits 21-23 to 000, i.e. set pin as input */
	str r3, [r9, #(4 * (GPIO_gruen/10))]	/* do we really need this intermediate write to GPFSEL4? */
	orr r3, #(1 << ((GPIO_gruen%10)*3))		/* set bits 21-23 to 001, i.e. set pin as output */
	str r3, [r9, #(4 * (GPIO_gruen/10))]	/* write R3 to GPFSEL4 */

	/* Schalter initialisieren aber auf Input */
	ldr r3, [r9, #(4 * (GPIO_tast/10))]		/* read GPFSEL4 to R3 */
	and r3, #~(7 << ((GPIO_tast%10)*3))		/* set bits 21-23 to 000, i.e. set pin as input */
	str r3, [r9, #(4 * (GPIO_tast/10))]		/* do we really need this intermediate write to GPFSEL4? */


	/* RisingEdge Register für GPIO25 aktivieren */
	ldr r3, [r9, #(4*(19 + (GPIO_tast/32)))]
	orr r3, #(1 << GPIO_tast) 				/* shiften 1 an 25. stelle*/
	str r3, [r9, #(4*(19 + (GPIO_tast/32)))]


	bl tast1 // zum abtasten springen

// Hier muss noch ein Ruecksprung eingefuegt werden
