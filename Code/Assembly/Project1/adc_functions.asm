			$NOLIST
;********************************
;		ADC_functions.asm		*
;********************************
;	
;	max.prokopenko@gmail.com
;
;	February 4th, 2014
;
;	USAGE NOTES:
;	In main:
;
;		lcall ADC_init 
; 
;	To get temperatures, invoke the
;	following macros and the current
;	temp will be returned in the 
;	register of your choice
;
;		get_room_temp(<register>)
;
;		get_oven_temp(<register>)
;

ACLK equ P1.0
DOUT equ P1.1
DIN equ P1.2
nCS equ P1.3
ADC_DIR equ 0b00001101 ; P1.0, P1.2-3 out, P1.1 in
ADC_RANGE EQU 1024
dK_TO_dC equ 273

CSEG

ADC_convert_on_channel mac ;call as ADC_convert_on_channel(<channel>)
	clr nCS
	mov a, #0b10000000 ; single ended mode
	swap a
	orl a, #%0
	swap a
	lcall ADC_convert
endmac

get_room_temp mac
	lcall room_convert
	mov %0, a
endmac

get_oven_temp mac
	get_room_temp(R0)
	mov b, R0
	lcall oven_convert
	add a, b
	mov %0, a
endmac

room_convert:	
	ADC_convert_on_channel(0)
	mov x+0, last_reading+0
	mov x+1, last_reading+1
	mov x+2, #0
	mov x+3, #0
	load_y(330) ; ADC * 330 / ADC_RANGE - dK_TO_dC = TºC
	lcall mul16
	Load_y(ADC_RANGE)
	lcall div16
	Load_y(dK_TO_dC)
	lcall sub16
	mov a, x
	ret

oven_convert:
	ADC_convert_on_channel(1)
	mov x+0, last_reading+0
	mov x+1, last_reading+1
	mov x+2, #0
	mov x+3, #0
	load_y(4) ; ADC / 4 = TºC
	lcall div16
	mov a, x
	ret

ADC_send:
	mov DIN, c
	lcall ADC_clock	; clock it through
	rlc a ; next bit	
	ret

ADC_receive:
	mov c, DOUT
	lcall ADC_clock	
	rlc a
	ret
 
ADC_init:
	mov P1MOD, #ADC_DIR	
	setb nCS
	ret

ADC_convert:
	setb DIN ; start bit
	lcall ADC_clock
	rlc a
	mov r0, #4
send_loop:
	lcall ADC_send
	djnz r0, send_loop
	lcall ADC_clock
	lcall ADC_clock
	clr a
	lcall ADC_receive
	lcall ADC_receive
	mov last_reading+1, a
	clr a
	mov r0, #8
receive_loop:
	lcall ADC_receive
	djnz r0, receive_loop
	mov last_reading+0, a
	clr a
	setb nCS
	ret
	
ADC_clock:
	nop
	nop
	nop
	setb ACLK
	nop
	nop
	nop
	clr ACLK
	ret
	
end