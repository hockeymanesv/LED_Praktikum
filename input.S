.extern high
.text
.balign 4
.equ PIN_YELLOW, 7
.equ PIN_GREEN, 25
.equ PIN_RED, 8
.equ PIN_IN, 10
.global input
.func input
input:
	ldr r3, [r9, #(4 * (13 + (PIN_IN/32)))]
	tst r3, #(1 << (PIN_IN%32))
	bne high
	bal input
.endfunc
