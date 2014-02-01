putchar:
    JNB TI, putchar
    CLR TI
    MOV SBUF, a
    RET
SendTemp:
	push acc
	mov a, x
	mov x, Oven_Temp
	mov x+1, #0
	lcall Hex2Bcd
	mov A, bcd+1
    anl a, #0fh
    add a, #48  
    lcall putchar	 
	mov A, bcd+0
	swap a
    anl a, #0fh
    add a, #48
    lcall putchar
    mov A, bcd+0
    anl a, #0fh
    add a, #48
    lcall putchar
    mov a, #'\n'
    lcall putchar
    mov a, #'\r'
    lcall putchar
    mov x, a
    pop acc
	ret	
	
END	