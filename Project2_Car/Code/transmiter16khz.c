#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <at89lp51rd2.h>

// ~C51~ 
 
#define CLK 22118400L
#define BAUD 115200L
#define BRG_VAL (0x100-(CLK/(32L*BAUD)))

//We want timer 0 to interrupt every 100 microseconds ((1/10000Hz)=100 us)
#define FREQ 30300L
#define TIMER0_RELOAD_VALUE (65536L-(CLK/(12L*FREQ)))

//HEX Display port 
#define HEX P0

// Hex Display constants 
#define H0 0xC0
#define H1 0xF9
#define H2 0xA4
#define H3 0xB0 
#define H4 0x99 
#define H5 0x92 
#define H6 0x82
#define H7 0xF8
#define H8 0x80
#define H9 0x90

// Rotary
#define rot_a P1_2
#define rot_b P1_3
#define TX_button  P1_1

// LCD Ports
#define LCD_EN P2_1
#define LCD_RS P2_2
//#define LCD_DATA P1

//LCD constants
#define Line1 0x80
#define Line2 0xA8
#define Clear 0x01
#define BUFFER 16


void wait_bit_time(void );

void Init_LCD (void);
void LCD_command(unsigned char);
void LCD_write(unsigned char);
void Cap_Display(float); // havent tested with LCD 
void wait1s (void);
void LCD_delay (void);

volatile bit txon = 1; 



unsigned char _c51_external_startup(void)
{
	// Configure ports as a bidirectional with internal pull-ups.
	P0M0=0;	P0M1=0;
	P1M0=0;	P1M1=0;
	P2M0=0;	P2M1=0;
	P3M0=0;	P3M1=0;
	AUXR=0B_0001_0001; // 1152 bytes of internal XDATA, P4.4 is a general purpose I/O
	P4M0=0;	P4M1=0;
	
	P3M0 &= 0B_1111_0011;
	P3M1 |= 0B_0000_1100;
    
    /*
    // Initialize the serial port and baud rate generator
    PCON|=0x80;
	SCON = 0x52;
    BDRCON=0;
    BRL=BRG_VAL;
    BDRCON=BRR|TBCK|RBCK|SPD;
    */
    	// Initialize timer 0 for ISR 'pwmcounter()' below
	TR0=0; // Stop timer 0
	TMOD=0x01; // 16-bit timer
	// Use the autoreload feature available in the AT89LP51RB2
	// WARNING: There was an error in at89lp51rd2.h that prevents the
	// autoreload feature to work.  Please download a newer at89lp51rd2.h
	// file and copy it to the crosside\call51\include folder.
	TH0=RH0=TIMER0_RELOAD_VALUE/0x100;
	TL0=RL0=TIMER0_RELOAD_VALUE%0x100;
	TR0=1; // Start timer 0 (bit 4 in TCON)
	ET0=1; // Enable timer 0 interrupt
	EA=1;  // Enable global interrupts
	//Init_LCD();
	//pwmcount=0;
    
    return 0;
}

signed short check_rotary(unsigned int this_rot, unsigned int last_rot);

unsigned int this_rot = 0, last_rot = 0;
code unsigned short hex_array[] = {H0, H1, H2, H3, H4, H5, H6, H7, H8, H9};
/*
void wait1s (void)
{
	_asm	
		;For a 22.1184MHz crystal one machine cycle 
		;takes 12/22.1184MHz=0.5425347us
	    mov R2, #20
	G3:	mov R1, #248
	G2:	mov R0, #184
	G1:	djnz R0, G1 ; 2 machine cycles-> 2*0.5425347us*184=200us
	    djnz R1, G2 ; 200us*250=0.05s
	    djnz R2, G3 ; 0.05s*20=1s
	    ret
    _endasm;
}

void LCD_command(unsigned char cmd)
{
	 
	LCD_DATA = cmd;
	LCD_RS = 0;
	LCD_EN = 1;
	LCD_EN = 0;
	LCD_delay();
}

void LCD_write(unsigned char character)
{
	
	LCD_DATA = character;
	LCD_RS = 1;
	LCD_EN = 1;
	LCD_EN = 0;
	LCD_delay();
}

void Init_LCD ()
{

	//LCD_ON = 1;
//	LCD_BLON = 1; 
	LCD_EN=0;
//	LCD_RW = 0;
	LCD_command(0x0c);
	LCD_command(0x38);
	LCD_command(Clear); //clears screen
	LCD_command(Line1); // moves cursor to line 1
	LCD_delay();	
}

void LCD_delay (void)
{
	_asm	
		;For a 22.1184MHz crystal one machine cycle 
		;takes 12/22.1184MHz=0.5425347us
	  
	J3:	mov R4, #1
	J2:	mov R3, #46 ;184
	J1:	djnz R3, J1 ; 2 machine cycles-> 2*0.5425347us*184=200us
	    djnz R4, J2 ; 200us*250=0.05s
	    
	    ret
    _endasm;
}*/

void wait_bit_time (void)
{
	_asm	
		;For a 22.1184MHz crystal one machine cycle 
		;takes 12/22.1184MHz=0.5425347us
	    mov R2, #2
	L3:	mov R1, #248
	L2:	mov R0, #184
	L1:	djnz R0, L1 ; 2 machine cycles-> 2*0.5425347us*184=200us
	    djnz R1, L2 ; 200us*250=0.05s
	    djnz R2, L3 ; 0.05s*20=1s
	    ret
    _endasm;
}

void pwmcounter (void) interrupt 1
{
	if ( txon )
	{
		P3_2 = !P3_2;
		P3_3 = !P3_3;
	}
}
	
void tx_byte ( unsigned char val )
{
	unsigned char j;
	//Send the start bit
	txon=0;
	wait_bit_time();
	txon = 1; 
	wait_bit_time();
	for (j=0; j<3; j++)
	{
		txon=val&(0x01<<j)?1:0;
		wait_bit_time();
	}
	txon=1;
	//Send the stop bits
	wait_bit_time();
	wait_bit_time();
}

void main (void)
{
	
	unsigned char LCD_string[BUFFER] = "LCD Msg"; 
	unsigned int LCD_length = strlen(LCD_string); 
	int i = 0; 
	int selected_command = 0;
	P3_2 = 0;
	P3_3 = 1;
	
	//LCD_command(Line1);
	//for( i = 0; i < LCD_length; i++ ) LCD_write(LCD_string[i]);
	
	while(1)
	{

		last_rot = this_rot;            
        this_rot = (rot_b << 1) | rot_a;   
        selected_command += check_rotary(this_rot, last_rot); 
		selected_command %= 10;
		if(selected_command < 0) selected_command = 7;
		else if ( selected_command > 7 ) selected_command = 0; 
				
	 	HEX = hex_array[selected_command];
		if( !TX_button ) tx_byte(selected_command); 
		
	}	
	
}

signed short check_rotary(unsigned int this_rot, unsigned int last_rot){ 
  
    if(this_rot != last_rot){ 
          
        if(last_rot == 0 && this_rot == 2){return -1;} 
        else if(last_rot == 2 && this_rot == 3){return -1;} 
        else if(last_rot == 3 && this_rot == 1){return -1;} 
        else if(last_rot == 1 && this_rot == 0){return -1;} 
        else if(last_rot == 0 && this_rot == 1){return 1;} 
        else if(last_rot == 1 && this_rot == 3){return 1;} 
        else if(last_rot == 3 && this_rot == 2){return 1;} 
        else if(last_rot == 2 && this_rot == 0){return 1;} 
    } 
      
    return 0; 
} 

