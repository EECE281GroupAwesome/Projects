;--------------------------------------------------------
; File Created by C51
; Version 1.0.0 #1034 (Dec 12 2012) (MSVC)
; This file was generated Sat Mar 29 00:48:08 2014
;--------------------------------------------------------
$name core
$optc51 --model-small
$printf_float
	R_DSEG    segment data
	R_CSEG    segment code
	R_BSEG    segment bit
	R_XSEG    segment xdata
	R_PSEG    segment xdata
	R_ISEG    segment idata
	R_OSEG    segment data overlay
	BIT_BANK  segment data overlay
	R_HOME    segment code
	R_GSINIT  segment code
	R_IXSEG   segment xdata
	R_CONST   segment code
	R_XINIT   segment code
	R_DINIT   segment code

;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	public _MEMORY_LENGTH
	public _PRESETS
	public _NSTAGES
	public _ANGLEBUFFER
	public _DISTANCEBUFFER
	public _MINVOLT
	public _TURNSPEED
	public _MOVESPEED
	public _main
	public __c51_external_startup
	public _beaconSignal
	public _pwmCounter
	public _smooth_move_PARM_2
	public _rightHistory
	public _leftHistory
	public _turn
	public _Stage
	public _gotInst
	public _instruction
	public _distanceRight
	public _distanceLeft
	public _pwmRightTemp
	public _pwmLeftTemp
	public _rightSensor
	public _leftSensor
	public _tether
	public _direction
	public _pwmRight
	public _pwmLeft
	public _distCount
	public _pwmCount
	public _getDistance
	public _turnRatio
	public _moveCar
	public _smooth_move
	public _uTurn
	public _getSig
	public _wait1s
	public _voltage
	public _SPIWrite
	public _GetADC
;--------------------------------------------------------
; Special Function Registers
;--------------------------------------------------------
_ACC            DATA 0xe0
_B              DATA 0xf0
_PSW            DATA 0xd0
_SP             DATA 0x81
_SPX            DATA 0xef
_DPL            DATA 0x82
_DPH            DATA 0x83
_DPLB           DATA 0xd4
_DPHB           DATA 0xd5
_PAGE           DATA 0xf6
_AX             DATA 0xe1
_BX             DATA 0xf7
_DSPR           DATA 0xe2
_FIRD           DATA 0xe3
_MACL           DATA 0xe4
_MACH           DATA 0xe5
_PCON           DATA 0x87
_AUXR           DATA 0x8e
_AUXR1          DATA 0xa2
_DPCF           DATA 0xa1
_CKRL           DATA 0x97
_CKCKON0        DATA 0x8f
_CKCKON1        DATA 0xaf
_CKSEL          DATA 0x85
_CLKREG         DATA 0xae
_OSCCON         DATA 0x85
_IE             DATA 0xa8
_IEN0           DATA 0xa8
_IEN1           DATA 0xb1
_IPH0           DATA 0xb7
_IP             DATA 0xb8
_IPL0           DATA 0xb8
_IPH1           DATA 0xb3
_IPL1           DATA 0xb2
_P0             DATA 0x80
_P1             DATA 0x90
_P2             DATA 0xa0
_P3             DATA 0xb0
_P4             DATA 0xc0
_P0M0           DATA 0xe6
_P0M1           DATA 0xe7
_P1M0           DATA 0xd6
_P1M1           DATA 0xd7
_P2M0           DATA 0xce
_P2M1           DATA 0xcf
_P3M0           DATA 0xc6
_P3M1           DATA 0xc7
_P4M0           DATA 0xbe
_P4M1           DATA 0xbf
_SCON           DATA 0x98
_SBUF           DATA 0x99
_SADEN          DATA 0xb9
_SADDR          DATA 0xa9
_BDRCON         DATA 0x9b
_BRL            DATA 0x9a
_TCON           DATA 0x88
_TMOD           DATA 0x89
_TCONB          DATA 0x91
_TL0            DATA 0x8a
_TH0            DATA 0x8c
_TL1            DATA 0x8b
_TH1            DATA 0x8d
_RL0            DATA 0xf2
_RH0            DATA 0xf4
_RL1            DATA 0xf3
_RH1            DATA 0xf5
_WDTRST         DATA 0xa6
_WDTPRG         DATA 0xa7
_T2CON          DATA 0xc8
_T2MOD          DATA 0xc9
_RCAP2H         DATA 0xcb
_RCAP2L         DATA 0xca
_TH2            DATA 0xcd
_TL2            DATA 0xcc
_SPCON          DATA 0xc3
_SPSTA          DATA 0xc4
_SPDAT          DATA 0xc5
_SSCON          DATA 0x93
_SSCS           DATA 0x94
_SSDAT          DATA 0x95
_SSADR          DATA 0x96
_KBLS           DATA 0x9c
_KBE            DATA 0x9d
_KBF            DATA 0x9e
_KBMOD          DATA 0x9f
_BMSEL          DATA 0x92
_FCON           DATA 0xd2
_EECON          DATA 0xd2
_ACSRA          DATA 0xa3
_ACSRB          DATA 0xab
_AREF           DATA 0xbd
_DADC           DATA 0xa4
_DADI           DATA 0xa5
_DADL           DATA 0xac
_DADH           DATA 0xad
_CCON           DATA 0xd8
_CMOD           DATA 0xd9
_CL             DATA 0xe9
_CH             DATA 0xf9
_CCAPM0         DATA 0xda
_CCAPM1         DATA 0xdb
_CCAPM2         DATA 0xdc
_CCAPM3         DATA 0xdd
_CCAPM4         DATA 0xde
_CCAP0H         DATA 0xfa
_CCAP1H         DATA 0xfb
_CCAP2H         DATA 0xfc
_CCAP3H         DATA 0xfd
_CCAP4H         DATA 0xfe
_CCAP0L         DATA 0xea
_CCAP1L         DATA 0xeb
_CCAP2L         DATA 0xec
_CCAP3L         DATA 0xed
_CCAP4L         DATA 0xee
;--------------------------------------------------------
; special function bits
;--------------------------------------------------------
_ACC_0          BIT 0xe0
_ACC_1          BIT 0xe1
_ACC_2          BIT 0xe2
_ACC_3          BIT 0xe3
_ACC_4          BIT 0xe4
_ACC_5          BIT 0xe5
_ACC_6          BIT 0xe6
_ACC_7          BIT 0xe7
_B_0            BIT 0xf0
_B_1            BIT 0xf1
_B_2            BIT 0xf2
_B_3            BIT 0xf3
_B_4            BIT 0xf4
_B_5            BIT 0xf5
_B_6            BIT 0xf6
_B_7            BIT 0xf7
_P              BIT 0xd0
_F1             BIT 0xd1
_OV             BIT 0xd2
_RS0            BIT 0xd3
_RS1            BIT 0xd4
_F0             BIT 0xd5
_AC             BIT 0xd6
_CY             BIT 0xd7
_EX0            BIT 0xa8
_ET0            BIT 0xa9
_EX1            BIT 0xaa
_ET1            BIT 0xab
_ES             BIT 0xac
_ET2            BIT 0xad
_EC             BIT 0xae
_EA             BIT 0xaf
_PX0            BIT 0xb8
_PT0            BIT 0xb9
_PX1            BIT 0xba
_PT1            BIT 0xbb
_PS             BIT 0xbc
_PT2            BIT 0xbd
_IP0D           BIT 0xbf
_PPCL           BIT 0xbe
_PT2L           BIT 0xbd
_PLS            BIT 0xbc
_PT1L           BIT 0xbb
_PX1L           BIT 0xba
_PT0L           BIT 0xb9
_PX0L           BIT 0xb8
_P0_0           BIT 0x80
_P0_1           BIT 0x81
_P0_2           BIT 0x82
_P0_3           BIT 0x83
_P0_4           BIT 0x84
_P0_5           BIT 0x85
_P0_6           BIT 0x86
_P0_7           BIT 0x87
_P1_0           BIT 0x90
_P1_1           BIT 0x91
_P1_2           BIT 0x92
_P1_3           BIT 0x93
_P1_4           BIT 0x94
_P1_5           BIT 0x95
_P1_6           BIT 0x96
_P1_7           BIT 0x97
_P2_0           BIT 0xa0
_P2_1           BIT 0xa1
_P2_2           BIT 0xa2
_P2_3           BIT 0xa3
_P2_4           BIT 0xa4
_P2_5           BIT 0xa5
_P2_6           BIT 0xa6
_P2_7           BIT 0xa7
_P3_0           BIT 0xb0
_P3_1           BIT 0xb1
_P3_2           BIT 0xb2
_P3_3           BIT 0xb3
_P3_4           BIT 0xb4
_P3_5           BIT 0xb5
_P3_6           BIT 0xb6
_P3_7           BIT 0xb7
_RXD            BIT 0xb0
_TXD            BIT 0xb1
_INT0           BIT 0xb2
_INT1           BIT 0xb3
_T0             BIT 0xb4
_T1             BIT 0xb5
_WR             BIT 0xb6
_RD             BIT 0xb7
_P4_0           BIT 0xc0
_P4_1           BIT 0xc1
_P4_2           BIT 0xc2
_P4_3           BIT 0xc3
_P4_4           BIT 0xc4
_P4_5           BIT 0xc5
_P4_6           BIT 0xc6
_P4_7           BIT 0xc7
_RI             BIT 0x98
_TI             BIT 0x99
_RB8            BIT 0x9a
_TB8            BIT 0x9b
_REN            BIT 0x9c
_SM2            BIT 0x9d
_SM1            BIT 0x9e
_SM0            BIT 0x9f
_IT0            BIT 0x88
_IE0            BIT 0x89
_IT1            BIT 0x8a
_IE1            BIT 0x8b
_TR0            BIT 0x8c
_TF0            BIT 0x8d
_TR1            BIT 0x8e
_TF1            BIT 0x8f
_CP_RL2         BIT 0xc8
_C_T2           BIT 0xc9
_TR2            BIT 0xca
_EXEN2          BIT 0xcb
_TCLK           BIT 0xcc
_RCLK           BIT 0xcd
_EXF2           BIT 0xce
_TF2            BIT 0xcf
_CF             BIT 0xdf
_CR             BIT 0xde
_CCF4           BIT 0xdc
_CCF3           BIT 0xdb
_CCF2           BIT 0xda
_CCF1           BIT 0xd9
_CCF0           BIT 0xd8
;--------------------------------------------------------
; overlayable register banks
;--------------------------------------------------------
	rbank0 segment data overlay
;--------------------------------------------------------
; overlayable bit register bank
;--------------------------------------------------------
	rseg BIT_BANK
bits:
	ds 1
	b0 equ  bits.0 
	b1 equ  bits.1 
	b2 equ  bits.2 
	b3 equ  bits.3 
	b4 equ  bits.4 
	b5 equ  bits.5 
	b6 equ  bits.6 
	b7 equ  bits.7 
;--------------------------------------------------------
; internal ram data
;--------------------------------------------------------
	rseg R_DSEG
_pwmCount:
	ds 2
_distCount:
	ds 2
_pwmLeft:
	ds 2
_pwmRight:
	ds 2
_direction:
	ds 2
_tether:
	ds 2
_leftSensor:
	ds 2
_rightSensor:
	ds 2
_pwmLeftTemp:
	ds 2
_pwmRightTemp:
	ds 2
_distanceLeft:
	ds 4
_distanceRight:
	ds 4
_instruction:
	ds 2
_gotInst:
	ds 2
_Stage:
	ds 2
_turn:
	ds 1
_leftHistory:
	ds 3
_rightHistory:
	ds 3
_smooth_move_PARM_2:
	ds 2
_smooth_move_history_1_113:
	ds 3
_smooth_move_N_1_114:
	ds 2
_smooth_move_sloc0_1_0:
	ds 2
;--------------------------------------------------------
; overlayable items in internal ram 
;--------------------------------------------------------
	rseg	R_OSEG
;--------------------------------------------------------
; indirectly addressable internal ram data
;--------------------------------------------------------
	rseg R_ISEG
;--------------------------------------------------------
; absolute internal ram data
;--------------------------------------------------------
	DSEG
;--------------------------------------------------------
; bit data
;--------------------------------------------------------
	rseg R_BSEG
_pwmCounter_sloc0_1_0:
	DBIT	1
;--------------------------------------------------------
; paged external ram data
;--------------------------------------------------------
	rseg R_PSEG
;--------------------------------------------------------
; external ram data
;--------------------------------------------------------
	rseg R_XSEG
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	XSEG
;--------------------------------------------------------
; external initialized ram data
;--------------------------------------------------------
	rseg R_IXSEG
	rseg R_HOME
	rseg R_GSINIT
	rseg R_CSEG
;--------------------------------------------------------
; Reset entry point and interrupt vectors
;--------------------------------------------------------
	CSEG at 0x0000
	ljmp	_crt0
	CSEG at 0x000b
	ljmp	_pwmCounter
	CSEG at 0x001b
	ljmp	_beaconSignal
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	rseg R_HOME
	rseg R_GSINIT
	rseg R_GSINIT
;--------------------------------------------------------
; data variables initialization
;--------------------------------------------------------
	rseg R_DINIT
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:74: volatile unsigned int pwmCount = 0;
	clr	a
	mov	_pwmCount,a
	mov	(_pwmCount + 1),a
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:75: volatile unsigned int distCount = 0;
	clr	a
	mov	_distCount,a
	mov	(_distCount + 1),a
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:80: volatile unsigned int leftSensor = 0;
	clr	a
	mov	_leftSensor,a
	mov	(_leftSensor + 1),a
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:81: volatile unsigned int rightSensor = 0;
	clr	a
	mov	_rightSensor,a
	mov	(_rightSensor + 1),a
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:82: volatile int pwmLeftTemp = 0;
	clr	a
	mov	_pwmLeftTemp,a
	mov	(_pwmLeftTemp + 1),a
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:83: volatile int pwmRightTemp = 0;
	clr	a
	mov	_pwmRightTemp,a
	mov	(_pwmRightTemp + 1),a
	; The linker places a 'ret' at the end of segment R_DINIT.
;--------------------------------------------------------
; code
;--------------------------------------------------------
	rseg R_CSEG
;------------------------------------------------------------
;Allocation info for local variables in function 'pwmCounter'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:118: void pwmCounter() interrupt 1
;	-----------------------------------------
;	 function pwmCounter
;	-----------------------------------------
_pwmCounter:
	using	0
	push	bits
	push	acc
	push	b
	push	dpl
	push	dph
	push	(0+2)
	push	(0+3)
	push	(0+4)
	push	(0+5)
	push	(0+6)
	push	(0+7)
	push	(0+0)
	push	(0+1)
	push	psw
	mov	psw,#0x00
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:120: if(++pwmCount > 99)
	mov	a,#0x01
	add	a,_pwmCount
	mov	_pwmCount,a
	clr	a
	addc	a,(_pwmCount + 1)
	mov	(_pwmCount + 1),a
	clr	c
	mov	a,#0x63
	subb	a,_pwmCount
	clr	a
	subb	a,(_pwmCount + 1)
	jnc	L002002?
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:122: pwmCount = 0;
	clr	a
	mov	_pwmCount,a
	mov	(_pwmCount + 1),a
L002002?:
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:126: if (++distCount > 999)
	mov	a,#0x01
	add	a,_distCount
	mov	_distCount,a
	clr	a
	addc	a,(_distCount + 1)
	mov	(_distCount + 1),a
	clr	c
	mov	a,#0xE7
	subb	a,_distCount
	mov	a,#0x03
	subb	a,(_distCount + 1)
	jnc	L002004?
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:128: distCount = 0;	
	clr	a
	mov	_distCount,a
	mov	(_distCount + 1),a
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:129: Stage = 6;
	mov	_Stage,#0x06
	clr	a
	mov	(_Stage + 1),a
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:130: printf("DL %3.1f - DR %3.1f - Stage %3.1f(%d)\r", distanceLeft, distanceRight, PRESETS[Stage], Stage);
	mov	r2,_Stage
	mov	a,(_Stage + 1)
	xch	a,r2
	add	a,acc
	xch	a,r2
	rlc	a
	xch	a,r2
	add	a,acc
	xch	a,r2
	rlc	a
	mov	r3,a
	mov	a,r2
	add	a,#_PRESETS
	mov	dpl,a
	mov	a,r3
	addc	a,#(_PRESETS >> 8)
	mov	dph,a
	clr	a
	movc	a,@a+dptr
	mov	r2,a
	inc	dptr
	clr	a
	movc	a,@a+dptr
	mov	r3,a
	inc	dptr
	clr	a
	movc	a,@a+dptr
	mov	r4,a
	inc	dptr
	clr	a
	movc	a,@a+dptr
	mov	r5,a
	push	_Stage
	push	(_Stage + 1)
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	push	_distanceRight
	push	(_distanceRight + 1)
	push	(_distanceRight + 2)
	push	(_distanceRight + 3)
	push	_distanceLeft
	push	(_distanceLeft + 1)
	push	(_distanceLeft + 2)
	push	(_distanceLeft + 3)
	mov	a,#__str_0
	push	acc
	mov	a,#(__str_0 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	lcall	_printf
	mov	a,sp
	add	a,#0xef
	mov	sp,a
L002004?:
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:134: if(pwmLeft > 0)
	clr	c
	clr	a
	subb	a,_pwmLeft
	clr	a
	xrl	a,#0x80
	mov	b,(_pwmLeft + 1)
	xrl	b,#0x80
	subb	a,b
	jnc	L002008?
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:136: P0_1 = (pwmLeft > pwmCount) ? 0:1;
	mov	r2,_pwmLeft
	mov	r3,(_pwmLeft + 1)
	clr	c
	mov	a,_pwmCount
	subb	a,r2
	mov	a,(_pwmCount + 1)
	subb	a,r3
	mov  _pwmCounter_sloc0_1_0,c
	cpl	c
	mov	_P0_1,c
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:137: P0_0 = 1;
	setb	_P0_0
	sjmp	L002009?
L002008?:
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:139: else if(pwmLeft < 0)
	mov	a,(_pwmLeft + 1)
	jnb	acc.7,L002009?
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:142: P0_0 = ((-1) * pwmLeft > pwmCount) ? 0:1;
	clr	c
	clr	a
	subb	a,_pwmLeft
	mov	r2,a
	clr	a
	subb	a,(_pwmLeft + 1)
	mov	r3,a
	clr	c
	mov	a,_pwmCount
	subb	a,r2
	mov	a,(_pwmCount + 1)
	subb	a,r3
	mov  _pwmCounter_sloc0_1_0,c
	cpl	c
	mov	_P0_0,c
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:143: P0_1 = 1;
	setb	_P0_1
L002009?:
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:145: if(pwmLeft==0)
	mov	a,_pwmLeft
	orl	a,(_pwmLeft + 1)
	jnz	L002011?
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:147: P0_1 = P0_0 = 1;
	setb	_P0_0
	mov	c,_P0_0
	mov	_P0_1,c
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:149: P1_0 = ((-1) * pwmLeft > pwmCount) ? 0:1;
	clr	c
	clr	a
	subb	a,_pwmLeft
	mov	r2,a
	clr	a
	subb	a,(_pwmLeft + 1)
	mov	r3,a
	clr	c
	mov	a,_pwmCount
	subb	a,r2
	mov	a,(_pwmCount + 1)
	subb	a,r3
	mov  _pwmCounter_sloc0_1_0,c
	cpl	c
	mov	_P1_0,c
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:150: P1_1 = 1;
	setb	_P1_1
	sjmp	L002012?
L002011?:
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:153: P1_0 = 1;
	setb	_P1_0
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:154: P1_1 = 1;
	setb	_P1_1
L002012?:
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:158: if(pwmRight > 0)
	clr	c
	clr	a
	subb	a,_pwmRight
	clr	a
	xrl	a,#0x80
	mov	b,(_pwmRight + 1)
	xrl	b,#0x80
	subb	a,b
	jnc	L002016?
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:160: P0_4 = (pwmRight > pwmCount) ? 0:1;
	mov	r2,_pwmRight
	mov	r3,(_pwmRight + 1)
	clr	c
	mov	a,_pwmCount
	subb	a,r2
	mov	a,(_pwmCount + 1)
	subb	a,r3
	mov  _pwmCounter_sloc0_1_0,c
	cpl	c
	mov	_P0_4,c
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:161: P0_3 = 1;
	setb	_P0_3
	sjmp	L002017?
L002016?:
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:163: else if(pwmRight < 0)
	mov	a,(_pwmRight + 1)
	jnb	acc.7,L002017?
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:166: P0_3 = ((-1) * pwmRight > pwmCount) ? 0:1;
	clr	c
	clr	a
	subb	a,_pwmRight
	mov	r2,a
	clr	a
	subb	a,(_pwmRight + 1)
	mov	r3,a
	clr	c
	mov	a,_pwmCount
	subb	a,r2
	mov	a,(_pwmCount + 1)
	subb	a,r3
	mov  _pwmCounter_sloc0_1_0,c
	cpl	c
	mov	_P0_3,c
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:167: P0_4 = 1;
	setb	_P0_4
L002017?:
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:169: if(pwmRight==0)
	mov	a,_pwmRight
	orl	a,(_pwmRight + 1)
	jnz	L002020?
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:171: P0_4 = P0_3 = 1;
	setb	_P0_3
	mov	c,_P0_3
	mov	_P0_4,c
L002020?:
	pop	psw
	pop	(0+1)
	pop	(0+0)
	pop	(0+7)
	pop	(0+6)
	pop	(0+5)
	pop	(0+4)
	pop	(0+3)
	pop	(0+2)
	pop	dph
	pop	dpl
	pop	b
	pop	acc
	pop	bits
	reti
;------------------------------------------------------------
;Allocation info for local variables in function 'beaconSignal'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:176: void beaconSignal() interrupt 3
;	-----------------------------------------
;	 function beaconSignal
;	-----------------------------------------
_beaconSignal:
	push	bits
	push	acc
	push	b
	push	dpl
	push	dph
	push	(0+2)
	push	(0+3)
	push	(0+4)
	push	(0+5)
	push	(0+6)
	push	(0+7)
	push	(0+0)
	push	(0+1)
	push	psw
	mov	psw,#0x00
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:178: if (voltage(0) < 0.1) 
	mov	dpl,#0x00
	lcall	_voltage
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	mov	a,#0xCD
	push	acc
	mov	a,#0xCC
	push	acc
	push	acc
	mov	a,#0x3D
	push	acc
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,r5
	lcall	___fslt
	mov	r2,dpl
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	mov	a,r2
	jz	L003006?
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:180: ET0 = 0;
	clr	_ET0
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:181: pwmLeftTemp = pwmLeft;
	mov	_pwmLeftTemp,_pwmLeft
	mov	(_pwmLeftTemp + 1),(_pwmLeft + 1)
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:182: pwmRightTemp = pwmRight;
	mov	_pwmRightTemp,_pwmRight
	mov	(_pwmRightTemp + 1),(_pwmRight + 1)
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:183: while(voltage(0) < 0.1);
L003001?:
	mov	dpl,#0x00
	lcall	_voltage
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	mov	a,#0xCD
	push	acc
	mov	a,#0xCC
	push	acc
	push	acc
	mov	a,#0x3D
	push	acc
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,r5
	lcall	___fslt
	mov	r2,dpl
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	mov	a,r2
	jnz	L003001?
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:184: instruction = getSig();
	lcall	_getSig
	mov	_instruction,dpl
	mov	(_instruction + 1),dph
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:185: pwmLeft = pwmLeftTemp;
	mov	_pwmLeft,_pwmLeftTemp
	mov	(_pwmLeft + 1),(_pwmLeftTemp + 1)
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:186: pwmRight = pwmRightTemp;
	mov	_pwmRight,_pwmRightTemp
	mov	(_pwmRight + 1),(_pwmRightTemp + 1)
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:187: ET0 =  1;
	setb	_ET0
L003006?:
	pop	psw
	pop	(0+1)
	pop	(0+0)
	pop	(0+7)
	pop	(0+6)
	pop	(0+5)
	pop	(0+4)
	pop	(0+3)
	pop	(0+2)
	pop	dph
	pop	dpl
	pop	b
	pop	acc
	pop	bits
	reti
;------------------------------------------------------------
;Allocation info for local variables in function '_c51_external_startup'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:193: unsigned char _c51_external_startup(void)
;	-----------------------------------------
;	 function _c51_external_startup
;	-----------------------------------------
__c51_external_startup:
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:196: P0M0 = 0;	P0M1 = 0;
	mov	_P0M0,#0x00
	mov	_P0M1,#0x00
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:197: P1M0 = 0;	P1M1 = 0;
	mov	_P1M0,#0x00
	mov	_P1M1,#0x00
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:198: P2M0 = 0;	P2M1 = 0;
	mov	_P2M0,#0x00
	mov	_P2M1,#0x00
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:199: P3M0 = 0;	P3M1 = 0;
	mov	_P3M0,#0x00
	mov	_P3M1,#0x00
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:200: AUXR = 0B_0001_0001; // 1152 bytes of internal XDATA, P4.4 is a general purpose I/O
	mov	_AUXR,#0x11
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:201: P4M0 = 0;	P4M1 = 0;
	mov	_P4M0,#0x00
	mov	_P4M1,#0x00
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:205: PCON |= 0x80;
	orl	_PCON,#0x80
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:206: SCON = 0x52;
	mov	_SCON,#0x52
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:207: BDRCON = 0;
	mov	_BDRCON,#0x00
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:208: BRL = BRG_VAL;
	mov	_BRL,#0xFA
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:209: BDRCON = BRR | TBCK | RBCK | SPD;
	mov	_BDRCON,#0x1E
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:211: TMOD = 0B_0001_0001;	// Timer 0 as 16-bit timer	
	mov	_TMOD,#0x11
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:212: TH0 = RH0 = TIMER0_RELOAD_VALUE / 0x100;
	mov	_RH0,#0xFF
	mov	_TH0,#0xFF
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:213: TL0 = RL0 = TIMER0_RELOAD_VALUE % 0x100;
	mov	_RL0,#0x48
	mov	_TL0,#0x48
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:214: TH1 = RH1 = TIMER1_RELOAD_VALUE / 0x100;
	mov	_RH1,#0xFE
	mov	_TH1,#0xFE
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:215: TL1 = RL1 = TIMER1_RELOAD_VALUE % 0x100;
	mov	_RL1,#0x90
	mov	_TL1,#0x90
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:216: TR0 = 1;
	setb	_TR0
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:217: TR1 = 0;
	clr	_TR1
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:218: ET0 = 1;	// Enable timer 0 interrupt
	setb	_ET0
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:221: EA = 1; 	// Enable global interrupts
	setb	_EA
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:222: tether=0;
	clr	a
	mov	_tether,a
	mov	(_tether + 1),a
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:223: direction=1;
	mov	_direction,#0x01
	clr	a
	mov	(_direction + 1),a
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:224: P2_2=1;
	setb	_P2_2
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:225: P2_1=1;
	setb	_P2_1
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:226: P2_0=1;
	setb	_P2_0
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:227: printf(CLEAR_SCREEN);
	mov	a,#__str_1
	push	acc
	mov	a,#(__str_1 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	lcall	_printf
	dec	sp
	dec	sp
	dec	sp
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:228: return 0;
	mov	dpl,#0x00
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'main'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:235: int main (void)
;	-----------------------------------------
;	 function main
;	-----------------------------------------
_main:
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:238: pwmLeft = 0;
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:239: pwmRight = 0;
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:240: instruction = 0;
	clr	a
	mov	_pwmLeft,a
	mov	(_pwmLeft + 1),a
	mov	_pwmRight,a
	mov	(_pwmRight + 1),a
	mov	_instruction,a
	mov	(_instruction + 1),a
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:241: leftHistory = (int *)calloc(MEMORY_LENGTH, sizeof(int));
	mov	dptr,#_MEMORY_LENGTH
	clr	a
	movc	a,@a+dptr
	mov	r2,a
	mov	a,#0x01
	movc	a,@a+dptr
	mov	r3,a
	mov	_calloc_PARM_2,#0x02
	clr	a
	mov	(_calloc_PARM_2 + 1),a
	mov	dpl,r2
	mov	dph,r3
	lcall	_calloc
	mov	r2,dpl
	mov	r3,dph
	mov	_leftHistory,r2
	mov	(_leftHistory + 1),r3
	mov	(_leftHistory + 2),#0x00
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:242: rightHistory = (int *)calloc(MEMORY_LENGTH, sizeof(int));
	mov	dptr,#_MEMORY_LENGTH
	clr	a
	movc	a,@a+dptr
	mov	r2,a
	mov	a,#0x01
	movc	a,@a+dptr
	mov	r3,a
	mov	_calloc_PARM_2,#0x02
	clr	a
	mov	(_calloc_PARM_2 + 1),a
	mov	dpl,r2
	mov	dph,r3
	lcall	_calloc
	mov	r2,dpl
	mov	r3,dph
	mov	_rightHistory,r2
	mov	(_rightHistory + 1),r3
	mov	(_rightHistory + 2),#0x00
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:247: while (instruction == 0)
L005001?:
	mov	a,_instruction
	orl	a,(_instruction + 1)
	jnz	L005001?
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:256: moveCar();
	lcall	_moveCar
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:257: P2_2=1;
	setb	_P2_2
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:258: P2_1=1;
	setb	_P2_1
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:259: P2_0=0;
	clr	_P2_0
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:301: return 0;
	sjmp	L005001?
;------------------------------------------------------------
;Allocation info for local variables in function 'getDistance'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:312: float getDistance() 
;	-----------------------------------------
;	 function getDistance
;	-----------------------------------------
_getDistance:
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:314: distanceRight = (float)GetADC(0)*1.2;
	mov	dpl,#0x00
	lcall	_GetADC
	lcall	___uint2fs
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	mov	dptr,#0x999A
	mov	b,#0x99
	mov	a,#0x3F
	lcall	___fsmul
	mov	_distanceRight,dpl
	mov	(_distanceRight + 1),dph
	mov	(_distanceRight + 2),b
	mov	(_distanceRight + 3),a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:315: distanceLeft = (float)GetADC(1);
	mov	dpl,#0x01
	lcall	_GetADC
	lcall	___uint2fs
	mov	_distanceLeft,dpl
	mov	(_distanceLeft + 1),dph
	mov	(_distanceLeft + 2),b
	mov	(_distanceLeft + 3),a
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:316: return ((distanceRight + distanceLeft)/2);
	push	_distanceLeft
	push	(_distanceLeft + 1)
	push	(_distanceLeft + 2)
	push	(_distanceLeft + 3)
	mov	dpl,_distanceRight
	mov	dph,(_distanceRight + 1)
	mov	b,(_distanceRight + 2)
	mov	a,(_distanceRight + 3)
	lcall	___fsadd
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	clr	a
	push	acc
	push	acc
	push	acc
	mov	a,#0x40
	push	acc
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,r5
	lcall	___fsdiv
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,r5
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'turnRatio'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:319: int turnRatio()
;	-----------------------------------------
;	 function turnRatio
;	-----------------------------------------
_turnRatio:
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:321: if (getDistance() < 50.0)
	lcall	_getDistance
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	clr	a
	push	acc
	push	acc
	mov	a,#0x48
	push	acc
	mov	a,#0x42
	push	acc
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,r5
	lcall	___fslt
	mov	r2,dpl
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	mov	a,r2
	jz	L007002?
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:322: return 0;
	mov	dptr,#0x0000
	ret
L007002?:
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:324: if ( ((distanceRight - distanceLeft)/(distanceRight + distanceLeft)) > 0.2 )
	push	_distanceLeft
	push	(_distanceLeft + 1)
	push	(_distanceLeft + 2)
	push	(_distanceLeft + 3)
	mov	dpl,_distanceRight
	mov	dph,(_distanceRight + 1)
	mov	b,(_distanceRight + 2)
	mov	a,(_distanceRight + 3)
	lcall	___fssub
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	push	_distanceLeft
	push	(_distanceLeft + 1)
	push	(_distanceLeft + 2)
	push	(_distanceLeft + 3)
	mov	dpl,_distanceRight
	mov	dph,(_distanceRight + 1)
	mov	b,(_distanceRight + 2)
	mov	a,(_distanceRight + 3)
	lcall	___fsadd
	mov	r6,dpl
	mov	r7,dph
	mov	r0,b
	mov	r1,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
	push	ar6
	push	ar7
	push	ar0
	push	ar1
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,r5
	lcall	___fsdiv
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	mov	a,#0xCD
	push	acc
	mov	a,#0xCC
	push	acc
	mov	a,#0x4C
	push	acc
	mov	a,#0x3E
	push	acc
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,r5
	lcall	___fsgt
	mov	r2,dpl
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	mov	a,r2
	jz	L007004?
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:325: return -1;
	mov	dptr,#0xFFFF
	ret
L007004?:
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:327: if ( ((distanceLeft - distanceRight)/(distanceRight + distanceLeft)) > 0.1 )
	push	_distanceRight
	push	(_distanceRight + 1)
	push	(_distanceRight + 2)
	push	(_distanceRight + 3)
	mov	dpl,_distanceLeft
	mov	dph,(_distanceLeft + 1)
	mov	b,(_distanceLeft + 2)
	mov	a,(_distanceLeft + 3)
	lcall	___fssub
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	push	_distanceLeft
	push	(_distanceLeft + 1)
	push	(_distanceLeft + 2)
	push	(_distanceLeft + 3)
	mov	dpl,_distanceRight
	mov	dph,(_distanceRight + 1)
	mov	b,(_distanceRight + 2)
	mov	a,(_distanceRight + 3)
	lcall	___fsadd
	mov	r6,dpl
	mov	r7,dph
	mov	r0,b
	mov	r1,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
	push	ar6
	push	ar7
	push	ar0
	push	ar1
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,r5
	lcall	___fsdiv
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	mov	a,#0xCD
	push	acc
	mov	a,#0xCC
	push	acc
	push	acc
	mov	a,#0x3D
	push	acc
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,r5
	lcall	___fsgt
	mov	r2,dpl
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	mov	a,r2
	jz	L007006?
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:328: return 1;
	mov	dptr,#0x0001
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:330: return 0;
	ret
L007006?:
	mov	dptr,#0x0000
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'moveCar'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:339: void moveCar()
;	-----------------------------------------
;	 function moveCar
;	-----------------------------------------
_moveCar:
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:342: if(turnRatio() == 1)
	lcall	_turnRatio
	mov	r2,dpl
	mov	r3,dph
	cjne	r2,#0x01,L008005?
	cjne	r3,#0x00,L008005?
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:344: pwmLeft = smooth_move(leftHistory, TURNSPEED);
	mov	dptr,#_TURNSPEED
	clr	a
	movc	a,@a+dptr
	mov	_smooth_move_PARM_2,a
	mov	a,#0x01
	movc	a,@a+dptr
	mov	(_smooth_move_PARM_2 + 1),a
	mov	dpl,_leftHistory
	mov	dph,(_leftHistory + 1)
	mov	b,(_leftHistory + 2)
	lcall	_smooth_move
	mov	_pwmLeft,dpl
	mov	(_pwmLeft + 1),dph
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:345: pwmRight= smooth_move(rightHistory, -TURNSPEED);
	mov	dptr,#_TURNSPEED
	clr	a
	movc	a,@a+dptr
	mov	r2,a
	mov	a,#0x01
	movc	a,@a+dptr
	mov	r3,a
	clr	c
	clr	a
	subb	a,r2
	mov	_smooth_move_PARM_2,a
	clr	a
	subb	a,r3
	mov	(_smooth_move_PARM_2 + 1),a
	mov	dpl,_rightHistory
	mov	dph,(_rightHistory + 1)
	mov	b,(_rightHistory + 2)
	lcall	_smooth_move
	mov	_pwmRight,dpl
	mov	(_pwmRight + 1),dph
	sjmp	L008006?
L008005?:
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:347: else if(turnRatio() == -1)//(distanceLeft > distanceRight+ANGLEBUFFER)
	lcall	_turnRatio
	mov	r2,dpl
	mov	r3,dph
	cjne	r2,#0xFF,L008002?
	cjne	r3,#0xFF,L008002?
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:349: pwmLeft = smooth_move(leftHistory, -TURNSPEED);
	mov	dptr,#_TURNSPEED
	clr	a
	movc	a,@a+dptr
	mov	r2,a
	mov	a,#0x01
	movc	a,@a+dptr
	mov	r3,a
	clr	c
	clr	a
	subb	a,r2
	mov	_smooth_move_PARM_2,a
	clr	a
	subb	a,r3
	mov	(_smooth_move_PARM_2 + 1),a
	mov	dpl,_leftHistory
	mov	dph,(_leftHistory + 1)
	mov	b,(_leftHistory + 2)
	lcall	_smooth_move
	mov	_pwmLeft,dpl
	mov	(_pwmLeft + 1),dph
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:350: pwmRight = smooth_move(rightHistory, TURNSPEED);
	mov	dptr,#_TURNSPEED
	clr	a
	movc	a,@a+dptr
	mov	_smooth_move_PARM_2,a
	mov	a,#0x01
	movc	a,@a+dptr
	mov	(_smooth_move_PARM_2 + 1),a
	mov	dpl,_rightHistory
	mov	dph,(_rightHistory + 1)
	mov	b,(_rightHistory + 2)
	lcall	_smooth_move
	mov	_pwmRight,dpl
	mov	(_pwmRight + 1),dph
	sjmp	L008006?
L008002?:
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:353: pwmLeft = smooth_move(leftHistory, 0);
	clr	a
	mov	_smooth_move_PARM_2,a
	mov	(_smooth_move_PARM_2 + 1),a
	mov	dpl,_leftHistory
	mov	dph,(_leftHistory + 1)
	mov	b,(_leftHistory + 2)
	lcall	_smooth_move
	mov	_pwmLeft,dpl
	mov	(_pwmLeft + 1),dph
L008006?:
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:354: pwmRight = smooth_move(rightHistory, 0);
	clr	a
	mov	_smooth_move_PARM_2,a
	mov	(_smooth_move_PARM_2 + 1),a
	mov	dpl,_rightHistory
	mov	dph,(_rightHistory + 1)
	mov	b,(_rightHistory + 2)
	lcall	_smooth_move
	mov	_pwmRight,dpl
	mov	(_pwmRight + 1),dph
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:357: if ((getDistance()+DISTANCEBUFFER) < PRESETS[Stage])
	lcall	_getDistance
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	mov	dptr,#_DISTANCEBUFFER
	clr	a
	movc	a,@a+dptr
	push	acc
	mov	a,#0x01
	movc	a,@a+dptr
	push	acc
	mov	a,#0x02
	movc	a,@a+dptr
	push	acc
	mov	a,#0x03
	movc	a,@a+dptr
	push	acc
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,r5
	lcall	___fsadd
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	mov	r6,_Stage
	mov	a,(_Stage + 1)
	xch	a,r6
	add	a,acc
	xch	a,r6
	rlc	a
	xch	a,r6
	add	a,acc
	xch	a,r6
	rlc	a
	mov	r7,a
	mov	a,r6
	add	a,#_PRESETS
	mov	dpl,a
	mov	a,r7
	addc	a,#(_PRESETS >> 8)
	mov	dph,a
	clr	a
	movc	a,@a+dptr
	mov	r6,a
	inc	dptr
	clr	a
	movc	a,@a+dptr
	mov	r7,a
	inc	dptr
	clr	a
	movc	a,@a+dptr
	mov	r0,a
	inc	dptr
	clr	a
	movc	a,@a+dptr
	mov	r1,a
	push	ar6
	push	ar7
	push	ar0
	push	ar1
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,r5
	lcall	___fslt
	mov	r2,dpl
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	mov	a,r2
	jz	L008011?
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:359: P2_2=1;
	setb	_P2_2
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:360: P2_1=0;
	clr	_P2_1
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:361: P2_0=1;
	setb	_P2_0
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:362: pwmLeft = smooth_move(leftHistory, MOVESPEED);
	mov	dptr,#_MOVESPEED
	clr	a
	movc	a,@a+dptr
	mov	_smooth_move_PARM_2,a
	mov	a,#0x01
	movc	a,@a+dptr
	mov	(_smooth_move_PARM_2 + 1),a
	mov	dpl,_leftHistory
	mov	dph,(_leftHistory + 1)
	mov	b,(_leftHistory + 2)
	lcall	_smooth_move
	mov	_pwmLeft,dpl
	mov	(_pwmLeft + 1),dph
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:363: pwmRight = smooth_move(rightHistory, MOVESPEED);
	mov	dptr,#_MOVESPEED
	clr	a
	movc	a,@a+dptr
	mov	_smooth_move_PARM_2,a
	mov	a,#0x01
	movc	a,@a+dptr
	mov	(_smooth_move_PARM_2 + 1),a
	mov	dpl,_rightHistory
	mov	dph,(_rightHistory + 1)
	mov	b,(_rightHistory + 2)
	lcall	_smooth_move
	mov	_pwmRight,dpl
	mov	(_pwmRight + 1),dph
	ljmp	L008012?
L008011?:
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:366: else if (getDistance() > (PRESETS[Stage]+DISTANCEBUFFER))
	lcall	_getDistance
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	mov	r6,_Stage
	mov	a,(_Stage + 1)
	xch	a,r6
	add	a,acc
	xch	a,r6
	rlc	a
	xch	a,r6
	add	a,acc
	xch	a,r6
	rlc	a
	mov	r7,a
	mov	a,r6
	add	a,#_PRESETS
	mov	dpl,a
	mov	a,r7
	addc	a,#(_PRESETS >> 8)
	mov	dph,a
	clr	a
	movc	a,@a+dptr
	mov	r6,a
	inc	dptr
	clr	a
	movc	a,@a+dptr
	mov	r7,a
	inc	dptr
	clr	a
	movc	a,@a+dptr
	mov	r0,a
	inc	dptr
	clr	a
	movc	a,@a+dptr
	mov	r1,a
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	mov	dptr,#_DISTANCEBUFFER
	clr	a
	movc	a,@a+dptr
	push	acc
	mov	a,#0x01
	movc	a,@a+dptr
	push	acc
	mov	a,#0x02
	movc	a,@a+dptr
	push	acc
	mov	a,#0x03
	movc	a,@a+dptr
	push	acc
	mov	dpl,r6
	mov	dph,r7
	mov	b,r0
	mov	a,r1
	lcall	___fsadd
	mov	r6,dpl
	mov	r7,dph
	mov	r0,b
	mov	r1,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
	push	ar6
	push	ar7
	push	ar0
	push	ar1
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,r5
	lcall	___fsgt
	mov	r2,dpl
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	mov	a,r2
	jz	L008008?
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:368: P2_2=1;
	setb	_P2_2
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:369: P2_1=0;
	clr	_P2_1
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:370: P2_0=1;
	setb	_P2_0
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:371: pwmLeft = smooth_move(leftHistory, -MOVESPEED);
	mov	dptr,#_MOVESPEED
	clr	a
	movc	a,@a+dptr
	mov	r2,a
	mov	a,#0x01
	movc	a,@a+dptr
	mov	r3,a
	clr	c
	clr	a
	subb	a,r2
	mov	_smooth_move_PARM_2,a
	clr	a
	subb	a,r3
	mov	(_smooth_move_PARM_2 + 1),a
	mov	dpl,_leftHistory
	mov	dph,(_leftHistory + 1)
	mov	b,(_leftHistory + 2)
	lcall	_smooth_move
	mov	_pwmLeft,dpl
	mov	(_pwmLeft + 1),dph
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:372: pwmRight = smooth_move(rightHistory, -MOVESPEED);
	mov	dptr,#_MOVESPEED
	clr	a
	movc	a,@a+dptr
	mov	r2,a
	mov	a,#0x01
	movc	a,@a+dptr
	mov	r3,a
	clr	c
	clr	a
	subb	a,r2
	mov	_smooth_move_PARM_2,a
	clr	a
	subb	a,r3
	mov	(_smooth_move_PARM_2 + 1),a
	mov	dpl,_rightHistory
	mov	dph,(_rightHistory + 1)
	mov	b,(_rightHistory + 2)
	lcall	_smooth_move
	mov	_pwmRight,dpl
	mov	(_pwmRight + 1),dph
	sjmp	L008012?
L008008?:
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:376: pwmLeft = smooth_move(leftHistory, 0);
	clr	a
	mov	_smooth_move_PARM_2,a
	mov	(_smooth_move_PARM_2 + 1),a
	mov	dpl,_leftHistory
	mov	dph,(_leftHistory + 1)
	mov	b,(_leftHistory + 2)
	lcall	_smooth_move
	mov	_pwmLeft,dpl
	mov	(_pwmLeft + 1),dph
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:377: pwmRight = smooth_move(rightHistory, 0);
	clr	a
	mov	_smooth_move_PARM_2,a
	mov	(_smooth_move_PARM_2 + 1),a
	mov	dpl,_rightHistory
	mov	dph,(_rightHistory + 1)
	mov	b,(_rightHistory + 2)
	lcall	_smooth_move
	mov	_pwmRight,dpl
	mov	(_pwmRight + 1),dph
L008012?:
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:380: return;
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'smooth_move'
;------------------------------------------------------------
;target                    Allocated with name '_smooth_move_PARM_2'
;history                   Allocated with name '_smooth_move_history_1_113'
;N                         Allocated with name '_smooth_move_N_1_114'
;sloc0                     Allocated with name '_smooth_move_sloc0_1_0'
;------------------------------------------------------------
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:383: int smooth_move(int * history, int target)
;	-----------------------------------------
;	 function smooth_move
;	-----------------------------------------
_smooth_move:
	mov	_smooth_move_history_1_113,dpl
	mov	(_smooth_move_history_1_113 + 1),dph
	mov	(_smooth_move_history_1_113 + 2),b
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:385: int N = MEMORY_LENGTH;
	mov	dptr,#_MEMORY_LENGTH
	clr	a
	movc	a,@a+dptr
	mov	_smooth_move_N_1_114,a
	mov	a,#0x01
	movc	a,@a+dptr
	mov	(_smooth_move_N_1_114 + 1),a
	mov	r7,_smooth_move_N_1_114
	mov	r0,(_smooth_move_N_1_114 + 1)
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:387: history[0] = 0;
	mov	dpl,_smooth_move_history_1_113
	mov	dph,(_smooth_move_history_1_113 + 1)
	mov	b,(_smooth_move_history_1_113 + 2)
	clr	a
	lcall	__gptrput
	inc	dptr
	clr	a
	lcall	__gptrput
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:389: while(N-- > 1)
L009001?:
	mov	ar1,r7
	mov	ar5,r0
	dec	r7
	cjne	r7,#0xff,L009009?
	dec	r0
L009009?:
	clr	c
	mov	a,#0x01
	subb	a,r1
	clr	a
	xrl	a,#0x80
	mov	b,r5
	xrl	b,#0x80
	subb	a,b
	jc	L009010?
	ljmp	L009003?
L009010?:
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:391: history[0] += history[N];
	mov	dpl,_smooth_move_history_1_113
	mov	dph,(_smooth_move_history_1_113 + 1)
	mov	b,(_smooth_move_history_1_113 + 2)
	lcall	__gptrget
	mov	_smooth_move_sloc0_1_0,a
	inc	dptr
	lcall	__gptrget
	mov	(_smooth_move_sloc0_1_0 + 1),a
	mov	ar1,r7
	mov	a,r0
	xch	a,r1
	add	a,acc
	xch	a,r1
	rlc	a
	mov	r2,a
	mov	a,r1
	add	a,_smooth_move_history_1_113
	mov	r1,a
	mov	a,r2
	addc	a,(_smooth_move_history_1_113 + 1)
	mov	r2,a
	mov	r3,(_smooth_move_history_1_113 + 2)
	mov	dpl,r1
	mov	dph,r2
	mov	b,r3
	lcall	__gptrget
	mov	r4,a
	inc	dptr
	lcall	__gptrget
	mov	r5,a
	mov	a,r4
	add	a,_smooth_move_sloc0_1_0
	mov	r4,a
	mov	a,r5
	addc	a,(_smooth_move_sloc0_1_0 + 1)
	mov	r5,a
	mov	dpl,_smooth_move_history_1_113
	mov	dph,(_smooth_move_history_1_113 + 1)
	mov	b,(_smooth_move_history_1_113 + 2)
	mov	a,r4
	lcall	__gptrput
	inc	dptr
	mov	a,r5
	lcall	__gptrput
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:392: history[N] = history[N-1];	
	mov	a,r7
	add	a,#0xff
	mov	r4,a
	mov	a,r0
	addc	a,#0xff
	xch	a,r4
	add	a,acc
	xch	a,r4
	rlc	a
	mov	r5,a
	mov	a,r4
	add	a,_smooth_move_history_1_113
	mov	r4,a
	mov	a,r5
	addc	a,(_smooth_move_history_1_113 + 1)
	mov	r5,a
	mov	r6,(_smooth_move_history_1_113 + 2)
	mov	dpl,r4
	mov	dph,r5
	mov	b,r6
	lcall	__gptrget
	mov	r4,a
	inc	dptr
	lcall	__gptrget
	mov	r5,a
	mov	dpl,r1
	mov	dph,r2
	mov	b,r3
	mov	a,r4
	lcall	__gptrput
	inc	dptr
	mov	a,r5
	lcall	__gptrput
	ljmp	L009001?
L009003?:
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:395: history[0] += target;
	mov	dpl,_smooth_move_history_1_113
	mov	dph,(_smooth_move_history_1_113 + 1)
	mov	b,(_smooth_move_history_1_113 + 2)
	lcall	__gptrget
	mov	r2,a
	inc	dptr
	lcall	__gptrget
	mov	r3,a
	mov	a,_smooth_move_PARM_2
	add	a,r2
	mov	r2,a
	mov	a,(_smooth_move_PARM_2 + 1)
	addc	a,r3
	mov	r3,a
	mov	dpl,_smooth_move_history_1_113
	mov	dph,(_smooth_move_history_1_113 + 1)
	mov	b,(_smooth_move_history_1_113 + 2)
	mov	a,r2
	lcall	__gptrput
	inc	dptr
	mov	a,r3
	lcall	__gptrput
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:397: return history[0] / MEMORY_LENGTH;
	mov	__divsint_PARM_2,_smooth_move_N_1_114
	mov	(__divsint_PARM_2 + 1),(_smooth_move_N_1_114 + 1)
	mov	dpl,r2
	mov	dph,r3
	ljmp	__divsint
;------------------------------------------------------------
;Allocation info for local variables in function 'uTurn'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:400: void uTurn()
;	-----------------------------------------
;	 function uTurn
;	-----------------------------------------
_uTurn:
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:402: P2_2=1;
	setb	_P2_2
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:403: P2_1=0;
	clr	_P2_1
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:404: P2_0=1;
	setb	_P2_0
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:405: pwmLeft=TURNSPEED;
	mov	dptr,#_TURNSPEED
	clr	a
	movc	a,@a+dptr
	mov	r2,a
	mov	a,#0x01
	movc	a,@a+dptr
	mov	r3,a
	mov	_pwmLeft,r2
	mov	(_pwmLeft + 1),r3
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:406: pwmRight=(-TURNSPEED);
	clr	c
	clr	a
	subb	a,r2
	mov	_pwmRight,a
	clr	a
	subb	a,r3
	mov	(_pwmRight + 1),a
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:407: wait1s();
	lcall	_wait1s
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:408: wait1s();
	lcall	_wait1s
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:409: pwmLeft=pwmRight=0;
	clr	a
	mov	_pwmRight,a
	mov	(_pwmRight + 1),a
	mov	_pwmLeft,a
	mov	(_pwmLeft + 1),a
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:410: return;
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'getSig'
;------------------------------------------------------------
;j                         Allocated to registers r4 r5 
;val                       Allocated to registers r2 r3 
;v                         Allocated to registers r6 r7 r0 r1 
;------------------------------------------------------------
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:413: unsigned int getSig()
;	-----------------------------------------
;	 function getSig
;	-----------------------------------------
_getSig:
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:419: val = 0;
	mov	r2,#0x00
	mov	r3,#0x00
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:422: for (j = 0; j < 3; j++) {
	mov	r4,#0x00
	mov	r5,#0x00
L011001?:
	clr	c
	mov	a,r4
	subb	a,#0x03
	mov	a,r5
	subb	a,#0x00
	jnc	L011004?
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:423: v = GetADC(0);
	mov	dpl,#0x00
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	lcall	_GetADC
	lcall	___uint2fs
	mov	r6,dpl
	mov	r7,dph
	mov	r0,b
	mov	r1,a
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:424: val |= (v > MINVOLT) ? (0x01 << j) : 0x00;
	mov	dptr,#_MINVOLT
	clr	a
	movc	a,@a+dptr
	push	acc
	mov	a,#0x01
	movc	a,@a+dptr
	push	acc
	mov	a,#0x02
	movc	a,@a+dptr
	push	acc
	mov	a,#0x03
	movc	a,@a+dptr
	push	acc
	mov	dpl,r6
	mov	dph,r7
	mov	b,r0
	mov	a,r1
	lcall	___fsgt
	mov	r6,dpl
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
	mov	a,r6
	jz	L011007?
	mov	b,r4
	inc	b
	mov	r6,#0x01
	mov	r7,#0x00
	sjmp	L011016?
L011015?:
	mov	a,r6
	add	a,r6
	mov	r6,a
	mov	a,r7
	rlc	a
	mov	r7,a
L011016?:
	djnz	b,L011015?
	sjmp	L011008?
L011007?:
	mov	r6,#0x00
	mov	r7,#0x00
L011008?:
	mov	a,r6
	orl	ar2,a
	mov	a,r7
	orl	ar3,a
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:422: for (j = 0; j < 3; j++) {
	inc	r4
	cjne	r4,#0x00,L011001?
	inc	r5
	sjmp	L011001?
L011004?:
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:428: return val;
	mov	dpl,r2
	mov	dph,r3
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'wait1s'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:432: void wait1s (void)
;	-----------------------------------------
;	 function wait1s
;	-----------------------------------------
_wait1s:
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:444: _endasm;
	
  ;For a 22.1184MHz crystal one machine cycle
  ;takes 12/22.1184MHz=0.5425347us
	     mov R2, #10
	 L3:
	mov R1, #180
	 L2:
	mov R0, #180
	 L1:
	djnz R0, L1 ; 2 machine cycles-> 2*0.5425347us*184=200us
	     djnz R1, L2 ; 200us*250=0.05s
	     djnz R2, L3 ; 0.05s*20=1s
	     ret
	    
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'voltage'
;------------------------------------------------------------
;channel                   Allocated to registers 
;------------------------------------------------------------
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:452: float voltage (unsigned char channel)
;	-----------------------------------------
;	 function voltage
;	-----------------------------------------
_voltage:
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:454: return ((GetADC(channel) * 4.84) / 1023.0); // VCC=4.84V (measured)
	lcall	_GetADC
	lcall	___uint2fs
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	mov	dptr,#0xE148
	mov	b,#0x9A
	mov	a,#0x40
	lcall	___fsmul
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	clr	a
	push	acc
	mov	a,#0xC0
	push	acc
	mov	a,#0x7F
	push	acc
	mov	a,#0x44
	push	acc
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,r5
	lcall	___fsdiv
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,r5
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'SPIWrite'
;------------------------------------------------------------
;value                     Allocated to registers r2 
;------------------------------------------------------------
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:457: void SPIWrite(unsigned char value)
;	-----------------------------------------
;	 function SPIWrite
;	-----------------------------------------
_SPIWrite:
	mov	r2,dpl
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:459: SPSTA&=(~SPIF); // Clear the SPIF flag in SPSTA
	anl	_SPSTA,#0x7F
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:460: SPDAT=value;
	mov	_SPDAT,r2
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:461: while((SPSTA & SPIF)!=SPIF); //Wait for transmission to end
L014001?:
	mov	a,#0x80
	anl	a,_SPSTA
	mov	r2,a
	cjne	r2,#0x80,L014001?
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'GetADC'
;------------------------------------------------------------
;channel                   Allocated to registers r2 
;adc                       Allocated to registers r2 r3 
;------------------------------------------------------------
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:465: unsigned int GetADC(unsigned char channel)
;	-----------------------------------------
;	 function GetADC
;	-----------------------------------------
_GetADC:
	mov	r2,dpl
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:470: SPCON&=(~SPEN); // Disable SPI
	anl	_SPCON,#0xBF
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:471: SPCON=MSTR|CPOL|CPHA|SPR1|SPR0|SSDIS;
	mov	_SPCON,#0x3F
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:472: SPCON|=SPEN; // Enable SPI
	orl	_SPCON,#0x40
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:474: P1_4=0; // Activate the MCP3004 ADC.
	clr	_P1_4
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:475: SPIWrite(channel|0x18);	// Send start bit, single/diff* bit, D2, D1, and D0 bits.
	mov	a,#0x18
	orl	a,r2
	mov	dpl,a
	lcall	_SPIWrite
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:476: for(adc=0; adc<10; adc++); // Wait for S/H to setup
	mov	r2,#0x0A
	mov	r3,#0x00
L015003?:
	dec	r2
	cjne	r2,#0xff,L015009?
	dec	r3
L015009?:
	mov	a,r2
	orl	a,r3
	jnz	L015003?
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:477: SPIWrite(0x55); // Read bits 9 down to 4
	mov	dpl,#0x55
	lcall	_SPIWrite
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:478: adc=((SPDAT&0x3f)*0x100);
	mov	a,#0x3F
	anl	a,_SPDAT
	mov	r3,a
	mov	r2,#0x00
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:479: SPIWrite(0x55);// Read bits 3 down to 0
	mov	dpl,#0x55
	push	ar2
	push	ar3
	lcall	_SPIWrite
	pop	ar3
	pop	ar2
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:480: P1_4=1; // Deactivate the MCP3004 ADC.
	setb	_P1_4
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:481: adc+=(SPDAT&0xf0); // SPDR contains the low part of the result. 
	mov	a,#0xF0
	anl	a,_SPDAT
	mov	r4,a
	mov	r5,#0x00
	mov	a,r4
	add	a,r2
	mov	r2,a
	mov	a,r5
	addc	a,r3
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:482: adc>>=4;
	swap	a
	xch	a,r2
	swap	a
	anl	a,#0x0f
	xrl	a,r2
	xch	a,r2
	anl	a,#0x0f
	xch	a,r2
	xrl	a,r2
	xch	a,r2
;	C:\Users\Maxim\Documents\GitHub\Projects\Project2_Car\Code\core.c:484: return adc;
	mov	dpl,r2
	mov	dph,a
	ret
	rseg R_CSEG

	rseg R_XINIT

	rseg R_CONST
_MOVESPEED:
	db 0x64,0x00	;  100
_TURNSPEED:
	db 0x64,0x00	;  100
_MINVOLT:
	db 0xCD,0xCC,0x4C,0x3D	;  5.000000e-002
_DISTANCEBUFFER:
	db 0x00,0x00,0x70,0x41	;  1.500000e+001
_ANGLEBUFFER:
	db 0xCD,0xCC,0xCC,0x3D	;  1.000000e-001
_NSTAGES:
	db 0x0C,0x00	;  12
_PRESETS:
	db 0x00,0x00,0x16,0x44	;  6.000000e+002
	db 0x00,0x80,0x09,0x44	;  5.500000e+002
	db 0x00,0x00,0xFA,0x43	;  5.000000e+002
	db 0x00,0x00,0xE1,0x43	;  4.500000e+002
	db 0x00,0x00,0xC8,0x43	;  4.000000e+002
	db 0x00,0x00,0xAF,0x43	;  3.500000e+002
	db 0x00,0x00,0x96,0x43	;  3.000000e+002
	db 0x00,0x00,0x7A,0x43	;  2.500000e+002
	db 0x00,0x00,0x48,0x43	;  2.000000e+002
	db 0x00,0x00,0x16,0x43	;  1.500000e+002
	db 0x00,0x00,0xC8,0x42	;  1.000000e+002
	db 0x00,0x00,0x48,0x42	;  5.000000e+001
_MEMORY_LENGTH:
	db 0x04,0x00	;  4
__str_0:
	db 'DL %3.1f - DR %3.1f - Stage %3.1f(%d)'
	db 0x0D
	db 0x00
__str_1:
	db 0x1B
	db '[2J'
	db 0x00

	CSEG

end
