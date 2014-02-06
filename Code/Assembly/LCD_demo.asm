$MODDE2
org 0000H
   ljmp MyProgram


dseg at 30h

bcd: ds 3
x:	 ds 2
y:	 ds 2

State_Num: DS 1


bseg
mf:	dbit 1


$include(math16.asm)
$include(LCDlib.asm)



CSEG



		 

		

	

	
	
MyProgram:
	mov sp, #07FH
	clr a
	mov LEDG,  a
	mov LEDRA, a
	mov LEDRB, a
	mov LEDRC, a
	mov LCD_temperature, a
	mov x+0, a
	mov x+1, a
	mov x+2, a
	mov x+3, a
	lcall Init_LCD
	
	mov LCD_temperature, #50

	ljmp forever




	
forever:

	;lcall SetSoakTime_Display
	;lcall thermo_update


	;lcall Reflow_Display


	;lcall temp_display
	
	
	
	
	;lcall thermo_update
	mov r4, #200
up_temp1:
	lcall preheat_display
	inc LCD_temperature
	lcall wait1s
	djnz r4, up_temp1

	mov r4, #100
	;lcall wait1s
	
down_temp1:
	lcall soak_display
	dec LCD_temperature
	lcall wait1s
	djnz r4, down_temp1

	mov r4, #50
up_temp:
	lcall soak_display
	inc LCD_temperature
	lcall wait1s
	djnz r4, up_temp
	
	mov r4, #150
	;lcall wait1s
	
down_temp:
	lcall Cooling_Display
	dec LCD_temperature
	lcall wait1s
	djnz r4, down_temp
	
	sjmp Forever
	
end


Thermo_update:
	lcall room_temp ;initializes empty thermometer
	LCD_cursor(line2)
	LCD_write(#00H)
	load_x(LCD_temperature) ;loads with oven temp 
	load_y(20) ;Oven temp - room temp value = temp
	lcall sub16
	load_y(5) ; temp / deg per seg = thermometer in 
	lcall div16
	mov Thermo_inc, x+0 ; thermometer increment value 
	load_y(6) ; thermometer inc / inc per seg = segment
	lcall div16
	mov Thermo_segment, x+0 ;turns all segments on until this segment
	;mov r6, #1
	LCD_cursor(line2+1) ; moves to first segment
	mov r7, Thermo_segment 
Thermo_L1:
	LCD_write(#06H) ;fills in thermometer untul segment is reached 
	inc r6
	djnz r7, Thermo_L1
	
	load_x(thermo_segment) 
	load_y(6)
	lcall mul16
	lcall xchg_xy
	load_x(Thermo_inc) ; fills in the partial segment 
	lcall sub16 
	inc x+0
	LCD_write(x+0)
	; rest of thermometer should remain unchanged
	ret
	 