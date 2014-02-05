$MODDE2
org 0000H
   ljmp MyProgram


dseg at 30h
LCD: ds 10
bcd: ds 5
x:	 ds 4
y:	 ds 4
Thermo_cursor: DS 1
State_Num: DS 1


bseg
mf:	dbit 1

Line1 EQU #080h
Line2 EQU #0A8h
Degree EQU #0DFH

$include(LCDlib.asm)
$include(math32.asm)

CSEG


;State Display LUTs	




		
;Find_State:
;	clr a
;	mov a, state_lut_position
;	movc a, @a+dptr
;	inc dptr
;	inc State_LUT_Position
;	cjne a, #10h, Find_State
;	inc R2
;	mov a, R2
;	cjne a, State_num, find_state	
	



;Converting hex to ascii for temperature and 
;time variables
	



	
	
	
MyProgram:
	mov sp, #07FH
	clr a
	mov LEDG,  a
	mov LEDRA, a
	mov LEDRB, a
	mov LEDRC, a

	mov x+0, a
	mov x+1, a
	mov x+2, a
	mov x+3, a
	lcall Init_LCD
	
	mov x+0, #230
	ljmp forever





		
	
forever:
	LCD_cursor(Line1)
	lcall SetSoakTime_Display
	lcall wait1s
;	LCD_cursor(Line2+12)
;	lcall Idle_Display
;	lcall wait1s
;	lcall Thermometer_demo
	lcall wait1s

	lcall room_temp
	LCD_cursor(Line2+11)
	lcall hex2bcd
	lcall ascii_display
	
	LCD_write(LCD+2)
	LCD_write(LCD+1)
	LCD_write(LCD+0)
	LCD_Write(Degree)
	LCD_Write(#'C')
	;lcall Thermometer_demo
	dec x+0
	sjmp Forever
	
end


