;--------------------------------------------------------
; File Created by C51
; Version 1.0.0 #1034 (Dec 12 2012) (MSVC)
; This file was generated Mon Mar 17 16:24:42 2014
;--------------------------------------------------------
$name core
$optc51 --model-small
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
	public _main
	public __c51_external_startup
	public _pwmCounter
	public _beaconSignal
	public _Stage
	public _instruction
	public _distanceRight
	public _distanceLeft
	public _rightSensor
	public _leftSensor
	public _pwmRight
	public _pwmLeft
	public _pwmCount
	public _getDistance
	public _turnCar
	public _moveCar
	public _wait2ms
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
_RH0            DATA 0xf3
_RTL1           DATA 0xf4
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
_pwmLeft:
	ds 2
_pwmRight:
	ds 2
_leftSensor:
	ds 2
_rightSensor:
	ds 2
_distanceLeft:
	ds 2
_distanceRight:
	ds 2
_instruction:
	ds 2
_Stage:
	ds 2
;--------------------------------------------------------
; overlayable items in internal ram 
;--------------------------------------------------------
	rseg	R_OSEG
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
	CSEG at 0x0003
	ljmp	_beaconSignal
	CSEG at 0x000b
	ljmp	_pwmCounter
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
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\core.c:35: volatile unsigned int pwmCount = 0;
	clr	a
	mov	_pwmCount,a
	mov	(_pwmCount + 1),a
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\core.c:36: volatile int pwmLeft = 0;
	clr	a
	mov	_pwmLeft,a
	mov	(_pwmLeft + 1),a
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\core.c:37: volatile int pwmRight = 0;
	clr	a
	mov	_pwmRight,a
	mov	(_pwmRight + 1),a
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\core.c:38: volatile unsigned int leftSensor = 0;
	clr	a
	mov	_leftSensor,a
	mov	(_leftSensor + 1),a
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\core.c:39: volatile unsigned int rightSensor = 0;
	clr	a
	mov	_rightSensor,a
	mov	(_rightSensor + 1),a
	; The linker places a 'ret' at the end of segment R_DINIT.
;--------------------------------------------------------
; code
;--------------------------------------------------------
	rseg R_CSEG
;------------------------------------------------------------
;Allocation info for local variables in function 'beaconSignal'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\core.c:61: void beaconSignal() interrupt 0
;	-----------------------------------------
;	 function beaconSignal
;	-----------------------------------------
_beaconSignal:
	using	0
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\core.c:67: }
	reti
;	eliminated unneeded push/pop psw
;	eliminated unneeded push/pop dpl
;	eliminated unneeded push/pop dph
;	eliminated unneeded push/pop b
;	eliminated unneeded push/pop acc
;------------------------------------------------------------
;Allocation info for local variables in function 'pwmCounter'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\core.c:69: void pwmCounter() interrupt 1
;	-----------------------------------------
;	 function pwmCounter
;	-----------------------------------------
_pwmCounter:
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
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\core.c:72: if(++pwmCount>99)
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
	jnc	L003002?
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\core.c:73: pwmCount = 0;
	clr	a
	mov	_pwmCount,a
	mov	(_pwmCount + 1),a
L003002?:
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\core.c:77: getDistance();
	lcall	_getDistance
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\core.c:78: if(distanceLeft!=distanceRight)
	mov	a,_distanceRight
	cjne	a,_distanceLeft,L003022?
	mov	a,(_distanceRight + 1)
	cjne	a,(_distanceLeft + 1),L003022?
	sjmp	L003004?
L003022?:
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\core.c:79: turnCar();
	lcall	_turnCar
L003004?:
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\core.c:82: if(pwmLeft>0)
	clr	c
	clr	a
	subb	a,_pwmLeft
	clr	a
	xrl	a,#0x80
	mov	b,(_pwmLeft + 1)
	xrl	b,#0x80
	subb	a,b
	jnc	L003006?
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\core.c:84: P1_0=(pwmLeft>pwmCount)?0:1;
	mov	r2,_pwmLeft
	mov	r3,(_pwmLeft + 1)
	clr	c
	mov	a,_pwmCount
	subb	a,r2
	mov	a,(_pwmCount + 1)
	subb	a,r3
	mov  _pwmCounter_sloc0_1_0,c
	cpl	c
	mov	_P1_0,c
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\core.c:85: P1_1=1;
	setb	_P1_1
L003006?:
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\core.c:87: if(pwmLeft<0)
	mov	a,(_pwmLeft + 1)
	jnb	acc.7,L003008?
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\core.c:89: P1_1=((-1)*pwmLeft>pwmCount)?0:1;
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
	mov	_P1_1,c
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\core.c:90: P1_0=1;
	setb	_P1_0
L003008?:
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\core.c:93: if(pwmRight>0)
	clr	c
	clr	a
	subb	a,_pwmRight
	clr	a
	xrl	a,#0x80
	mov	b,(_pwmRight + 1)
	xrl	b,#0x80
	subb	a,b
	jnc	L003010?
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\core.c:95: P1_0=(pwmRight>pwmCount)?0:1;
	mov	r2,_pwmRight
	mov	r3,(_pwmRight + 1)
	clr	c
	mov	a,_pwmCount
	subb	a,r2
	mov	a,(_pwmCount + 1)
	subb	a,r3
	mov  _pwmCounter_sloc0_1_0,c
	cpl	c
	mov	_P1_0,c
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\core.c:96: P1_1=1;
	setb	_P1_1
L003010?:
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\core.c:98: if(pwmRight<0)
	mov	a,(_pwmRight + 1)
	jnb	acc.7,L003013?
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\core.c:100: P1_1=((-1)*pwmRight>pwmCount)?0:1;
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
	mov	_P1_1,c
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\core.c:101: P1_0=1;
	setb	_P1_0
L003013?:
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
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\core.c:109: unsigned char _c51_external_startup(void)
;	-----------------------------------------
;	 function _c51_external_startup
;	-----------------------------------------
__c51_external_startup:
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\core.c:112: P0M0 = 0;	P0M1 = 0;
	mov	_P0M0,#0x00
	mov	_P0M1,#0x00
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\core.c:113: P1M0 = 0;	P1M1 = 0;
	mov	_P1M0,#0x00
	mov	_P1M1,#0x00
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\core.c:114: P2M0 = 0;	P2M1 = 0;
	mov	_P2M0,#0x00
	mov	_P2M1,#0x00
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\core.c:115: P3M0 = 0;	P3M1 = 0;
	mov	_P3M0,#0x00
	mov	_P3M1,#0x00
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\core.c:116: AUXR = 0B_0001_0001; // 1152 bytes of internal XDATA, P4.4 is a general purpose I/O
	mov	_AUXR,#0x11
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\core.c:117: P4M0 = 0;	P4M1 = 0;
	mov	_P4M0,#0x00
	mov	_P4M1,#0x00
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\core.c:120: TMOD = 0x01;	// Timer 0 as 16-bit timer	
	mov	_TMOD,#0x01
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\core.c:121: TH0 = RH0 = TIMER0_RELOAD_VALUE / 0x100;
	mov	_RH0,#0xFF
	mov	_TH0,#0xFF
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\core.c:122: TL0 = RL0 = TIMER0_RELOAD_VALUE % 0x100;
	mov	_RL0,#0x48
	mov	_TL0,#0x48
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\core.c:123: TR0 = 1;
	setb	_TR0
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\core.c:124: ET0 = 1;	// Enable timer 0 interrupt
	setb	_ET0
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\core.c:125: EX0 = 1;	// Enable external interrupt 0
	setb	_EX0
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\core.c:126: IT0 = 1;
	setb	_IT0
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\core.c:127: EA = 1; 	// Enable global interrupts
	setb	_EA
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\core.c:128: instruction=0;
	clr	a
	mov	_instruction,a
	mov	(_instruction + 1),a
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\core.c:129: Stage=3;
	mov	_Stage,#0x03
	clr	a
	mov	(_Stage + 1),a
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\core.c:130: return 0;
	mov	dpl,#0x00
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'main'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\core.c:134: int main (void)
;	-----------------------------------------
;	 function main
;	-----------------------------------------
_main:
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\core.c:139: while (instruction==0)
L005001?:
	mov	a,_instruction
	orl	a,(_instruction + 1)
	jnz	L005003?
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\core.c:141: moveCar();
	lcall	_moveCar
	sjmp	L005001?
L005003?:
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\core.c:144: switch (instruction)
	clr	c
	mov	a,#0x05
	subb	a,_instruction
	clr	a
	subb	a,(_instruction + 1)
	jc	L005014?
	mov	a,_instruction
	add	a,_instruction
	add	a,_instruction
	mov	dptr,#L005027?
	jmp	@a+dptr
L005027?:
	ljmp	L005013?
	ljmp	L005004?
	ljmp	L005007?
	ljmp	L005010?
	ljmp	L005011?
	ljmp	L005012?
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\core.c:146: case 1: //Move Forward
L005004?:
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\core.c:147: if(Stage!=0)
	mov	a,_Stage
	orl	a,(_Stage + 1)
	jz	L005014?
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\core.c:148: Stage--;
	dec	_Stage
	mov	a,#0xff
	cjne	a,_Stage,L005029?
	dec	(_Stage + 1)
L005029?:
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\core.c:149: break;
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\core.c:150: case 2: //Move Backwards
	sjmp	L005014?
L005007?:
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\core.c:151: if(Stage!=7)
	mov	a,#0x07
	cjne	a,_Stage,L005030?
	clr	a
	cjne	a,(_Stage + 1),L005030?
	sjmp	L005014?
L005030?:
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\core.c:152: Stage++;	
	inc	_Stage
	clr	a
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\core.c:153: break;
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\core.c:154: case 3: //180 Turn
	cjne	a,_Stage,L005014?
	inc	(_Stage + 1)
	sjmp	L005014?
L005010?:
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\core.c:156: break;
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\core.c:157: case 4: //Park
	sjmp	L005014?
L005011?:
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\core.c:159: break;
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\core.c:160: case 5:
	sjmp	L005014?
L005012?:
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\core.c:162: break;
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\core.c:163: default: //Turn on LED for bad instrucion	
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\core.c:164: }
L005013?:
L005014?:
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\core.c:165: instruction=0;
	clr	a
	mov	_instruction,a
	mov	(_instruction + 1),a
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\core.c:167: return 0;
	sjmp	L005001?
;------------------------------------------------------------
;Allocation info for local variables in function 'getDistance'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\core.c:178: void getDistance() 
;	-----------------------------------------
;	 function getDistance
;	-----------------------------------------
_getDistance:
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\core.c:181: }
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'turnCar'
;------------------------------------------------------------
;tempL                     Allocated to registers r2 r3 
;tempR                     Allocated to registers r4 r5 
;------------------------------------------------------------
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\core.c:188: void turnCar()
;	-----------------------------------------
;	 function turnCar
;	-----------------------------------------
_turnCar:
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\core.c:191: int tempL=pwmLeft;
	mov	r2,_pwmLeft
	mov	r3,(_pwmLeft + 1)
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\core.c:192: int tempR=pwmRight;
	mov	r4,_pwmRight
	mov	r5,(_pwmRight + 1)
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\core.c:194: while(distanceLeft<distanceRight)
L007001?:
	clr	c
	mov	a,_distanceLeft
	subb	a,_distanceRight
	mov	a,(_distanceLeft + 1)
	subb	a,(_distanceRight + 1)
	clr	a
	rlc	a
	mov	r6,a
	jz	L007004?
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\core.c:196: pwmLeft=50;
	mov	_pwmLeft,#0x32
	clr	a
	mov	(_pwmLeft + 1),a
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\core.c:197: pwmRight=(-50);
	mov	_pwmRight,#0xCE
	mov	(_pwmRight + 1),#0xFF
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\core.c:199: while(distanceLeft<distanceRight)
	sjmp	L007001?
L007004?:
	mov	a,r6
	jz	L007006?
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\core.c:201: pwmLeft=(-50);
	mov	_pwmLeft,#0xCE
	mov	(_pwmLeft + 1),#0xFF
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\core.c:202: pwmRight=50;
	mov	_pwmRight,#0x32
	clr	a
	mov	(_pwmRight + 1),a
	sjmp	L007004?
L007006?:
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\core.c:205: pwmRight=tempR;
	mov	_pwmRight,r4
	mov	(_pwmRight + 1),r5
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\core.c:206: pwmLeft=tempL;
	mov	_pwmLeft,r2
	mov	(_pwmLeft + 1),r3
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'moveCar'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\core.c:214: void moveCar()
;	-----------------------------------------
;	 function moveCar
;	-----------------------------------------
_moveCar:
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\core.c:219: if(distanceRight>PRESETS[Stage])
	mov	a,_Stage
	add	a,_Stage
	mov	r2,a
	mov	a,(_Stage + 1)
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
	mov	ar4,r2
	mov	ar5,r3
	clr	c
	mov	a,r4
	subb	a,_distanceRight
	mov	a,r5
	subb	a,(_distanceRight + 1)
	jnc	L008002?
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\core.c:220: pwmLeft=pwmRight=75;
	mov	_pwmRight,#0x4B
	clr	a
	mov	(_pwmRight + 1),a
	mov	_pwmLeft,#0x4B
	clr	a
	mov	(_pwmLeft + 1),a
L008002?:
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\core.c:221: if(distanceRight>PRESETS[Stage])
	clr	c
	mov	a,r2
	subb	a,_distanceRight
	mov	a,r3
	subb	a,(_distanceRight + 1)
	jnc	L008004?
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\core.c:222: pwmLeft=pwmRight=(-75);		
	mov	_pwmRight,#0xB5
	mov	(_pwmRight + 1),#0xFF
	mov	_pwmLeft,#0xB5
	mov	(_pwmLeft + 1),#0xFF
L008004?:
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\core.c:223: return;
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'wait2ms'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\core.c:227: void wait2ms (void)
;	-----------------------------------------
;	 function wait2ms
;	-----------------------------------------
_wait2ms:
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\core.c:237: _endasm;
	
  ;For a 22.1184MHz crystal one machine cycle
  ;takes 12/22.1184MHz=0.5425347us
	 J3:
	mov R4, #10
	 J2:
	mov R3, #184
	 J1:
	djnz R3, J1 ; 2 machine cycles-> 2*0.5425347us*184=200us
	     djnz R4, J2 ; 200us*250=0.05s
	     ret
	    
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'wait1s'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\core.c:241: void wait1s (void)
;	-----------------------------------------
;	 function wait1s
;	-----------------------------------------
_wait1s:
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\core.c:253: _endasm;
	
  ;For a 22.1184MHz crystal one machine cycle
  ;takes 12/22.1184MHz=0.5425347us
	     mov R2, #20
	 L3:
	mov R1, #248
	 L2:
	mov R0, #184
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
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\core.c:261: float voltage (unsigned char channel)
;	-----------------------------------------
;	 function voltage
;	-----------------------------------------
_voltage:
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\core.c:263: return ((GetADC(channel) * 4.84) / 1023.0); // VCC=4.84V (measured)
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
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\core.c:266: void SPIWrite(unsigned char value)
;	-----------------------------------------
;	 function SPIWrite
;	-----------------------------------------
_SPIWrite:
	mov	r2,dpl
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\core.c:268: SPSTA &= (~SPIF); // Clear the SPIF flag in SPSTA
	anl	_SPSTA,#0x7F
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\core.c:269: SPDAT = value;
	mov	_SPDAT,r2
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\core.c:270: while ((SPSTA & SPIF) != SPIF); //Wait for transmission to end
L012001?:
	mov	a,#0x80
	anl	a,_SPSTA
	mov	r2,a
	cjne	r2,#0x80,L012001?
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'GetADC'
;------------------------------------------------------------
;channel                   Allocated to registers r2 
;adc                       Allocated to registers r2 r3 
;------------------------------------------------------------
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\core.c:274: unsigned int GetADC(unsigned char channel)
;	-----------------------------------------
;	 function GetADC
;	-----------------------------------------
_GetADC:
	mov	r2,dpl
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\core.c:279: SPCON &= (~SPEN); // Disable SPI
	anl	_SPCON,#0xBF
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\core.c:280: SPCON = MSTR | CPOL | CPHA | SPR1 | SPR0 | SSDIS;
	mov	_SPCON,#0x3F
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\core.c:281: SPCON |= SPEN; // Enable SPI
	orl	_SPCON,#0x40
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\core.c:283: P1_4 = 0; // Activate the MCP3004 ADC.
	clr	_P1_4
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\core.c:284: SPIWrite(channel | 0x18);	// Send start bit, single/diff* bit, D2, D1, and D0 bits.
	mov	a,#0x18
	orl	a,r2
	mov	dpl,a
	lcall	_SPIWrite
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\core.c:285: for (adc=0; adc < 10; adc++); // Wait for S/H to setup
	mov	r2,#0x0A
	mov	r3,#0x00
L013003?:
	dec	r2
	cjne	r2,#0xff,L013009?
	dec	r3
L013009?:
	mov	a,r2
	orl	a,r3
	jnz	L013003?
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\core.c:286: SPIWrite(0x55); // Read bits 9 down to 4
	mov	dpl,#0x55
	lcall	_SPIWrite
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\core.c:287: adc=((SPDAT & 0x3f) * 0x100);
	mov	a,#0x3F
	anl	a,_SPDAT
	mov	r3,a
	mov	r2,#0x00
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\core.c:288: SPIWrite(0x55);// Read bits 3 down to 0
	mov	dpl,#0x55
	push	ar2
	push	ar3
	lcall	_SPIWrite
	pop	ar3
	pop	ar2
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\core.c:289: P1_4 = 1; // Deactivate the MCP3004 ADC.
	setb	_P1_4
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\core.c:290: adc += (SPDAT & 0xf0); // SPDR contains the low part of the result. 
	mov	a,#0xF0
	anl	a,_SPDAT
	mov	r4,a
	mov	r5,#0x00
	mov	a,r4
	add	a,r2
	mov	r2,a
	mov	a,r5
	addc	a,r3
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\core.c:291: adc >>= 4;
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
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\core.c:293: return adc;
	mov	dpl,r2
	mov	dph,a
	ret
	rseg R_CSEG

	rseg R_XINIT

	rseg R_CONST
_PRESETS:
	db 0x05,0x00	;  5
	db 0x0A,0x00	;  10
	db 0x0F,0x00	;  15
	db 0x14,0x00	;  20
	db 0x19,0x00	;  25
	db 0x1E,0x00	;  30
	db 0x23,0x00	;  35
	db 0x28,0x00	;  40
	db 0x2D,0x00	;  45
	db 0x32,0x00	;  50
	db 0x37,0x00	;  55
	db 0x3C,0x00	;  60

	CSEG

end