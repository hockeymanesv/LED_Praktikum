.extern sleep
.extern map_peripheral
.extern setup
.extern output
.equ PIN_YELLOW, 7
.equ PIN_GREEN, 25
.equ PIN_RED, 8
.equ PIN_IN, 10
.text
.balign 4
.global main
.global high
.func   main

main:
	push {r4-r11, lr}
	bl setup
	mov r2, #0
	bl input
high:
	cmp r2, #1
	beq backwards
	bl forwards
	bal input
end_main:
	mov r0, #0
	pop {r4-r11, pc}
