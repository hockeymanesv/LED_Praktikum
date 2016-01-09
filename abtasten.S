.extern map_peripheral	/* external function for mapping the GPIO peripherals */
.extern main
.equ GPIO_rot, 17		/* The GREEN LED is connected to GPIO_PIN 47 on the PI+ plattforms */
.equ GPIO_gelb, 18
.equ GPIO_gruen, 27
.equ GPIO_tast, 25
.text
.balign 4
.global tast1
.global tast2
.func tast1
/* Abtasten */
tast1:
/* benutze Rising Edge */
ldr r5, [r9, #(4*(19 + (GPIO_tast/32)))]		/* read GPREN0 to R5 */
mov r6, #0x2000000
and r5, r6 // mit 2^25 verunden
cmp r5, r6
beq losfahren
bal tast1

tast2:
ldr r5, [r9, #(4*(19 + (GPIO_tast/32)))]		/* read GPREN0 to R5 */
mov r6, #0x2000000
and r5, r6 // mit 2^25 verunden
cmp r5, r6
beq anhalten
bal tast2


// Rückspung einfügen
