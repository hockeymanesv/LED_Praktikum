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
	ldr r3, [r9, #(4 * (13 + (PIN_IN/32)))] //Register Pin Level abfragen
	tst r3, #(1 << (PIN_IN%32)) //testen ob r3 gleich der zahl ist --> wenn gleich dann Flag
	bne high //wenn Flag 0 dann high
	bal input //wenn 1 dann erneut ausfuehren
.endfunc
