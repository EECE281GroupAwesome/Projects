DSEG at 38H
   	Temperature:   ds 3
CSEG  
;-------------------------------------------
; Increments the temperature by one
; Handles Rollover (all in BCD)
;-------------------------------------------
Increment_Temperature: 
	push acc                                 ;save used registers
	push psw
	
	clr c                                    ;clear the carry to sense overflow from da
	
	mov a, Temperature+0                     ;ones and tens carry
	add a, #1
	da a	
	mov Temperature+0, a
	jnc return                              

	mov a, Temperature+1                     ;lower 8 bits is 100, increment upper 8
	add a, #1
	da a
	mov Temperature+1, a
return:
	pop psw                                  ;restore used registers
	pop acc
	ret
END	