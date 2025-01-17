$MODDE2
org 0000H
	mov SP, #7FH
	ljmp PowerOff
org 000BH
	ljmp Interupt0
org 001BH
	ljmp Interupt1

CoolConst   EQU 60
ReflowConst EQU 220
SoakConst   EQU 150
CSEG

$include(math16.asm)
$include(LCDlib.asm)
$include(DisplayandMacros.asm)	
$include(adc_functions.asm)
$include(HeatingandTimer.asm)
$include(serial.asm)
		
DSEG at 30H
	;ADC STUFF
	ADC_out_buffer: ds 1
	ADC_in_buffer: ds 2
	last_reading: ds 2
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
	bcd:       ds 3
	;Oven Settables
	Reflow_Temp: Ds 1
	Reflow_Time: Ds 1
	Soak_Temp:   Ds 1
	Soak_Time:	 Ds 1
	;Universal for temp
	Target_Temp: Ds 1
	;Enviroment
	Oven_Temp:   Ds 1
	;LCD Variables
	;LCD_Temperature: ds 1
	LCD: ds 3
	Thermo_cursor: DS 1
	Thermo_segment: DS 1
	Thermo_inc: ds 1
	LCD_state: ds 1
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
	mov P3MOD, #0xFF
	;Reset standard times
	mov Reflow_Temp, #ReflowConst
	mov Reflow_Time, #30  ;30 real value
	mov Soak_Temp,   #SoakConst
	mov Soak_Time,	 #75 ; 75 real value
	mov a, SWC
	clr EA	
	jnb acc.1, PowerOff
	lcall init_lcd
	ljmp PowerOn
;Initial Set up	on reboot
PowerOn:
	lcall ADC_Init
	lcall Initialize_Timer
	setb EA
	;Turn off LED's
	mov LEDRA, #0
	mov LEDRB, #0
	mov LEDRC, #0
	mov LEDG, #0
	mov LCD_state, #1
	setb TR2
	ljmp Idle	
	
;awaiting process loop
Idle:
	mov LCD_state, #1
	mov Target_Temp, #0
	clr timing
	setb ET0
	setb LEDG.1
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
	clr c
	mov a, Soak_Temp
	subb a, #31
	mov Soak_Temp, a
	ljmp Preheat_Soak
	
;------------------------------------------------------------------	
;Setting Times and Temperatures (Not Done)
;   -had thought maybe macro for time and temp, that takes bounds 
;   so the time or temp is within reason
;------------------------------------------------------------------
Set_Soak_Temp:
	mov LCD_state, #8
	lcall Set_Soak_Temp_Relay
	jb SWA.4, Set_Soak_Temp
	lcall clear_hex
	sjmp Idle
Set_Soak_Time:
	mov LCD_state, #5
	lcall Set_Soak_Time_Relay
	jb SWA.3, Set_Soak_Time
	lcall clear_hex
	Sjmp Idle
Set_Reflow_Temp:
		mov LCD_state, #7
	lcall Set_Reflow_Temp_Relay
	jb SWA.2, Set_Reflow_Temp
	lcall clear_hex
	Sjmp Idle
Set_Reflow_Time:
		mov LCD_state, #6
	lcall Set_Reflow_Time_Relay	
	jb SWA.1, Set_Reflow_Time
	lcall clear_hex
	Sjmp Idle

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
	mov LCD_state, #2 ; preheat
	setb LEDG.2
	mov Target_Temp, Soak_Temp
	jnb Ready, PreHeat_Soak
	clr Ready
	mov R5, #45
X6:	lcall Wait
	cpl LEDRA.5
	djnz R5, X6
	mov a, Target_Temp
	Add a, #31
	mov Target_Temp, a
Preheat_Soak0:	
	jnb Ready, PreHeat_Soak0
	lcall beep
;Initialize for holding constant
	setb LEDG.3
	mov seconds, Soak_Time+0
	mov LCD_state, #4 ;soak 
	clr finished	 
WaitSoak:
	lcall display_time
	mov a, seconds
	cjne a, #7, NotFive
	mov target_Temp, Reflow_Temp
NotFive:	
	jnb finished, WaitSoak

;Initilize for ramp to Reflow
	
	lcall clear_hex
	setb LEDG.4
	lcall beep
	mov LCD_state, #2 ; preheat
	clr ready
	
Preheat_Reflow:
	jnb Ready, PreHeat_Reflow
	lcall beep
;Pass Reflow Time, wait for time to expire	
	setb LEDG.5
	mov seconds, Reflow_Time+0
	mov LCD_state, #3 ;reflow
	clr finished
WaitReflow:
	lcall display_time	
	jnb finished, WaitReflow
	lcall clear_hex
	lcall beep
;Process Finished, Wait for it to cool
Cooling:
	mov LCD_state, #9
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
		mov LCD_state, #10	
Done:
	setb LEDG.7
	jb Key.1, Done
	jnb Key.1, $
	mov LEDG, #0
	ljmp Idle
		
Set_Reflow_Time_Relay:
	Set_Any(Reflow_Time, #29, #46)
	Display_Any(Reflow_Time)
	ret	
Set_Reflow_Temp_Relay:
	Set_Any(Reflow_Temp, #199, #231)
	Display_Any(Reflow_Temp)
	ret	
Set_Soak_Temp_Relay:	
	Set_Any(Soak_Temp, #134, #165)
	Display_Any(Soak_Temp)
	ret	
Set_Soak_Time_Relay:
	Set_Any(Soak_Time, #59, #91)
	Display_Any(Soak_Time)
	ret
		
END
