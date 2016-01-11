.text
.balign 4
.equ PIN_YELLOW, 7
.equ PIN_GREEN, 25
.equ PIN_RED, 8
.equ PIN_IN, 10
.global forwards
.func forwards

/* fuer vorwaerts wird an die stelle im Set register eine 1 geschrieben
* dann 1sek schlafen
* dann in clear 1 --> damit wird set register geloescht
* fuer alle LEDs ausfuehren
 */
forwards:
	push {lr}
	mov r3, #(1 << (PIN_RED%32))
	str r3, [r9, #(4*(7 + (PIN_RED/32)))]
	mov r0, #1
	bl sleep //schlafen
	mov r3, #(1 << (PIN_RED%32))
	str r3, [r9, #(4*(10 + (PIN_RED/32)))]

	mov r3, #(1 << (PIN_YELLOW%32))
	str r3, [r9, #(4*(7 + (PIN_YELLOW/32)))]
	mov r0, #1
	bl sleep
	mov r3, #(1 << (PIN_YELLOW%32))
	str r3, [r9, #(4*(10 + (PIN_YELLOW/32)))]

	mov r3, #(1 << (PIN_GREEN%32))
	str r3, [r9, #(4*(7 + (PIN_GREEN/32)))]
	mov r0, #1
	bl sleep
	mov r3, #(1 << (PIN_GREEN%32))
	str r3, [r9, #(4*(10 + (PIN_GREEN/32)))]

	mov r2, #1 //r2 auf 1 setzen damit dann sprung in backwards
	pop {lr}
	bx lr
.endfunc
.global backwards
.func backwards



backwards:
	push {lr}
	mov r3, #(1 << (PIN_GREEN%32))
	str r3, [r9, #(4*(7 + (PIN_GREEN/32)))]
	mov r0, #2
	bl sleep
	mov r3, #(1 << (PIN_GREEN%32))
	str r3, [r9, #(4*(10 + (PIN_GREEN/32)))]

	mov r3, #(1 << (PIN_YELLOW%32))
	str r3, [r9, #(4*(7 + (PIN_YELLOW/32)))]
	mov r0, #2
	bl sleep
	mov r3, #(1 << (PIN_YELLOW%32))
	str r3, [r9, #(4*(10 + (PIN_YELLOW/32)))]

	mov r3, #(1 << (PIN_RED%32))
	str r3, [r9, #(4*(7 + (PIN_RED/32)))]
	mov r0, #2
	bl sleep
	mov r3, #(1 << (PIN_RED%32))
	str r3, [r9, #(4*(10 + (PIN_RED/32)))]

	mov r2, #0
	pop {lr}
	bx lr
