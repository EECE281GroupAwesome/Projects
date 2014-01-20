$NOLIST

; logic_macs.asm
; January 19th,2014
; Some fun macro and function stuff
; Assumes a, b, and c are not important
; max.prokopenko@gmail.com

equal_to:
	mov a, R0
	mov b, R1
	clr c
	cjne a, b, eq0
	clr c
	sjmp eq1
eq0:setb c 
eq1:ret

not_equal_to:
	mov a, R0
	mov b, R1
	clr c
	cjne a, b, ne0
	setb c
	sjmp ne1
ne0:clr c 
ne1:ret

greater_than:
	mov b, R0
	mov a, R1
	clr c
	subb a, b
	jc gt0
	setb c
	sjmp gt1
gt0:clr c 
gt1:ret

less_than:
	mov b, R1
	mov a, R0
	clr c
	subb a, b
	jc lt0
	setb c
	sjmp lt1
lt0:clr c 
lt1:ret

if_ mac
	mov R0, a
	push acc
	mov R1, a
	push acc
	mov R0, %0
	mov R1, %2
	lcall %1
	clr a	
	jc %0%1%2%3%4
	%3 %4
%0%1%2%3%4:
	pop acc
	mov a, R1
	pop acc
	mov a, R0
endmac

end