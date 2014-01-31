$MODDE2
org 0000H
	ljmp PowerOff
org 000BH
	ljmp Interupt0
org 001BH
	ljmp Interupt1

CoolConst   EQU 60
ReflowConst EQU 220
SoakConst   EQU 150

$include(DisplayandMacros.asm)	
$include(HeatingandTimer.asm)
$include(serial.asm)
$include(math16.asm)
		
DSEG at 30H
	;Overflow Counter
	count10ms: ds 1
	count5ms: ds 1
	;Universal for time
	seconds:   ds 1
	minutes:   ds 1
	hours:     ds 1
	;math variables
	x: 		   ds 2
	y:         ds 2
	bcd:       ds 4
	;Oven Settables
	Reflow_Temp: Ds 1
	Reflow_Time: Ds 1
	Soak_Temp:   Ds 1
	Soak_Time:	 Ds 1
	;Universal for temp
	Target_Temp: Ds 1
	;Enviroment
	Oven_Temp:   Ds 1
BSEG
	;booleans
	Ready:       Dbit 1
	Finished:    dbit 1
	Timing:      dbit 1
	mf:          dbit 1
CSEG

;Stops Everything until switch 1 is turned back on (Not Done)
PowerOff:
	mov P0MOD, #0xFF
	;Reset standard times
	mov Reflow_Temp, #ReflowConst
	mov Reflow_Time, #4
	mov Soak_Temp,   #SoakConst
	mov Soak_Time,	 #6
	mov a, SWC
	setb EA	
	jnb acc.1, PowerOff
	ljmp PowerOn
;Initial Set up	on reboot
PowerOn:
	lcall Initialize_Timer
	mov Oven_Temp, #25
	;Turn off LED's
	mov LEDRA, #0
	mov LEDRB, #0
	mov LEDRC, #0
	mov LEDG, #0
	setb TR2
	ljmp Idle	
	
;awaiting process loop	
Idle:
	mov Target_Temp, #0
	clr timing
	setb ET0
	;mov Target_Temp, #0
	setb LEDG.1
	clr Timing
	;Stop Timer
	;set things while switch is up, return by flicking down
	jb SWA.1, Set_Reflow_Time
	jb SWA.2, Set_Reflow_Temp
	jb SWA.3, Set_Soak_Time
	jb SWA.4, Set_Soak_Temp
	jb Key.1, Idle
	;ready to start process
	lcall beep
	clr Ready
	ljmp Preheat_Soak
;------------------------------------------------------------------	
;Setting Times and Temperatures (Not Done)
;   -had thought maybe macro for time and temp, that takes bounds 
;   so the time or temp is within reason
;------------------------------------------------------------------
Set_Soak_Temp:
	;lcall Set_Temp(Soak_Temp, lowerbound, upperbound)
	jnb SWA.4, Idle
	sjmp Set_Soak_Temp
Set_Soak_Time:
	;lcall Set_Time(Soak_Time, lowerbound, upperbound)
	jnb SWA.3, Idle
	sjmp Set_Soak_Time
Set_Reflow_Temp:
	;lcall Set_Temp(Reflow_Temp, lowerbound, upperbound)
	jnb SWA.2, Idle
	sjmp Set_Reflow_Temp
Set_Reflow_Time:
	;lcall Set_Temp(Reflow_Time, lowerbound, upperbound)
	jnb SWA.1, Idle
	sjmp Set_Reflow_Time
	
;------------------------------------------------------------------	
;Actual Progression Through Phases
;PRE-HEAT
;SOAK
;PRE-HEAT
;REFLOW
;COOLING
;DONE
;------------------------------------------------------------------

;Waits for temperature to get above soak temp
Preheat_Soak:
	setb LEDG.2
	mov Target_Temp, Soak_Temp
	jnb Ready, PreHeat_Soak
	lcall beep
;passes time
Soak_Init:	
	setb LEDG.3
	mov seconds, Soak_Time+0
	clr finished	 
WaitSoak:
	lcall display_time	
	jnb finished, WaitSoak
;Time is up	
	lcall display_time
	setb LEDG.4
	lcall beep
	mov Target_Temp, Reflow_Temp
	clr ready
Preheat_Reflow:
	jnb Ready, PreHeat_Reflow
	lcall beep
;Pass Reflow Time, wait for time to expire	
Reflow_Init:
	setb LEDG.5
	mov seconds, Reflow_Time+0
	clr finished
WaitReflow:
	lcall display_time	
	jnb finished, WaitReflow
	lcall display_time
	lcall beep
;Process Finished, Wait for it to cool
Cooling:
	mov Target_Temp, #CoolConst
	setb ready	
WaitCool:	
	setb LEDG.6
	;wait for temp to dip below 60 Celcius (Cool Constant)
	jb Ready, WaitCool
	;set temp to zero
	mov Target_Temp, #0
	;triple beep
	lcall beep
	lcall wait
	lcall beep
	lcall wait
	lcall beep
;Cool Enough (just waits PB)	
Done:
	setb LEDG.7
	jb Key.1, Done
	mov LEDG, #0
	ljmp Idle	

END