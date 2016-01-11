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

/* Hauptdatei */
main:
	push {r4-r11, lr} //Register auf Stapel
	bl setup //zu setup springen dort LEDs und Taster initialisieren
	mov r2, #0 //entscheider fuer Richtung
	bl input //Unterprogramm für

/* fuer durchlaeufe noetig */
high:
	cmp r2, #1 //beim ersten mal 0 --> bl forwards
	beq backwards //beim zweiten mal 1 --> beq backwards
	bl forwards
	bal input

/* Endfunktion */
end_main:
	mov r0, #0
	pop {r4-r11, pc}
