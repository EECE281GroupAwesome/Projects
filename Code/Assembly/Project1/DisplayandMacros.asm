;
;Functions for displaying the time using seconds
;		   for displaying the oven temp
;little useful functions like wait
; Beep to make short buzzer pulse			


Display_Any MAC
	mov x, %0
	mov x+1, #0
	lcall hex2bcd
	mov dptr, #myLUT
	; Display Digit 0
    mov A, bcd+0
    anl a, #0fh
    movc A, @A+dptr
    mov HEX4, A
	; Display Digit 1
    mov A, bcd+0
    swap a
    anl a, #0fh
    movc A, @A+dptr
    mov HEX5, A    
    ; Display Digit 2
    mov A, bcd+1
    anl a, #0fh
    jz Ender_%0
    movc A, @A+dptr
    mov HEX6, A
    jmp Exit_%0
    Ender_%0:
    mov HEX6, #0FFH
    Exit_%0:
endmac

clear_hex:
	push ACC
	mov A, #0FFH
	mov HEX4, A
	mov HEX5, A
	mov HEX6, A
	pop ACC
	ret
display_Time:
	mov x, seconds
	mov x+1, #0
	lcall hex2bcd
	mov dptr, #myLUT
	; Display Digit 0
    mov A, bcd+0
    anl a, #0fh
    movc A, @A+dptr
    mov HEX4, A
	; Display Digit 1
    mov A, bcd+0
    swap a
    anl a, #0fh
    movc A, @A+dptr
    mov HEX5, A    
    ; Display Digit 2
    mov A, bcd+1
    anl a, #0fh
    movc A, @A+dptr
    mov HEX6, A
    ret   
  
Wait:
	mov R3, #100
L3:	mov R2, #250
L2:	mov R1, #250
L1: djnz R1, L1
	djnz R2, L2
	djnz R3, L3
	ret		
Beep:
	setb ET1
	lcall wait
	clr Et1
	ret

display_Temp:
	mov x, Oven_Temp
	mov x+1, #0
	lcall hex2bcd
	mov dptr, #myLUT
	; Display Digit 0
    mov A, bcd+0
    anl a, #0fh
    movc A, @A+dptr
    mov HEX0, A
	; Display Digit 1
    mov A, bcd+0
    swap a
    anl a, #0fh
    movc A, @A+dptr
    mov HEX1, A
    ; Display Digit 2
    mov A, bcd+1
    anl a, #0fh
    movc A, @A+dptr
    mov HEX2, A  
    ret 

Set_Any MAC
	Inc_%0:
		mov A, %0
	
		jb KEY.2, Dec_%0
    	jnb KEY.2, $
		inc A
		cjne A, %2, Done_%0
		dec A
	Dec_%0:	
   	    jb KEY.3, Done_%0
   	    jnb KEY.3, $
		dec A
	    cjne A, %1, Done_%0
        inc A
	Done_%0:
		mov %0, A
endmac

END	

