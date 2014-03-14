; state_machine_skeleton.asm
; a model of what the main body of the controller could be like
; max.prokopenko@gmail.com
; january 27th, 2014

$MODDE2

;***********
;some states
;***********

IDLE 			equ 0x00
CANCEL 			equ 0x01
RAMP_TO_SOAK 	equ 0x01
SOAK 			equ 0x02 
RAMP_TO_REFLOW 	equ 0x03
REFLOW 			equ 0x04
COOLING			equ 0x05
DONE			equ 0x06
SET_SOAK_TEMP	equ 0x07
SET_SOAK_TIME	equ 0x08
SET_REFLOW_TEMP	equ 0x09
SET_REFLOW_TIME	equ 0x0a

;*****************
;universal equates
;*****************

FREQ   EQU 33333333
BAUD   EQU 115200

;***********************************
;ISRs and other fixed-address things
;***********************************

org 0000H
   ljmp switch

;***************************************
;data: x, y, bcd, mf used for math32.asm 
;***************************************

DSEG at 30H
x:   ds 4
y:   ds 4
bcd: ds 5
current_state: ds 1

BSEG
mf: dbit 1

CSEG

$include (math32.asm)
$include (logic_macs.asm)

CSEG

;***********************************************
;there are lots of nicer ways of doing a switch
;eg. an array of addresses offset by the state
;
;there are two logic macros if_ is for comparing
;two variables (such as acc and current_state)
;if_imd_ accepts an immedate value without # as
;it's second argument
;if you need to make a macro call unique you
;can add a comma and a garbage value to the call
;
;of course you don't need to use these silly
;macros at all and feel free to change anything
;***********************************************

switch:
	if_imd_(current_state, equal_to, IDLE, ljmp, idle_state)
	if_imd_(current_state, equal_to, CANCEL, ljmp, cancel_state)
	if_imd_(current_state, equal_to, RAMP_TO_SOAK, ljmp, ramp_to_soak_state)
	if_imd_(current_state, equal_to, SOAK, ljmp, soak_state)
	if_imd_(current_state, equal_to, RAMP_TO_REFLOW, ljmp, ramp_to_reflow_state)
	if_imd_(current_state, equal_to, REFLOW, ljmp, reflow_state)
	if_imd_(current_state, equal_to, COOLING, ljmp, cooling_state)
	if_imd_(current_state, equal_to, DONE, ljmp, done_state)
	if_imd_(current_state, equal_to, SET_SOAK_TEMP, ljmp, set_soak_temp_state)
	if_imd_(current_state, equal_to, SET_SOAK_TIME, ljmp, set_soak_time_state)
	if_imd_(current_state, equal_to, SET_REFLOW_TEMP, ljmp, set_reflow_temp_state)
	if_imd_(current_state, equal_to, SET_REFLOW_TIME, ljmp, set_reflow_time_state)
	ljmp switch

idle_state:
	;**************************************************
	;all initialization for a state can take place here
	;**************************************************
idle_state_loop:
	if_imd_(current_state, not_equal_to, IDLE, ljmp, switch)
	;*****************************************
	;then do this stuff while in this state
	;
	;if exiting this state, do:
	;
	;mov current_state, #<desired_state>
	;
	;and the switch loop takes care of routing
	;during the next loop pass
	;*****************************************
	ljmp idle_state_loop
	
cancel_state:
	; might not need a loop for this one
cancel_state_loop:
	if_imd_(current_state, not_equal_to, CANCEL, ljmp, switch)
	ljmp cancel_state_loop
	
ramp_to_soak_state:
ramp_to_soak_state_loop:
	if_imd_(current_state, not_equal_to, RAMP_TO_SOAK, ljmp, switch)
	ljmp cancel_state_loop
	
soak_state:
soak_state_loop:
	if_imd_(current_state, not_equal_to, SOAK, ljmp, switch)
	ljmp soak_state_loop
	
ramp_to_reflow_state:
ramp_to_reflow_state_loop:
	if_imd_(current_state, not_equal_to, RAMP_TO_REFLOW, ljmp, switch)
	ljmp cancel_state_loop
	
reflow_state:
reflow_state_loop:
	if_imd_(current_state, not_equal_to, REFLOW, ljmp, switch)
	ljmp reflow_state_loop
	
cooling_state:
cooling_state_loop:
	if_imd_(current_state, not_equal_to, COOLING, ljmp, switch)
	ljmp cooling_state_loop
	
done_state:
	; i suppose it could be simpler if it's just procedural
	mov current_state, #IDLE
	ljmp switch

set_soak_temp_state:
set_soak_temp_state_loop:
	if_imd_(current_state, not_equal_to, SET_SOAK_TEMP, ljmp, switch)
	ljmp set_soak_temp_state_loop

set_soak_time_state:
set_soak_time_state_loop:
	if_imd_(current_state, not_equal_to, SET_SOAK_TIME, ljmp, switch)
	ljmp set_soak_time_state_loop
	
set_reflow_temp_state:
set_reflow_temp_state_loop:
	if_imd_(current_state, not_equal_to, SET_REFLOW_TEMP, ljmp, switch)
	ljmp set_reflow_temp_state_loop

set_reflow_time_state:
set_reflow_time_state_loop:
	if_imd_(current_state, not_equal_to, SET_REFLOW_TIME, ljmp, switch)
	ljmp set_reflow_time_state_loop

end