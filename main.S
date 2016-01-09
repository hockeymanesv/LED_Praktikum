.extern sleep			/* external function for sleeping */
.extern map_peripheral	/* external function for mapping the GPIO peripherals */
.extern initialisieren	/* Initialisierungsprogramm */
.extern abtasten		/* programm fuer tasterbeteatigung */
.equ GPIO_rot, 17		/* The GREEN LED is connected to GPIO_PIN 47 on the PI+ plattforms */
.equ GPIO_gelb, 18
.equ GPIO_gruen, 27
.equ GPIO_tast, 25
.text
.balign 4
.global main
.global losfahren
.global anhalten
.func main

main:
	/* Step 1: save registers and return address */
	push {r4-r11, lr}

	bl init // GPIO Pins in Unterprogramm initialisieren, Sprung aber falsch

losfahren:


	mov r0, #1 // Schlafzeit setzen hier 1s

	/* Setzen des Set Registers und damit aktivieren der LEDs */
	mov r3, #(1 << (GPIO_rot%32))
	str r3, [r9, #(4*(7 + (GPIO_rot/32)))]
	bl sleep

	mov r3, #(1 << (GPIO_gelb%32))
	str r3, [r9, #(4*(7 + (GPIO_gelb/32)))]
	bl sleep

	mov r3, #(1 << (GPIO_gruen%32))
	str r3, [r9, #(4*(7 + (GPIO_gruen/32)))]
	bl sleep

	/* LEDs wieder clearen --> ausschalten */
	mov r3, #(1 << (GPIO_rot%32))
	str r3, [r9, #(4*(10 + (GPIO_rot/32)))]
	mov r3, #(1 << (GPIO_gelb%32))
	str r3, [r9, #(4*(10 + (GPIO_gelb/32)))]
	mov r3, #(1 << (GPIO_gruen%32))
	str r3, [r9, #(4*(10 + (GPIO_gruen/32)))]

	orr r5, r6 //Event Detect Status wieder clearen an 25. Stelle 1 setzen --> Detect Status wird 0

	bl tast2

anhalten:
	mov r0, #2 // Schlafzeit setzen hier 1s

	/* Setzen des Set Registers und damit aktivieren der LEDs */
	mov r3, #(1 << (GPIO_rot%32))
	str r3, [r9, #(4*(7 + (GPIO_rot/32)))]
	bl sleep

	mov r3, #(1 << (GPIO_gelb%32))
	str r3, [r9, #(4*(7 + (GPIO_gelb/32)))]
	bl sleep

	mov r3, #(1 << (GPIO_gruen%32))
	str r3, [r9, #(4*(7 + (GPIO_gruen/32)))]
	bl sleep



	/* Step 4.2: CLEAR LED 47 for a second. Every 1 in the GPSCLR0/1 register clears the according pin, zeros are ignored */
	mov r3, #(1 << (GPIO_rot%32))
	str r3, [r9, #(4*(10 + (GPIO_rot/32)))]
	mov r3, #(1 << (GPIO_gelb%32))
	str r3, [r9, #(4*(10 + (GPIO_gelb/32)))]
	mov r3, #(1 << (GPIO_gruen%32))
	str r3, [r9, #(4*(10 + (GPIO_gruen/32)))]


	/* Step 5: restore registers and return by popping the saved lr to pc */
end_main:
	mov r0, #0							/* this is our return code by convention */
	pop {r4-r11, pc}
