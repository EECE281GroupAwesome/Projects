;This is a library with LCD functions 
;





$NOLIST




CSEG

Line1 EQU #080h
Line2 EQU #0A8h
Degree EQU #0DFH

$include(Thermo_LUT.asm)

LCD_cursor mac
	mov LCD_DATA, %0
	lcall LCD_command
	lcall wait2ms
endmac

LCD_write mac
	mov LCD_DATA, %0
	lcall LCD_put
endmac

delay100us:
	push AR0
	push AR1
	mov R1, #10
L0_: mov R0, #111
L1_: djnz R0, L1_ ; 111*30ns*3=10us
	djnz R1, L0_ ; 10*10us=100us, approximately
	pop AR1
	pop AR0
	ret
	
	
Wait2ms: ;33.33MHz, 1 clk per cycle: 0.03us	
	push AR0
	push AR1
	mov R1, #50 ;100*20us=2ms
F2: mov R0, #100 ;3*222*0.03us=20us
F1: 
	djnz R0, F1
	djnz R1, F2
	pop AR1
	pop AR0
	ret

Wait1S: ;33.33MHz, 1 clk per cycle: 0.03us
	push AR0
	push AR1	
	mov R2, #40 ;177*5.67ms=1.0036s
J3: mov R1, #254 ;250*22.68us=5.67ms
J2: mov R0, #253 ;3*252*0.03us=22.68us
J1: 

	djnz R0, J1
	djnz R1, J2
	djnz R2, J3
	pop AR1
	pop AR0
	ret

Clear_LCD:
	
	mov LCD_DATA, #01H ; Clear screen (Warning, very slow command!)
	lcall LCD_command
	
	lcall wait2ms ; delay needed for clear cmd
	LCD_cursor(line1)

	ret
;This subroutine initiates the LCD to display 2 lines
;8 bit interface, 5x8 characters and clear the screen and move the 
;cursor to the start position
	
Init_LCD:

	setb LCD_On
	clr LCD_en 
	lcall wait2ms
	
	mov LCD_MOD, #0FFH
	clr LCD_rw


	
	mov LCD_DATA, #0Ch ; Display on command
	lcall LCD_command
	mov LCD_DATA, #38H ; 8-bits interface, 2 lines, 5x8 characters
	lcall LCD_command
	
	lcall wait2ms
	lcall make_char ;makes 8 special charatcters
	
	mov LCD_DATA, #01H ; Clear screen (Warning, very slow command!)
	lcall LCD_command
	
	lcall wait2ms ; delay needed for clear cmd
	mov LCD_DATA, Line1 ;moves cursor to start of first line 
	lcall LCD_command 
	lcall wait1s
	ret	
	
;initiates the byte stored in the LCD_DATA as an 
;LCD command
	
LCD_command:
	
	clr	LCD_RS
	nop
	nop
	setb LCD_EN ; Enable pulse should be at least 230 ns
	nop
	nop
	nop
	nop
	nop
	nop
	clr	LCD_EN
	lcall wait2ms	
	ret

;Sends the byte in the LCD_DATA to the LCD as an ascii character	
	
LCD_put:
	;mov	LCD_DATA, A
	setb LCD_RS
	nop
	nop
	setb LCD_EN ; Enable pulse should be at least 230 ns
	nop
	nop
	nop
	nop
	nop
	nop
	clr	LCD_EN
	lcall Wait2ms
	ret	

Ascii_LUT:
    DB 030H, 031H, 032H, 033H, 034H        ; 0 TO 4
    DB 035H, 036H, 037H, 038H, 039H        ; 4 TO 9
    DB 010H, 022H, 0FFH, 024H, 025H, 026H
    
Ascii_display:
	mov dptr, #Ascii_LUT
	
	
	mov a, bcd+1
	jz Kill_leading_zero
	anl a, #0fH
	movc a, @a+dptr
	mov LCD+2, a
	sjmp digit
Kill_leading_zero:
	mov LCD+2, #' '
DIgit:
	mov a, bcd+0
	swap a
	anl a, #0fH
	movc a, @a+dptr
	mov LCD+1, a
	
	mov a, bcd+0
	anl a, #0fH
	movc a, @a+dptr
	mov LCD+0, a
	ret
		
;State Display LUTs	
State1_LUT:
	DB 'Idle', 10H
State2_LUT:
	DB 'Preheat', 10H
State3_LUT:
	DB 'Reflow', 10H
State4_LUT:
	DB 'Soak', 10H
State5_LUT:
	DB 'Set Soak Time', 10H
State6_LUT:
	DB 'Set Reflow Time', 10H
State7_LUT:
	DB 'Set Reflow Temp', 10H
State8_LUT:
	DB 'Set Soak Temp', 10H	
State9_LUT:
	DB 'Cooling', 10H
State10_LUT:
	DB 'Done', 10H	
State11_LUT:
	DB 'Power Off', 10H	
State12_LUT:
	DB '           ', 10H	

State_disp:
	
	mov a, LCD_state
	cjne a, #1, not_idle
	lcall Idle_Display
Not_Idle:
	cjne a, #2, not_preheat
	lcall Preheat_Display
not_preheat:
	cjne a, #3, not_reflow
	lcall Reflow_Display
not_reflow:
	cjne a, #4, not_soak
	lcall Soak_Display
not_soak:
	cjne a, #5, not_SetSoakTime
	lcall SetSoakTime_Display
not_SetSoakTime:
	cjne a, #6, not_SetReflowTime
	lcall SetReflowTime_Display
not_SetReflowTime:
	cjne a, #7, not_SetReflowTemp
	lcall SetReflowTemp_Display
not_SetReflowTemp:
	cjne a, #8, not_setsoaktemp
	lcall SetsoakTemp_Display
not_setsoaktemp:
	cjne a, #9, not_cooling
	lcall Cooling_Display
not_cooling:
	cjne a, #10, not_done
	lcall Done_Display
not_done:
	cjne a, #11, not_poweroff
	lcall PowerOff_Display
not_poweroff:

ret	
	
Idle_Display:
	push acc
	mov dptr, #State1_LUT
	lcall State_Display
	pop acc
	ret
	
Preheat_Display:
	push acc
	mov dptr, #State2_LUT
	lcall State_Display
	pop acc
	ret
Reflow_Display:
	push acc
	mov dptr, #State3_LUT
	lcall State_Display
	pop acc
	ret
	
Soak_Display:
	push acc
	
	mov dptr, #State4_LUT
	lcall State_Display
	
	pop acc
	ret
	
SetSoakTime_Display:
	push acc
	mov dptr, #State5_LUT
	lcall State_Display
	pop acc
	ret
	
SetReflowTime_Display:
	push acc
	mov dptr, #State6_LUT
	lcall State_Display
	pop acc
	ret

SetReflowTemp_Display:
	push acc
	mov dptr, #State7_LUT
	lcall State_Display
	pop acc
	ret
	
SetsoakTemp_Display:
	push acc
	mov dptr, #State8_LUT
	lcall State_Display
	pop acc
	ret
	
Cooling_Display:
	push acc
	mov dptr, #State9_LUT
	lcall State_Display
	pop acc
	ret
	
Done_Display:
	push acc
	mov dptr, #State10_LUT
	lcall State_Display
	pop acc
	ret

PowerOff_Display:
	push acc
	mov dptr, #State11_LUT
	lcall State_Display
	pop acc
	ret
	
State_12:
	push acc
	mov dptr, #State12_LUT
	lcall State_Display
	pop acc
	ret


State_Display:
	push acc
	push psw
	lcall clear_lcd
		
State_Display_Loop:
	clr a
	movc a, @a+dptr
	mov LCD_DATA, a
	lcall LCD_put
	inc dptr
	cjne a, #10h, State_Display_Loop

	lcall thermo_update
	lcall Temp_display
	
	pop psw
	pop acc
	ret	
	
Temp_display:
	push acc
	push psw

	mov x+0, target_temp

	LCD_cursor(Line2+11)
	
	lcall hex2bcd
	


	lcall ascii_display

	LCD_write(LCD+2)
	LCD_write(LCD+1)
	LCD_write(LCD+0)
	LCD_Write(Degree)
	LCD_Write(#'C')	

	pop psw
	pop acc
	ret

Thermo_update:

	mov dptr, #Thermo_LUT
	LCD_cursor(line2)
	mov x+0, target_temp
	load_y(24)
	lcall x_lt_y
	jb mf, toosmall
	
	load_y(20)
	lcall sub16
	load_y(5)
	lcall div16

	sjmp justright
TooSmall:
	mov x+0, #0
TooBig:

JustRight:
	
	lcall Thermo_display
	ret

Thermo_Display:

	Push ar1
	push ar2
	mov a, x+0
	jz Thermo_Display_Loop
	mov r1, x+0
Check:
	mov r2, #10
	

Check_L1:
	inc dptr
	djnz r2, Check_L1
	djnz r1, check

Thermo_Display_Loop:
	clr a
	movc a, @a+dptr
	mov LCD_DATA, a
	lcall LCD_put
	inc dptr
	cjne a, #07h, Thermo_Display_Loop

	pop ar2
	pop ar2
	ret		
	
Make_char:
	mov LCD_DATA, #040H
	lcall LCD_command
	lcall wait2ms
	mov LCD_DATA, #0Eh 
	lcall LCD_put
	mov LCD_DATA, #1Fh
	lcall LCD_put
	mov LCD_DATA, #1Fh
	lcall LCD_put
	mov LCD_DATA, #1Fh
	lcall LCD_put
	mov LCD_DATA, #1Fh
	lcall LCD_put
	mov LCD_DATA, #1Fh
	lcall LCD_put
	mov LCD_DATA, #1Fh
	lcall LCD_put
	mov LCD_DATA, #0Eh
	lcall LCD_put
	
	lcall wait2ms
	mov LCD_DATA, #00000000b 
	lcall LCD_put
	mov LCD_DATA, #00011111b
	lcall LCD_put
	mov LCD_DATA, #00000000b
	lcall LCD_put
	mov LCD_DATA, #00000000b
	lcall LCD_put
	mov LCD_DATA, #00000000b
	lcall LCD_put
	mov LCD_DATA, #00000000b
	lcall LCD_put
	mov LCD_DATA, #00011111b
	lcall LCD_put
	mov LCD_DATA, #00000000b
	lcall LCD_put
	
	lcall wait2ms
	mov LCD_DATA, #0 
	lcall LCD_put
	mov LCD_DATA, #1FH
	lcall LCD_put
	mov LCD_DATA, #10h
	lcall LCD_put
	mov LCD_DATA, #10h
	lcall LCD_put
	mov LCD_DATA, #10h
	lcall LCD_put
	mov LCD_DATA, #10h
	lcall LCD_put
	mov LCD_DATA, #1Fh
	lcall LCD_put
	mov LCD_DATA, #0
	lcall LCD_put
	
	lcall wait2ms
	mov LCD_DATA, #0 
	lcall LCD_put
	mov LCD_DATA, #1FH
	lcall LCD_put
	mov LCD_DATA, #18H
	lcall LCD_put
	mov LCD_DATA, #18H
	lcall LCD_put
	mov LCD_DATA, #18H
	lcall LCD_put
	mov LCD_DATA, #18H
	lcall LCD_put
	mov LCD_DATA, #1Fh
	lcall LCD_put
	mov LCD_DATA, #0
	lcall LCD_put

	lcall wait2ms
	mov LCD_DATA, #0 
	lcall LCD_put
	mov LCD_DATA, #1FH
	lcall LCD_put
	mov LCD_DATA, #1Ch
	lcall LCD_put
	mov LCD_DATA, #1Ch
	lcall LCD_put
	mov LCD_DATA, #1Ch
	lcall LCD_put
	mov LCD_DATA, #1Ch
	lcall LCD_put
	mov LCD_DATA, #1Fh
	lcall LCD_put
	mov LCD_DATA, #0
	lcall LCD_put
	
	lcall wait2ms
	mov LCD_DATA, #0 
	lcall LCD_put
	mov LCD_DATA, #1FH
	lcall LCD_put
	mov LCD_DATA, #1Eh
	lcall LCD_put
	mov LCD_DATA, #1Eh
	lcall LCD_put
	mov LCD_DATA, #1Eh
	lcall LCD_put
	mov LCD_DATA, #1Eh
	lcall LCD_put
	mov LCD_DATA, #1Fh
	lcall LCD_put
	mov LCD_DATA, #0
	lcall LCD_put
	
	lcall wait2ms
	mov LCD_DATA, #0 
	lcall LCD_put
	mov LCD_DATA, #1FH
	lcall LCD_put
	mov LCD_DATA, #1FH
	lcall LCD_put
	mov LCD_DATA, #1FH
	lcall LCD_put
	mov LCD_DATA, #1FH
	lcall LCD_put
	mov LCD_DATA, #1FH
	lcall LCD_put
	mov LCD_DATA, #1Fh
	lcall LCD_put
	mov LCD_DATA, #0
	lcall LCD_put
	
	lcall wait2ms
	mov LCD_DATA, #0 
	lcall LCD_put
	mov LCD_DATA, #18h
	lcall LCD_put
	mov LCD_DATA, #4h
	lcall LCD_put
	mov LCD_DATA, #2h
	lcall LCD_put
	mov LCD_DATA, #2h
	lcall LCD_put
	mov LCD_DATA, #4h
	lcall LCD_put
	mov LCD_DATA, #18h
	lcall LCD_put
	mov LCD_DATA, #0
	lcall LCD_put
	lcall wait2ms	
	ret

;Thermometer Demo subroutine that runs the 
;LCD Thermometer through its full range
;

	
Thermometer_demo:
	lcall room_temp
	
	mov r7, Line2+1
loop_temp2:
	lcall inc_temp
	inc r7
	cjne r7, Line2+9, loop_temp2
	inc r7
	mov LCD_DATA, #07h
	lcall lcd_put
	lcall wait1s
	ret
	
Room_temp:
	mov r6, #00h
	mov R7, Line2
	mov LCD_DATA, R7
	lcall lcd_command
	lcall wait2ms
	mov LCD_DATA, r6
	lcall lcd_put
	inc r6
	
Temp_L1:
	inc R7
	mov LCD_DATA, R7
	lcall lcd_command
	lcall wait2ms
	mov LCD_DATA, r6
	lcall lcd_put
	cjne r7, Line2+8, Temp_L1
	inc r7
	mov LCD_DATA, #07h
	lcall lcd_put

	ret
	
Inc_temp:
	mov R6, #01H
loop_temp:

	mov LCD_DATA, r7
	lcall lcd_command
	lcall wait2ms
	mov LCD_DATA, R6
	lcall lcd_put
	inc R6
	lcall wait1s
	cjne R6, #07H, loop_temp
	ret
	


$LIST

	
