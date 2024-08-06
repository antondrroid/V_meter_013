/*
 This program created for 
 1.testing service pulses detection with defined  duty time (must be 0.3-0.5 sec with pulse/duty 1:1) 
 * Created: 27.09.2017 10:28:06
 * Author : John
 */ 

// --------------------made from sourse end ----------------------------------
 #include "main.h"
 #include <stdio.h>
 #include <string.h>
//----------------gLOBAL VARIABLES---------------------------
unsigned char call=0; //state incoming call receiving. If line busy, call wil be =1
unsigned char p=0;  //   pulse counting
unsigned char b=0;  //  break counting
unsigned int n=0; 
unsigned char seg=0;  // 0-255
unsigned int a=0;//  int=short = max 65535 for cycle for wait interrupt counting
unsigned char pulse = 0;
volatile  float HighLength=0; //0-65535 pulse interval time accumulator
volatile  float LowLength=0;  //0-65535 break interval time accumulator 
volatile  float BufferP=0; // pulse interval time
volatile  float BufferB=0;  // break interval time
volatile  float Length=0;  //0-65535
//--------------------- END VARIABLES -----------------------

// -----------------SUBROUTINE SECTION--------------

// ----------------------start segchar8535--------------------------------------
/*
This subroutine is for FOR 7SEGMENT DISPLAY OUTPUT CHARACTERS in Atmega 8535
*/
void segchar8535 (unsigned char seg)
{
	DDRA = 0xff;
	PORTA = 0x00; //clear PORTA
	
	/*_delay_ms(900);*/
	switch(seg)
	{
		//tHE RIGHT COLUMN IS IN ORDER FOR PORT. tHE  LEFT - clear port before output.
		case 0: PORTA |= 0x00;PORTA = 0b10111111;break; // numbers 0-9 dot point mean number for same character symbol, as "5." and "S"
		case 1: PORTA |= 0x00;PORTA = 0b10000110;break; // numbers 0-9
		case 2: PORTA |= 0x00;PORTA = 0b11011011;break; // numbers 0-9
		case 3: PORTA |= 0x00;PORTA = 0b11001111;break; // numbers 0-9
		case 4: PORTA |= 0x00;PORTA = 0b11100110;break; // numbers 0-9
		case 5: PORTA |= 0x00;PORTA = 0b11101101;break; // numbers 0-9
		case 6: PORTA |= 0x00;PORTA = 0b11111101;break; // numbers 0-9
		case 7: PORTA |= 0x00;PORTA = 0b10000111;break; // numbers 0-9
		case 8: PORTA |= 0x00;PORTA = 0b11111111;break; // numbers 0-9
		case 9: PORTA |= 0x00;PORTA = 0b11101111;break; //with dot point (dp) segment (don't work now, because D7 USED for D3)
		case 10: PORTA |= 0x00;PORTA = 0b01110111;break; //A  because bit2 on D is busy bit2 in portB will be set
		case 11: PORTA |= 0x00;PORTA = 0b01111111;break; // B
		case 12: PORTA |= 0x00;PORTA = 0b01111100;break; //b
		case 13: PORTA |= 0x00;PORTA = 0b00111001;break; //C
		case 14: PORTA |= 0x00;PORTA = 0b01011000;break; //c small
		case 15: PORTA |= 0x00;PORTA = 0b01011110;break; //d
		case 16: PORTA |= 0x00;PORTA = 0b01111001;break; //E
		case 17: PORTA |= 0x00;PORTA = 0b01111011;break; //e
		case 18: PORTA |= 0x00;PORTA = 0b01110001;break; //F
		case 19: PORTA |= 0x00;PORTA = 0b00111101;break; //G
		case 20: PORTA |= 0x00;PORTA = 0b01110110;break; //H
		case 21: PORTA |= 0x00;PORTA = 0b00011110;break; //J
		case 22: PORTA |= 0x00;PORTA = 0b00111000;break; //L
		case 23: PORTA |= 0x00;PORTA = 0b00110000;break; //L small "l"
		case 24: PORTA |= 0x00;PORTA = 0b00111111;break; // O
		case 25: PORTA |= 0x00;PORTA = 0b01011100;break; //o
		case 26: PORTA |= 0x00;PORTA = 0b01110011;break; //P
		case 27: PORTA |= 0x00;PORTA = 0b01100111;break; //q
		case 28: PORTA |= 0x00;PORTA = 0b01010000;break; //r
		case 29: PORTA |= 0x00;PORTA = 0b01101101;break; //S
		case 30: PORTA |= 0x00;PORTA = 0b01110000;break; //T
		case 31: PORTA |= 0x00;PORTA = 0b01111000;break; //t
		case 32: PORTA |= 0x00;PORTA = 0b00111110;break; //U
		case 33: PORTA |= 0x00;PORTA = 0b01001111;break; //W (turned CCW)
		case 34: PORTA |= 0x00;PORTA = 0b01101110;break; //y
		case 35: PORTA |= 0x00;PORTA = 0b00001100;break; //rising edge
		case 36: PORTA |= 0x00;PORTA = 0b00011000;break; //falli8ng edge
		case 37: PORTA |= 0x00;PORTA = 0b01000001;break; //=  2 parallel lines upper
		case 38: PORTA |= 0x00;PORTA = 0b01001000;break; //=  2 parallel lines lower
		case 39: PORTA |= 0x00;PORTA = 0b01001001;break; //=_  3 parallel lines
		case 40: PORTA |= 0x00;PORTA = 0b01001001;break; //=  2 parallel lines vert
		case 41: PORTA |= 0x00;PORTA = 0b10000000;break; // dot point
		case 42: PORTA |= 0x00;PORTA = 0b00000000;break; // clear screen
		case 43: PORTA |= 0x00;PORTA = 0b00011100;break; // u
		case 44: PORTA |= 0x00;PORTA = 0b01010100;break; // n
	}
}
//----------------------END SEGCHAR8535----------------------
//---------------------- Start of intervalBreak------------------------------------
void intervalBreak (void)//  lenghth interval  time
{
	if(b<4)
		{
		BufferB = TCNT1;     //keep last break interval time
		TCNT1 = 0;  //clear timer
		MCUCR = (1<<ISC01)|( 1<<ISC00); // FALLINGEDGE	
		b++;	
		GICR = 1<<INT0; //int0 enable
		}
}
//======================= End of intervalBreak===================================
//---------------------- Start of intervalPulse ------------------------------------
void intervalPulse (void)   // we are here because of rising edge (L3)
{
	if(p<4)
		{
	    BufferP = TCNT1;     //keep last break interval time
	    TCNT1 = 0;  //clear timer
		MCUCR = (1<<ISC01)|( 0<<ISC00); //Set interrupt requests  INT0-rising Edge
		b++;
		GICR = 1<<INT0; //int0 enable
		}
 		
}
//======================= End of intervalPulse===================================
void StartCall (void) //start conversation and wait end of  call signals
{
	_delay_ms(1600); //delay for security switching  to line1 line2  while break between pulses
	PORTC = (1<<PC4);
	call=1;
}
void EndCall (void)   //hang up if find end of call sequense or button call/end of call was pressed
  {
	  PORTC = (0<<PC4);
	  call=0;
	  _delay_ms(4000);
	  GICR = 1<<INT1; //int1 enable
  }
//--------------------  start ISR INT0 ------------------------
ISR (INT0_vect)   //rising Edge Pin Change Interrupt Request
{
	GICR = 0<<INT0; // stop  interrupt while 
	if (MCUCR==0b00000011) //if it was interrupt by RISING edge, the break is end so we start count pulse length
		{
			intervalPulse(); // change interrupt by falling edge we can count HighLength
		}
	else   //otherwise (if wasn't by Rising edge -> it's mean, that it was falling Edge, --> 
	       // it's the start of duty period & we can start measuring break length
		{
			intervalBreak();
		}
}
//=====================================END OF ISR INT0 ========================
//--------------------  start ISR INT1 ------------------------
ISR (INT1_vect)   //rising Edge Pin Change Interrupt Request
{
	GICR = 0<<INT1; // stop  interrupt while switch line
	switch (call)
		{                                                                                                                                                                        
			case 0 :      //line is free - button engage K1 relay
				StartCall();	
			break;
			case 1 :       
				EndCall();	
			break;
		}
}
//=====================================END OF ISR INT1 ========================
//-------------- CALLwait            --------------------------
/* listen  line and check if the pulse or change level exist, 
   then engage relay and switch line to conversation        */

void   CallWait(void)
{	
	 /*USART_Transmit(0x0d);*/
	 a=0;
	 while (call==0)	 
		{
			//---------display
			seg=5;//"5"
			segchar8535(seg); //for segchar8535 use
			_delay_ms(600);
			seg=41;//"dp"
			segchar8535(seg); //for segchar8535 use
			_delay_ms(600);
			seg=42;//"clear screen"
			segchar8535(seg); //for segchar8535 use
			_delay_ms(600);
			//---------& display
			GICR = 1<<INT1;  //External Interrupt Request 1 Enable (bit7)
			a++;
		}						 
}//-------------- &CALL waiting            -------------------------- 

  //------------------start PulseScale   -------------------------
 void PulseScale(void) //for pulse and duty measure
 {
//------------------- timer settings -------------------	 
	 TCCR1B = TCCR1B | 0x05; //set timer  from prescaler /1024
//------------------ & of 	timer settings -------------------
                                                                                                                                                    
//-----------------  listen EOC pulses while conversation-----------------------------/	
	pulse=0; //EOC  sequense not discovered
	while ((pulse==0)&(call==1)) 
	{//---------------- DutyCheck ----------------------------------------------		
		a=0; 
		GICR = 1<<INT1;  //External Interrupt Request 1 Enable (bit7)
//---------display
_delay_ms(60);seg=16;//"E"
segchar8535(seg);_delay_ms(60);
seg=24;//"O"
segchar8535(seg); _delay_ms(60);
seg=13;//"C"
segchar8535(seg);_delay_ms(60); 
//---------& display		                                                                                                                                                                                                                                                                                                                                                                                                                          	 sei();
		while ((p<3)&&(b<3))          //just for load processor and listening INT0
			{	
					GICR = 1<<INT0;  //External Interrupt Request 0 Enable (bit6)
					a++;	
	 				if (call==0)
						{
							goto OUT_OF_LIMITS;
						}
//----------------------insurance EndCall if no end of call sequence decoded
					_delay_ms(1);
					if (a>29500) //15500=16sec 29500=30sec
						{
							EndCall();
						}		
//===================== &	insurance EndCall ===========================
			}	//-------------------  end EOC receiving and check duty ratio	
		GICR = 0<<INT0; //int0 disable	                                            
		p=0;b=0;  //after four cycles will start new measuring pulses
		float Ratio = 0;
		if ((BufferP>=2100)&&(BufferP<=4300))
		/*if ((HighLength>=2109)&&(HighLength<=4297))*/
			{
				Ratio = (BufferP/BufferB);
			}
		else
			{
				goto OUT_OF_LIMITS;
			}
		if ((Ratio>0.8)&&(Ratio<1.20)) //check if pulse equal to duty
			{	
				EndCall();
				GICR = 1<<INT0; //int0 enable				
//------------------display				
                    n=0;
				while 	(n<5)
					{
						seg=24;//"O"				
						segchar8535(seg); //for segchar8535 use
						_delay_ms(600);
						seg=20;//"H"
						segchar8535(seg); //for segchar8535 use
						_delay_ms(600);
						n++;
					}
//------------------ & display						
			}
		else //continue listen EOC pulse
			{
				OUT_OF_LIMITS:
                //------------------display
				n=0;
				while 	(n<5)
					{
						 seg=16;//"E"
						 segchar8535(seg); //for segchar8535 use
						 _delay_ms(6);
						 seg=28;//"r"
						 segchar8535(seg); //for segchar8535 use
						 _delay_ms(6);
						 n++;
					}				
				//------------------ & display
				GICR = 1<<INT0; //int0 enable
			}
	}//------------------& DutyCheck ----			
}//--------------------the & PulseScale  ------------------------ 
//------------------------- the END OF SUBROUTINE SECTION ----------------
 int main(void)
{
//	TestPortDC();
//------------- Ports settings ----------------------
	DDRC =    0b11111111;  //set port C to output high digits 7-0
	PORTC =  0b00000000;  //set port C pins state  to low and pull-up inputs
	DDRD  =    0b00000010; //set port D to input, D1 is out -TXD while  D0 - will be input(D0 is RXD)
	PORTD =   (0b00000011); //set port D pins state  to ~ high
	PORTC = (0<<PC4);
	call=0; //no connection now
// --------------- & of Port settings
//---------------Int settings	
	 MCUCR = (1<<ISC11)|( 1<<ISC10);   //Set interrupt requests for int1 input pin: 10 falling  00 low lewel on INT1
	 GICR = 1<<INT1;  //External Interrupt Request 1 Enable (bit7)
	 MCUCR = (1<<ISC01)|( 1<<ISC00);   //Set interrupt requests for 2ND input pin: INT0-rising Edge
//------------------ & 	
sei();	//sei();
//--------------------  &USART initialisation& -----------------	
while(1)
	{	
//-------------- CALLwait listen  line and check if the pulse or change level exist,then engage relay and switch line to conversation  --------------------------
	CallWait();
//-------------- &CALL wait            --------------------------		
//---------------------start pulse measuring -------------------	
	PulseScale();	
//----------------------end of pulse measuring ------------------	
	}
}
