; Mactest.asm
; January 18th,2014
; Some fun macro and function stuff
; Assumes a, b, and c are not important
; max.prokopenko@gmail.com
;
; Any questions ask me here
; ISSUE: each invocation of the if_ macro must be unique!
;
; USAGE: include(logic_macs.asm) in cseg
;
; FUNCTION CALL EXAMPLES
; if_(swa, equal_to, swb, do_thing)
; if_(swa, not_equal_to, swb, do_other_thing)
; if_(swa, greater_than, swb, do_a_naughty_thing)
; if_(swa, less_than, swb, do_the_wrong_thing)

$MODDE2

ORG 0000H
	ljmp main

CSEG

$include (logic_macs.asm)

do_thing:
	setb ledg.0
	clr ledg.1
	clr ledg.2
	ret
	
do_other_thing:
	clr ledg.0
	ret
	
do_a_naughty_thing:
	setb ledg.1
	clr ledg.2
	ret
	
do_the_wrong_thing:
	setb ledg.2
	clr ledg.1
	ret
	
main:
	mov sp, #0x7f
	mov ledra, #0
	mov ledrb, #0
	mov ledrc, #0
	mov ledg, #0
	
m0:	mov ledra, swa
	mov ledrb, swb
	if_(swa, equal_to, swb, lcall, do_thing)
	if_(swa, not_equal_to, swb, lcall, do_other_thing)
	if_(swa, greater_than, swb, lcall, do_a_naughty_thing)
	if_(swa, less_than, swb, lcall, do_the_wrong_thing)
		
	ljmp m0

END