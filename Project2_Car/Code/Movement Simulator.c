/*
	EECE 281 Project 2
	
	Core File
	Written for AT89LP51
*/

//---Included Files---

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <at89lp51rd2.h>

//---Defined Macros---

#define CLK 22118400L
#define BAUD 115200L
#define BRG_VAL (0x100-(CLK/(32L*BAUD)))
#define TIMER0_RELOAD_VALUE (65536L-(CLK/(12L*FREQ)))
#define TIMER_2_RELOAD (0x10000L-(CLK/(32L*BAUD)))
#define FREQ 10000L
#define RED P0_0
#define GRN P0_1
#define YLW P0_2

//---Global Variables---

static const int TOO_FAR   = 10;
static const int TOO_CLOSE = 5;
static const int DISTANCE_CONSTANT = 0.0036;
static const int PRESETS[] = {5,10,15,20,25,30};

volatile unsigned int pwmCount = 0;
volatile int pwmRight = 0;
volatile int pwmLeft = 0;
volatile unsigned int leftSensor = 0;
volatile unsigned int rightSensor = 0;
volatile int instruction;
unsigned int distance;
char turnDirection;
float angle;

//---Function Prototypes---

unsigned int getDistance();
float getAngle();
char getDirection();
void turnCar(unsigned int Lwheel, unsigned int Rwheel);
void moveCar(char direction);
void wait2ms();
void wait1s();

//---Interrupts---

void beaconSignal() interrupt 3
{
	instruction=0;
}

void pwmCounter() interrupt 1
{
	if(++pwmCount>99)
		pwmCount = 0;
	//Left wheel
	if(pwmLeft>0)
	{	
		P1_0 =(pwmLeft>pwmCount)?0:1;
		P1_1 =1;
	}
	if(pwmLeft<0)
	{	
		P1_1=(pwmLeft>pwmCount)?0:1;
		P1_0=1;
	}
	//Right wheel
	if(pwmRight>0)
	{	
		P1_0=(pwmRight>pwmCount)?0:1;
		P1_1=1;
	}
	if(pwmRight<0)
	{	
		P1_1=(pwmRight>pwmCount)?0:1;
		P1_0=1;
	}


}		

//---Boot---

unsigned char _c51_external_startup(void)
{
	// Configure ports as a bidirectional with internal pull-ups.
	P0M0 = 0;	P0M1 = 0;
	P1M0 = 0;	P1M1 = 0;
	P2M0 = 0;	P2M1 = 0;
	P3M0 = 0;	P3M1 = 0;
	AUXR = 0B_0001_0001; // 1152 bytes of internal XDATA, P4.4 is a general purpose I/O
	P4M0 = 0;	P4M1 = 0;
    
	
	TMOD = 0x01;	// Timer 0 as 16-bit timer	
	TH0 = RH0 = TIMER0_RELOAD_VALUE / 0x100;
	TL0 = RL0 = TIMER0_RELOAD_VALUE % 0x100;
	TR0 = 1;
	ET0 = 1;	// Enable timer 0 interrupt
	EX0 = 1;	// Enable external interrupt 0
	IT0 = 1;
	EA = 1; 	// Enable global interrupts
	
	//Clear stuff
	pwmRight=0;
	pwmLeft=0;
	instruction=0;
    return 0;
}

//---MAIN---
int main (void)
{	
	while (1)
	{
		while (instruction==0 && angle > 10)
		{
			YLW=1;
			GRN=0;
			RED=0;
			angle = getAngle();
			turnDirection = getDirection();
			turnCar(pwmLeft, pwmRight);
			distance = getDistance();
		}
		
		switch (instruction)
		{
			case 1: //Move Forward
			moveCar(1);
			break;
			case 2: //Move Backwards
			moveCar(-1);
			break;
			case 3: //180 Turn
			
			break;
			case 4: //Park
			
			break;
			case 5:
			
			break;
			default: //Turn on LED for bad instrucion
			RED=1;
			GRN=0;
			YLW=0;
			
		}
		
		instruction=0;
	}
	return 0;
}

//---Function Implementations---

/*	getDistance(): calculates the linear distance from the beacon using
 *				   the EXT interrupt to interpret the beacon's signal
 *	Requires: external interrupt 0
 *	Modify:	  distance
 *	Returns:  distance to beacon   
 */
unsigned int getDistance() 
{
	return 0;
}

/*	getAngle(): computes the angle that the car must turn to align with
 *              the beacon
 *	Requires: leftSensor, rightSensor
 *  Modify:   angle
 *  Returns:  angle to turn car chassis in degrees 
 */
float getAngle()
{
	//SIMULATE
	return angle;
}

/*	getDirection(): find which the direction the car need turn L/R
 *	Requires: angle
 *	Modify:   turnDirection
 *	Returns:  direction to turn car, left or right
 */
char getDirection()
{
	
	//SIMULATE
	return 0;
}

/*	turnCar(): turn both wheels individually to align vehicle with angle
 *	Requires: leftPwm, rightPwm, turnDirection
 *	Modify:	 n/a
 *	Returns:  n/a
 */
void turnCar(unsigned int Lwheel, unsigned int Rwheel)
{
	//turn towards beacon until parallel voltage becomes weakest and starts to rise
	Lwheel=0;
	Rwheel=0;
	return;
}

/*	moveCar(): move the car to next node
 *  Requires: distance
 *  Modify:   n/a
 *  Returns:  n/a
 */
void moveCar(char direction)
{
	int i;
	int Stage=6;
	//find distance Node
	distance=getDistance();
	for (i=0; i< 6; i++)
	{
		if ( distance < PRESETS[i]+3 && distance > PRESETS[i]-3 )
			Stage=i;
	}
	if(direction > 0 && distance > PRESETS[0])           //forwards
	{
		while(distance < PRESETS[Stage-1])
		{
			pwmLeft=pwmRight=75;
			distance--;
			
			//distance=getDistance();
		}
	} else if (direction < 0 && distance < PRESETS[5])	 //backwards
	{
		while(distance > PRESETS[Stage+1])
		{
			pwmLeft=pwmRight=(-75);
			distance++;
			
			//distance=getDistance();
		}
	} else                                               //error
	{
		RED=1;
		GRN=0;
		YLW=0;
	}
	pwmLeft=pwmRight=0;
	return;
}

// wait for 2 milliseconds
void wait2ms (void)
{
	_asm	
		;For a 22.1184MHz crystal one machine cycle 
		;takes 12/22.1184MHz=0.5425347us
	J3:	mov R4, #10
	J2:	mov R3, #184
	J1:	djnz R3, J1 ; 2 machine cycles-> 2*0.5425347us*184=200us
	    djnz R4, J2 ; 200us*250=0.05s
	    ret
    _endasm;
}

// wait for one second
void wait1s (void)
{
	_asm	
		;For a 22.1184MHz crystal one machine cycle 
		;takes 12/22.1184MHz=0.5425347us
	    mov R2, #20
	L3:	mov R1, #248
	L2:	mov R0, #184
	L1:	djnz R0, L1 ; 2 machine cycles-> 2*0.5425347us*184=200us
	    djnz R1, L2 ; 200us*250=0.05s
	    djnz R2, L3 ; 0.05s*20=1s
	    ret
    _endasm;
}


