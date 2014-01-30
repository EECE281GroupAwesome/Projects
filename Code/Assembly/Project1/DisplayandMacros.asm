;
;Functions for displaying the time using seconds
;		   for displaying the oven temp
;little useful functions like wait
; Beep to make short buzzer pulse			



display_Time:
	mov x, seconds
	mov x+1, #0
	lcall hex2bcd
	mov dptr, #myLUT
	; Display Digit 0
    mov A, bcd+0
    anl a, #0fh
    movc A, @A+dptr
    mov HEX6, A
	; Display Digit 1
    mov A, bcd+0
    swap a
    anl a, #0fh
    movc A, @A+dptr
    mov HEX7, A    
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
    ; Display Digit 0
    mov A, bcd+1
    anl a, #0fh
    movc A, @A+dptr
    mov HEX2, A  
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
END	