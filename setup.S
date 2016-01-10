.text
.balign 4
.global setup
.func setup
.equ PIN_YELLOW, 7
.equ PIN_GREEN, 25
.equ PIN_RED, 8
.equ PIN_IN, 10

setup:
	push {lr}
	bl map_peripheral
	pop {lr}
	mov r9, r0

	ldr r3, [r9, #(4 * (PIN_RED/10))]
	orr r3, #(1 << ((PIN_RED%10)*3))
	str r3, [r9, #(4 * (PIN_RED/10))]

	ldr r3, [r9, #(4 * (PIN_YELLOW/10))]
	orr r3, #(1 << ((PIN_YELLOW%10)*3))
	str r3, [r9, #(4 * (PIN_YELLOW/10))]

	ldr r3, [r9, #(4 * (PIN_GREEN/10))]
	orr r3, #(1 << ((PIN_GREEN%10)*3))
	str r3, [r9, #(4 * (PIN_GREEN/10))]

	ldr r3, [r9, #(4 * (PIN_IN/10))]
	and r3, #~(7 << ((PIN_IN%10)*3))
	str r3, [r9, #(4 * (PIN_IN/10))]

	bx lr
