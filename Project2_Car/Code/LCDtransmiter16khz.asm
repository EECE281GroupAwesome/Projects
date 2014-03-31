;--------------------------------------------------------
; File Created by C51
; Version 1.0.0 #1034 (Dec 12 2012) (MSVC)
; This file was generated Mon Mar 31 13:34:08 2014
;--------------------------------------------------------
$name LCDtransmiter16khz
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
	public _check_rotary_PARM_2
	public _hex_array
	public _main
	public _tx_byte
	public _pwmcounter
	public __c51_external_startup
	public _txon
	public _last_rot
	public _this_rot
	public _EN_delay
	public _wait1s
	public _LCD_command
	public _LCD_write
	public _Init_LCD
	public _LCD_delay
	public _LCD_state
	public _wait_bit_time
	public _check_rotary
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
; internal ram data
;--------------------------------------------------------
	rseg R_DSEG
_this_rot:
	ds 2
_last_rot:
	ds 2
_LCD_state_LCD_string_1_85:
	ds 16
;--------------------------------------------------------
; overlayable items in internal ram 
;--------------------------------------------------------
	rseg	R_OSEG
_check_rotary_PARM_2:
	ds 2
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
_txon:
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
	ljmp	_pwmcounter
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
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\LCDtransmiter16khz.c:109: unsigned int this_rot = 0, last_rot = 0;
	clr	a
	mov	_this_rot,a
	mov	(_this_rot + 1),a
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\LCDtransmiter16khz.c:109: code unsigned short hex_array[] = {H0, H1, H2, H3, H4, H5, H6, H7, H8, H9};
	clr	a
	mov	_last_rot,a
	mov	(_last_rot + 1),a
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\LCDtransmiter16khz.c:62: volatile bit txon = 1; 
	setb	_txon
	; The linker places a 'ret' at the end of segment R_DINIT.
;--------------------------------------------------------
; code
;--------------------------------------------------------
	rseg R_CSEG
;------------------------------------------------------------
;Allocation info for local variables in function '_c51_external_startup'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\LCDtransmiter16khz.c:68: unsigned char _c51_external_startup(void)
;	-----------------------------------------
;	 function _c51_external_startup
;	-----------------------------------------
__c51_external_startup:
	using	0
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\LCDtransmiter16khz.c:71: P0M0=0;	P0M1=0;
	mov	_P0M0,#0x00
	mov	_P0M1,#0x00
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\LCDtransmiter16khz.c:72: P1M0=0;	P1M1=1;
	mov	_P1M0,#0x00
	mov	_P1M1,#0x01
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\LCDtransmiter16khz.c:73: P2M0=0;	P2M1=0;
	mov	_P2M0,#0x00
	mov	_P2M1,#0x00
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\LCDtransmiter16khz.c:74: P3M0=0;	P3M1=0;
	mov	_P3M0,#0x00
	mov	_P3M1,#0x00
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\LCDtransmiter16khz.c:75: AUXR=0B_0001_0001; // 1152 bytes of internal XDATA, P4.4 is a general purpose I/O
	mov	_AUXR,#0x11
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\LCDtransmiter16khz.c:76: P4M0=0;	P4M1=0;
	mov	_P4M0,#0x00
	mov	_P4M1,#0x00
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\LCDtransmiter16khz.c:78: P3M0 &= 0B_0011_1111;
	anl	_P3M0,#0x3F
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\LCDtransmiter16khz.c:79: P3M1 |= 0B_1100_0000;
	orl	_P3M1,#0xC0
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\LCDtransmiter16khz.c:80: Init_LCD();
	lcall	_Init_LCD
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\LCDtransmiter16khz.c:90: TR0=0; // Stop timer 0
	clr	_TR0
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\LCDtransmiter16khz.c:91: TMOD=0x01; // 16-bit timer
	mov	_TMOD,#0x01
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\LCDtransmiter16khz.c:96: TH0=RH0=TIMER0_RELOAD_VALUE/0x100;
	mov	_RH0,#0xFF
	mov	_TH0,#0xFF
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\LCDtransmiter16khz.c:97: TL0=RL0=TIMER0_RELOAD_VALUE%0x100;
	mov	_RL0,#0xC4
	mov	_TL0,#0xC4
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\LCDtransmiter16khz.c:98: TR0=1;// Start timer 0 (bit 4 in TCON)
	setb	_TR0
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\LCDtransmiter16khz.c:99: ET0=1; // Enable timer 0 interrupt
	setb	_ET0
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\LCDtransmiter16khz.c:100: EA=1;  // Enable global interrupts
	setb	_EA
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\LCDtransmiter16khz.c:104: return 0;
	mov	dpl,#0x00
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'EN_delay'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\LCDtransmiter16khz.c:112: void EN_delay (void) 
;	-----------------------------------------
;	 function EN_delay
;	-----------------------------------------
_EN_delay:
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\LCDtransmiter16khz.c:121: _endasm;
	
	 nop
	 nop
	 nop
	 nop
	 nop
	 nop
	 
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'wait1s'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\LCDtransmiter16khz.c:123: void wait1s (void)
;	-----------------------------------------
;	 function wait1s
;	-----------------------------------------
_wait1s:
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\LCDtransmiter16khz.c:135: _endasm;
	
  ;For a 22.1184MHz crystal one machine cycle
  ;takes 12/22.1184MHz=0.5425347us
	     mov R2, #20
	 G3:
	mov R1, #248
	 G2:
	mov R0, #184
	 G1:
	djnz R0, G1 ; 2 machine cycles-> 2*0.5425347us*184=200us
	     djnz R1, G2 ; 200us*250=0.05s
	     djnz R2, G3 ; 0.05s*20=1s
	     ret
	    
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'LCD_command'
;------------------------------------------------------------
;cmd                       Allocated to registers r2 
;------------------------------------------------------------
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\LCDtransmiter16khz.c:138: void LCD_command(unsigned char cmd)
;	-----------------------------------------
;	 function LCD_command
;	-----------------------------------------
_LCD_command:
	mov	r2,dpl
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\LCDtransmiter16khz.c:140: LCD_delay(); 
	push	ar2
	lcall	_LCD_delay
	pop	ar2
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\LCDtransmiter16khz.c:141: LCD_DATA = cmd;
	mov	_P1,r2
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\LCDtransmiter16khz.c:142: LCD_RS = 0;
	clr	_P3_3
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\LCDtransmiter16khz.c:143: LCD_EN = 1;
	setb	_P3_2
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\LCDtransmiter16khz.c:144: EN_delay();
	lcall	_EN_delay
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\LCDtransmiter16khz.c:145: LCD_EN = 0;
	clr	_P3_2
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\LCDtransmiter16khz.c:146: LCD_delay();
	ljmp	_LCD_delay
;------------------------------------------------------------
;Allocation info for local variables in function 'LCD_write'
;------------------------------------------------------------
;character                 Allocated to registers r2 
;------------------------------------------------------------
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\LCDtransmiter16khz.c:149: void LCD_write(unsigned char character)
;	-----------------------------------------
;	 function LCD_write
;	-----------------------------------------
_LCD_write:
	mov	r2,dpl
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\LCDtransmiter16khz.c:151: LCD_delay();
	push	ar2
	lcall	_LCD_delay
	pop	ar2
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\LCDtransmiter16khz.c:152: LCD_DATA = character;
	mov	_P1,r2
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\LCDtransmiter16khz.c:153: LCD_RS = 1;
	setb	_P3_3
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\LCDtransmiter16khz.c:154: LCD_EN = 1;
	setb	_P3_2
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\LCDtransmiter16khz.c:155: EN_delay();
	lcall	_EN_delay
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\LCDtransmiter16khz.c:156: LCD_EN = 0;
	clr	_P3_2
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\LCDtransmiter16khz.c:157: LCD_delay();
	ljmp	_LCD_delay
;------------------------------------------------------------
;Allocation info for local variables in function 'Init_LCD'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\LCDtransmiter16khz.c:160: void Init_LCD ()
;	-----------------------------------------
;	 function Init_LCD
;	-----------------------------------------
_Init_LCD:
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\LCDtransmiter16khz.c:162: LCD_delay();
	lcall	_LCD_delay
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\LCDtransmiter16khz.c:165: LCD_EN=0;
	clr	_P3_2
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\LCDtransmiter16khz.c:167: LCD_command(0x0c);
	mov	dpl,#0x0C
	lcall	_LCD_command
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\LCDtransmiter16khz.c:168: LCD_command(0x38); 
	mov	dpl,#0x38
	lcall	_LCD_command
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\LCDtransmiter16khz.c:169: LCD_command(Clear); //clears screen 
	mov	dpl,#0x01
	lcall	_LCD_command
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\LCDtransmiter16khz.c:170: EN_delay();
	lcall	_EN_delay
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\LCDtransmiter16khz.c:171: LCD_command(Line1); // moves cursor to line 1
	mov	dpl,#0x80
	lcall	_LCD_command
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\LCDtransmiter16khz.c:172: LCD_delay();	
	ljmp	_LCD_delay
;------------------------------------------------------------
;Allocation info for local variables in function 'LCD_delay'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\LCDtransmiter16khz.c:175: void LCD_delay (void)
;	-----------------------------------------
;	 function LCD_delay
;	-----------------------------------------
_LCD_delay:
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\LCDtransmiter16khz.c:187: _endasm;
	
  ;For a 22.1184MHz crystal one machine cycle
  ;takes 12/22.1184MHz=0.5425347us
	
	 J3:
	mov R4, #1
	 J2:
	mov R3, #184 ;184
	 J1:
	djnz R3, J1 ; 2 machine cycles-> 2*0.5425347us*184=200us
	     djnz R4, J2 ; 200us*250=0.05s
	
	     ret
	    
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'LCD_state'
;------------------------------------------------------------
;selected_command          Allocated to registers r2 r3 
;LCD_string                Allocated with name '_LCD_state_LCD_string_1_85'
;LCD_length                Allocated to registers r4 r5 
;i                         Allocated to registers r2 r3 
;------------------------------------------------------------
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\LCDtransmiter16khz.c:190: void LCD_state(int selected_command )
;	-----------------------------------------
;	 function LCD_state
;	-----------------------------------------
_LCD_state:
	mov	r2,dpl
	mov	r3,dph
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\LCDtransmiter16khz.c:192: unsigned char LCD_string[BUFFER] = "LCD Msg 0";
	mov	_LCD_state_LCD_string_1_85,#0x4C
	mov	(_LCD_state_LCD_string_1_85 + 0x0001),#0x43
	mov	(_LCD_state_LCD_string_1_85 + 0x0002),#0x44
	mov	(_LCD_state_LCD_string_1_85 + 0x0003),#0x20
	mov	(_LCD_state_LCD_string_1_85 + 0x0004),#0x4D
	mov	(_LCD_state_LCD_string_1_85 + 0x0005),#0x73
	mov	(_LCD_state_LCD_string_1_85 + 0x0006),#0x67
	mov	(_LCD_state_LCD_string_1_85 + 0x0007),#0x20
	mov	(_LCD_state_LCD_string_1_85 + 0x0008),#0x30
	mov	(_LCD_state_LCD_string_1_85 + 0x0009),#0x00
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\LCDtransmiter16khz.c:193: unsigned int LCD_length = strlen(LCD_string); 
	mov	dptr,#_LCD_state_LCD_string_1_85
	mov	b,#0x40
	push	ar2
	push	ar3
	lcall	_strlen
	pop	ar3
	pop	ar2
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\LCDtransmiter16khz.c:207: if ( selected_command == 0 ) 
	mov	a,r2
	orl	a,r3
	jnz	L009020?
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\LCDtransmiter16khz.c:208: LCD_length = sprintf( LCD_string ,"LCD Msg 0");
	mov	a,#__str_1
	push	acc
	mov	a,#(__str_1 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	mov	a,#_LCD_state_LCD_string_1_85
	push	acc
	mov	a,#(_LCD_state_LCD_string_1_85 >> 8)
	push	acc
	mov	a,#0x40
	push	acc
	lcall	_sprintf
	mov	r4,dpl
	mov	r5,dph
	mov	a,sp
	add	a,#0xfa
	mov	sp,a
	ljmp	L009036?
L009020?:
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\LCDtransmiter16khz.c:210: else if ( selected_command == 1 ) 
	cjne	r2,#0x01,L009017?
	cjne	r3,#0x00,L009017?
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\LCDtransmiter16khz.c:211: LCD_length = sprintf( LCD_string ,"LCD Msg 1");
	mov	a,#__str_2
	push	acc
	mov	a,#(__str_2 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	mov	a,#_LCD_state_LCD_string_1_85
	push	acc
	mov	a,#(_LCD_state_LCD_string_1_85 >> 8)
	push	acc
	mov	a,#0x40
	push	acc
	lcall	_sprintf
	mov	r4,dpl
	mov	r5,dph
	mov	a,sp
	add	a,#0xfa
	mov	sp,a
	ljmp	L009036?
L009017?:
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\LCDtransmiter16khz.c:213: else if ( selected_command == 2 ) 
	cjne	r2,#0x02,L009014?
	cjne	r3,#0x00,L009014?
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\LCDtransmiter16khz.c:214: LCD_length = sprintf( LCD_string ,"LCD Msg 2");
	mov	a,#__str_3
	push	acc
	mov	a,#(__str_3 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	mov	a,#_LCD_state_LCD_string_1_85
	push	acc
	mov	a,#(_LCD_state_LCD_string_1_85 >> 8)
	push	acc
	mov	a,#0x40
	push	acc
	lcall	_sprintf
	mov	r4,dpl
	mov	r5,dph
	mov	a,sp
	add	a,#0xfa
	mov	sp,a
	ljmp	L009036?
L009014?:
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\LCDtransmiter16khz.c:216: else if ( selected_command == 3 ) 
	cjne	r2,#0x03,L009011?
	cjne	r3,#0x00,L009011?
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\LCDtransmiter16khz.c:217: LCD_length = sprintf( LCD_string ,"LCD Msg 3");
	mov	a,#__str_4
	push	acc
	mov	a,#(__str_4 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	mov	a,#_LCD_state_LCD_string_1_85
	push	acc
	mov	a,#(_LCD_state_LCD_string_1_85 >> 8)
	push	acc
	mov	a,#0x40
	push	acc
	lcall	_sprintf
	mov	r4,dpl
	mov	r5,dph
	mov	a,sp
	add	a,#0xfa
	mov	sp,a
	ljmp	L009036?
L009011?:
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\LCDtransmiter16khz.c:219: else if ( selected_command == 4 )  
	cjne	r2,#0x04,L009008?
	cjne	r3,#0x00,L009008?
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\LCDtransmiter16khz.c:220: LCD_length = sprintf( LCD_string ,"LCD Msg 4");
	mov	a,#__str_5
	push	acc
	mov	a,#(__str_5 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	mov	a,#_LCD_state_LCD_string_1_85
	push	acc
	mov	a,#(_LCD_state_LCD_string_1_85 >> 8)
	push	acc
	mov	a,#0x40
	push	acc
	lcall	_sprintf
	mov	r4,dpl
	mov	r5,dph
	mov	a,sp
	add	a,#0xfa
	mov	sp,a
	ljmp	L009036?
L009008?:
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\LCDtransmiter16khz.c:222: else if ( selected_command == 5 ) 
	cjne	r2,#0x05,L009005?
	cjne	r3,#0x00,L009005?
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\LCDtransmiter16khz.c:223: LCD_length = sprintf( LCD_string ,"LCD Msg 5");
	mov	a,#__str_6
	push	acc
	mov	a,#(__str_6 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	mov	a,#_LCD_state_LCD_string_1_85
	push	acc
	mov	a,#(_LCD_state_LCD_string_1_85 >> 8)
	push	acc
	mov	a,#0x40
	push	acc
	lcall	_sprintf
	mov	r4,dpl
	mov	r5,dph
	mov	a,sp
	add	a,#0xfa
	mov	sp,a
	sjmp	L009036?
L009005?:
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\LCDtransmiter16khz.c:225: else if ( selected_command == 6 ) 
	cjne	r2,#0x06,L009002?
	cjne	r3,#0x00,L009002?
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\LCDtransmiter16khz.c:226: LCD_length = sprintf( LCD_string ,"LCD Msg 6");
	mov	a,#__str_7
	push	acc
	mov	a,#(__str_7 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	mov	a,#_LCD_state_LCD_string_1_85
	push	acc
	mov	a,#(_LCD_state_LCD_string_1_85 >> 8)
	push	acc
	mov	a,#0x40
	push	acc
	lcall	_sprintf
	mov	r4,dpl
	mov	r5,dph
	mov	a,sp
	add	a,#0xfa
	mov	sp,a
	sjmp	L009036?
L009002?:
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\LCDtransmiter16khz.c:229: LCD_length = sprintf( LCD_string ,"LCD Msg 7");
	mov	a,#__str_8
	push	acc
	mov	a,#(__str_8 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	mov	a,#_LCD_state_LCD_string_1_85
	push	acc
	mov	a,#(_LCD_state_LCD_string_1_85 >> 8)
	push	acc
	mov	a,#0x40
	push	acc
	lcall	_sprintf
	mov	r4,dpl
	mov	r5,dph
	mov	a,sp
	add	a,#0xfa
	mov	sp,a
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\LCDtransmiter16khz.c:231: for( i = 0; i < LCD_length; i++ ) LCD_write(LCD_string[i]);
L009036?:
	mov	r2,#0x00
	mov	r3,#0x00
L009022?:
	mov	ar6,r2
	mov	ar7,r3
	clr	c
	mov	a,r6
	subb	a,r4
	mov	a,r7
	subb	a,r5
	jnc	L009026?
	mov	a,r2
	add	a,#_LCD_state_LCD_string_1_85
	mov	r0,a
	mov	dpl,@r0
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	lcall	_LCD_write
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
	inc	r2
	cjne	r2,#0x00,L009022?
	inc	r3
	sjmp	L009022?
L009026?:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'wait_bit_time'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\LCDtransmiter16khz.c:234: void wait_bit_time (void)
;	-----------------------------------------
;	 function wait_bit_time
;	-----------------------------------------
_wait_bit_time:
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\LCDtransmiter16khz.c:246: _endasm;
	
  ;For a 22.1184MHz crystal one machine cycle
  ;takes 12/22.1184MHz=0.5425347us
	     mov R2, #2
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
;Allocation info for local variables in function 'pwmcounter'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\LCDtransmiter16khz.c:249: void pwmcounter (void) interrupt 1
;	-----------------------------------------
;	 function pwmcounter
;	-----------------------------------------
_pwmcounter:
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\LCDtransmiter16khz.c:251: if ( txon )
	jnb	_txon,L011003?
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\LCDtransmiter16khz.c:253: GRN_H_BRIDGE = !GRN_H_BRIDGE;
	cpl	_P3_6
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\LCDtransmiter16khz.c:254: ORG_H_BRIDGE = !ORG_H_BRIDGE;
	cpl	_P3_7
L011003?:
	reti
;	eliminated unneeded push/pop psw
;	eliminated unneeded push/pop dpl
;	eliminated unneeded push/pop dph
;	eliminated unneeded push/pop b
;	eliminated unneeded push/pop acc
;------------------------------------------------------------
;Allocation info for local variables in function 'tx_byte'
;------------------------------------------------------------
;val                       Allocated to registers r2 
;j                         Allocated to registers r3 
;------------------------------------------------------------
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\LCDtransmiter16khz.c:258: void tx_byte ( unsigned char val )
;	-----------------------------------------
;	 function tx_byte
;	-----------------------------------------
_tx_byte:
	mov	r2,dpl
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\LCDtransmiter16khz.c:262: txon=0;
	clr	_txon
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\LCDtransmiter16khz.c:263: wait_bit_time();
	push	ar2
	lcall	_wait_bit_time
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\LCDtransmiter16khz.c:264: txon = 1; 
	setb	_txon
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\LCDtransmiter16khz.c:265: wait_bit_time();
	lcall	_wait_bit_time
	pop	ar2
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\LCDtransmiter16khz.c:266: for (j=0; j<3; j++)
	mov	r3,#0x00
L012001?:
	cjne	r3,#0x03,L012010?
L012010?:
	jnc	L012004?
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\LCDtransmiter16khz.c:268: txon=val&(0x01<<j)?1:0;
	mov	b,r3
	inc	b
	mov	r4,#0x01
	mov	r5,#0x00
	sjmp	L012013?
L012012?:
	mov	a,r4
	add	a,r4
	mov	r4,a
	mov	a,r5
	rlc	a
	mov	r5,a
L012013?:
	djnz	b,L012012?
	mov	ar6,r2
	mov	r7,#0x00
	mov	a,r6
	anl	ar4,a
	mov	a,r7
	anl	ar5,a
	mov	a,r4
	orl	a,r5
	add	a,#0xff
	mov	_txon,c
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\LCDtransmiter16khz.c:269: wait_bit_time();
	push	ar2
	push	ar3
	lcall	_wait_bit_time
	pop	ar3
	pop	ar2
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\LCDtransmiter16khz.c:266: for (j=0; j<3; j++)
	inc	r3
	sjmp	L012001?
L012004?:
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\LCDtransmiter16khz.c:271: txon=1;
	setb	_txon
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\LCDtransmiter16khz.c:273: wait_bit_time();
	lcall	_wait_bit_time
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\LCDtransmiter16khz.c:274: wait_bit_time();
	ljmp	_wait_bit_time
;------------------------------------------------------------
;Allocation info for local variables in function 'main'
;------------------------------------------------------------
;selected_command          Allocated to registers r2 r3 
;------------------------------------------------------------
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\LCDtransmiter16khz.c:277: void main (void)
;	-----------------------------------------
;	 function main
;	-----------------------------------------
_main:
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\LCDtransmiter16khz.c:282: int selected_command = 0;
	mov	r2,#0x00
	mov	r3,#0x00
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\LCDtransmiter16khz.c:283: GRN_H_BRIDGE = 0;
	clr	_P3_6
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\LCDtransmiter16khz.c:284: ORG_H_BRIDGE = 1;
	setb	_P3_7
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\LCDtransmiter16khz.c:288: while(1)
L013009?:
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\LCDtransmiter16khz.c:292: LCD_command(Line1);
	mov	dpl,#0x80
	push	ar2
	push	ar3
	lcall	_LCD_command
	pop	ar3
	pop	ar2
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\LCDtransmiter16khz.c:293: LCD_state(selected_command);
	mov	dpl,r2
	mov	dph,r3
	push	ar2
	push	ar3
	lcall	_LCD_state
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\LCDtransmiter16khz.c:296: last_rot = this_rot;            
	mov	_last_rot,_this_rot
	mov	(_last_rot + 1),(_this_rot + 1)
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\LCDtransmiter16khz.c:297: this_rot = (ROT_B << 1) | ROT_A;   
	mov	c,_P2_4
	clr	a
	rlc	a
	mov	r4,a
	clr	a
	xch	a,r4
	add	a,acc
	xch	a,r4
	rlc	a
	mov	r5,a
	mov	c,_P2_3
	clr	a
	rlc	a
	mov	r7,#0x00
	orl	a,r4
	mov	_this_rot,a
	mov	a,r7
	orl	a,r5
	mov	(_this_rot + 1),a
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\LCDtransmiter16khz.c:298: selected_command += check_rotary(this_rot, last_rot); 
	mov	_check_rotary_PARM_2,_last_rot
	mov	(_check_rotary_PARM_2 + 1),(_last_rot + 1)
	mov	dpl,_this_rot
	mov	dph,(_this_rot + 1)
	lcall	_check_rotary
	mov	r4,dpl
	mov	r5,dph
	pop	ar3
	pop	ar2
	mov	a,r4
	add	a,r2
	mov	r2,a
	mov	a,r5
	addc	a,r3
	mov	r3,a
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\LCDtransmiter16khz.c:299: selected_command %= 10;
	mov	__modsint_PARM_2,#0x0A
	clr	a
	mov	(__modsint_PARM_2 + 1),a
	mov	dpl,r2
	mov	dph,r3
	lcall	__modsint
	mov	r2,dpl
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\LCDtransmiter16khz.c:300: if(selected_command < 0) selected_command = 7;
	mov	a,dph
	mov	r3,a
	jnb	acc.7,L013004?
	mov	r2,#0x07
	mov	r3,#0x00
	sjmp	L013005?
L013004?:
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\LCDtransmiter16khz.c:301: else if ( selected_command > 7 ) selected_command = 0; 
	clr	c
	mov	a,#0x07
	subb	a,r2
	clr	a
	xrl	a,#0x80
	mov	b,r3
	xrl	b,#0x80
	subb	a,b
	jnc	L013005?
	mov	r2,#0x00
	mov	r3,#0x00
L013005?:
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\LCDtransmiter16khz.c:303: HEX = hex_array[selected_command];
	mov	ar4,r2
	mov	a,r3
	xch	a,r4
	add	a,acc
	xch	a,r4
	rlc	a
	mov	r5,a
	mov	a,r4
	add	a,#_hex_array
	mov	dpl,a
	mov	a,r5
	addc	a,#(_hex_array >> 8)
	mov	dph,a
	clr	a
	movc	a,@a+dptr
	mov	r4,a
	inc	dptr
	clr	a
	movc	a,@a+dptr
	mov	r5,a
	mov	_P0,r4
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\LCDtransmiter16khz.c:304: if( !TX_BUTTON ) tx_byte(selected_command); 
	jnb	_P2_5,L013019?
	ljmp	L013009?
L013019?:
	mov	dpl,r2
	push	ar2
	push	ar3
	lcall	_tx_byte
	pop	ar3
	pop	ar2
	ljmp	L013009?
;------------------------------------------------------------
;Allocation info for local variables in function 'check_rotary'
;------------------------------------------------------------
;last_rot                  Allocated with name '_check_rotary_PARM_2'
;this_rot                  Allocated to registers r2 r3 
;------------------------------------------------------------
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\LCDtransmiter16khz.c:310: signed short check_rotary(unsigned int this_rot, unsigned int last_rot){ 
;	-----------------------------------------
;	 function check_rotary
;	-----------------------------------------
_check_rotary:
	mov	r2,dpl
	mov	r3,dph
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\LCDtransmiter16khz.c:312: if(this_rot != last_rot){ 
	mov	a,r2
	cjne	a,_check_rotary_PARM_2,L014053?
	mov	a,r3
	cjne	a,(_check_rotary_PARM_2 + 1),L014053?
	ljmp	L014033?
L014053?:
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\LCDtransmiter16khz.c:314: if(last_rot == 0 && this_rot == 2){return -1;} 
	mov	a,_check_rotary_PARM_2
	orl	a,(_check_rotary_PARM_2 + 1)
	jnz	L014029?
	cjne	r2,#0x02,L014029?
	cjne	r3,#0x00,L014029?
	mov	dptr,#0xFFFF
	ret
L014029?:
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\LCDtransmiter16khz.c:315: else if(last_rot == 2 && this_rot == 3){return -1;} 
	mov	a,#0x02
	cjne	a,_check_rotary_PARM_2,L014057?
	clr	a
	cjne	a,(_check_rotary_PARM_2 + 1),L014057?
	mov	a,#0x01
	sjmp	L014058?
L014057?:
	clr	a
L014058?:
	mov	r4,a
	jz	L014025?
	cjne	r2,#0x03,L014025?
	cjne	r3,#0x00,L014025?
	mov	dptr,#0xFFFF
	ret
L014025?:
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\LCDtransmiter16khz.c:316: else if(last_rot == 3 && this_rot == 1){return -1;} 
	mov	a,#0x03
	cjne	a,_check_rotary_PARM_2,L014062?
	clr	a
	cjne	a,(_check_rotary_PARM_2 + 1),L014062?
	mov	a,#0x01
	sjmp	L014063?
L014062?:
	clr	a
L014063?:
	mov	r5,a
	jz	L014021?
	cjne	r2,#0x01,L014021?
	cjne	r3,#0x00,L014021?
	mov	dptr,#0xFFFF
	ret
L014021?:
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\LCDtransmiter16khz.c:317: else if(last_rot == 1 && this_rot == 0){return -1;} 
	mov	a,#0x01
	cjne	a,_check_rotary_PARM_2,L014067?
	clr	a
	cjne	a,(_check_rotary_PARM_2 + 1),L014067?
	mov	a,#0x01
	sjmp	L014068?
L014067?:
	clr	a
L014068?:
	mov	r6,a
	jz	L014017?
	mov	a,r2
	orl	a,r3
	jnz	L014017?
	mov	dptr,#0xFFFF
	ret
L014017?:
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\LCDtransmiter16khz.c:318: else if(last_rot == 0 && this_rot == 1){return 1;} 
	mov	a,_check_rotary_PARM_2
	orl	a,(_check_rotary_PARM_2 + 1)
	jnz	L014013?
	cjne	r2,#0x01,L014013?
	cjne	r3,#0x00,L014013?
	mov	dptr,#0x0001
	ret
L014013?:
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\LCDtransmiter16khz.c:319: else if(last_rot == 1 && this_rot == 3){return 1;} 
	mov	a,r6
	jz	L014009?
	cjne	r2,#0x03,L014009?
	cjne	r3,#0x00,L014009?
	mov	dptr,#0x0001
	ret
L014009?:
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\LCDtransmiter16khz.c:320: else if(last_rot == 3 && this_rot == 2){return 1;} 
	mov	a,r5
	jz	L014005?
	cjne	r2,#0x02,L014005?
	cjne	r3,#0x00,L014005?
	mov	dptr,#0x0001
	ret
L014005?:
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\LCDtransmiter16khz.c:321: else if(last_rot == 2 && this_rot == 0){return 1;} 
	mov	a,r4
	jz	L014033?
	mov	a,r2
	orl	a,r3
	jnz	L014033?
	mov	dptr,#0x0001
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\LCDtransmiter16khz.c:324: return 0; 
	ret
L014033?:
	mov	dptr,#0x0000
	ret
	rseg R_CSEG

	rseg R_XINIT

	rseg R_CONST
_hex_array:
	db 0xC0,0x00	; 192
	db 0xF9,0x00	; 249
	db 0xA4,0x00	; 164
	db 0xB0,0x00	; 176
	db 0x99,0x00	; 153
	db 0x92,0x00	; 146
	db 0x82,0x00	; 130
	db 0xF8,0x00	; 248
	db 0x80,0x00	; 128
	db 0x90,0x00	; 144
__str_1:
	db 'LCD Msg 0'
	db 0x00
__str_2:
	db 'LCD Msg 1'
	db 0x00
__str_3:
	db 'LCD Msg 2'
	db 0x00
__str_4:
	db 'LCD Msg 3'
	db 0x00
__str_5:
	db 'LCD Msg 4'
	db 0x00
__str_6:
	db 'LCD Msg 5'
	db 0x00
__str_7:
	db 'LCD Msg 6'
	db 0x00
__str_8:
	db 'LCD Msg 7'
	db 0x00

	CSEG

end
