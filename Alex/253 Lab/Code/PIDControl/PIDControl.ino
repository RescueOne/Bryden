////////////////////////////////////////////////
// TINAH PID w/ Menu Program
// UBC Engineering Physics 253
// (fogelman, 2015 June 10)
/////////////////////////////////////////////////

#include <avr/EEPROM.h>
#include <phys253.h>          
#include <LiquidCrystal.h>

/*
*  Creates a "map" with the location of an EEPROM address
*  EEPROM = TINAH storage
*/
class MenuItem
{
public:
	String    Name;
	uint16_t  Value;
	uint16_t* EEPROMAddress;
	static uint16_t MenuItemCount;
	MenuItem(String name)
	{
		MenuItemCount++;
		EEPROMAddress = (uint16_t*)(2 * MenuItemCount);
		Name 		  = name;
		Value         = eeprom_read_word(EEPROMAddress);
	}
	void Save()
	{
		eeprom_write_word(EEPROMAddress, Value);
	}
};

/* Initializing the Menu Items */
uint16_t MenuItem::MenuItemCount = 0;
// Add the menu items here
MenuItem Speed            = MenuItem("Speed");
MenuItem ProportionalGain = MenuItem("P-gain");
MenuItem DerivativeGain   = MenuItem("D-gain");
MenuItem IntegralGain     = MenuItem("I-gain");
MenuItem menuItems[]      = {Speed, ProportionalGain, DerivativeGain, IntegralGain};

/* Set up TINAH Board */
void setup()
{  
  #include <phys253setup.txt>
  Serial.begin(9600);
  LCD.clear();
  LCD.home();
  
}

/* Variables */
// Initial PID constants / Values
int P_gain = 0; // "k" constants
int I_gain = 0;
int D_gain = 0;
int proportional = 0;
int derivative = 0;
int integral = 0;
int compensator = 0; // what we need to adjust our speed by in order to fix the tape following

// QRD setup
int left_pin = 0;
int right_pin = 2;
int qrd_left = 0;
int qrd_right = 0;

// Error Handling
int threshold = 70; // threshold analog value reading
int error = 0;
int last_error = 0;
int recent_error = 0;
int sum_error = 0;
int last2_error = 0;
int current_duration = 0;
int previous_duration = 0;
int qrd_seperation = 5; // distance between qrd's

// Motor
int motor_left = 2;
int motor_right = 3;
int motor_speed = 0;

void loop()
{
	LCD.clear(); LCD.home();
	LCD.print("Start+stop=menu");
	LCD.setCursor(0, 1);
	LCD.print("Start=run");
	delay(100);
 
	if (startbutton() && stopbutton())
	{
		delay(100);
		if (startbutton())
		{
			Menu();
		}
	}
        if (startbutton())
        {       
                LCD.clear();
                // control theory code:
                PID();
                
                // Used for testing QRDs
//                while(!stopbutton())
//                {
//                      LCD.clear(); LCD.home();
//            	      qrd_left = analogRead(left_pin);
//                      qrd_right = analogRead(right_pin);
//                      LCD.print(qrd_left);
//                      LCD.setCursor(0, 1);
//                      LCD.print(qrd_right);
//                      motor.speed(motor_left,-100);
//                      motor.speed(motor_right,100);
//                      delay(100);
//                }
                motor.speed(motor_left,0);
                motor.speed(motor_right,0);
        }
}

/*
* Function for PID control
*/
void PID()
{
     motor_speed = menuItems[0].Value;
     P_gain = menuItems[1].Value;
     D_gain = menuItems[2].Value;
     I_gain = menuItems[3].Value;
     
     error = 0;
     
     int count = 0;
     
     while(true)
     {
         LCD.home();
       
         qrd_left = analogRead(left_pin);
         qrd_right = analogRead(right_pin);
         
         /* Determining the value of the error */
         if(qrd_left > threshold){
           if(qrd_right > threshold) {error = 0; LCD.print("CE");} 
           else {error = -1; LCD.print("R1");} 
         } else {
           if(qrd_right > threshold) {error = 1; LCD.print("L1");}
           else {
             if (last_error <= 0) {error = -5; LCD.print("R2");} 
             else {error = 5; LCD.print("L2");}
           }
         }
         
         // If the error is not the same as it previously was
         // set up derivative approiximation
         if( error != last_error )
         {
               recent_error = last_error;
               previous_duration = current_duration;
               current_duration = 1;
         }
         
         proportional = P_gain * error;
         
         // Is there a better way to approiximate the derivative?
         // Problems: in 2 iterations if error != last_error, the 2nd time the run = 2
         derivative = (int) ( (float) D_gain * (float) (error - recent_error) / ( (float) (previous_duration + current_duration) ) );
         
         // Other implementation
         // derivative = D_gain * (error - last_error)
         
         sum_error += error;
         integral = I_gain * sum_error;
         
         // to prevent the integral error from getting too large
         if (sum_error > qrd_seperation)
         {
               sum_error = 5; 
         }
         if (sum_error < -qrd_seperation)
         {
               sum_error = -5; 
         }
         
         /*
         Complex Algorithm
         compensator = ( P_gain + I_gain + D_gain ) * ( error - last_error + I_gain * current_duration * error + ( (float) D_gain / (float) current_duration ) * (error - 2 * last_error + last2_error);
         */
         
         // set compensator function = P + D
         compensator =  proportional + derivative + integral;
         
         // Display current status
         if( count == 50)
         {
               // TODO: Change this to something that works?
               printf("%d %d %d %d %d %d\n",qrd_left,qrd_right,P_gain,D_gain,proportional,derivative);
               count = 0;
         }
         count++;
         
         /* Motor speed */
         motor.speed(motor_left,compensator - motor_speed);
         motor.speed(motor_right,compensator + motor_speed);
         
         // increment iterations and set last error
         current_duration++;
         last_error = error;
         //last2_error = last_error;
     }
}

/*
* Function that defines the behaviour of the menu once selected.
*
*/
void Menu()
{
	LCD.clear(); LCD.home();
	LCD.print("Entering menu");
	delay(500);
 
	while (true)
	{
		/* Show MenuItem value and knob value */
		int menuIndex = knob(6) * (MenuItem::MenuItemCount) / 1024;
		LCD.clear(); LCD.home();
		LCD.print(menuItems[menuIndex].Name); LCD.print(" "); LCD.print(menuItems[menuIndex].Value);
		LCD.setCursor(0, 1);
                int val = knob(7);
                if(menuIndex == 0)
                {
                  val = (val / 511.5 - 1.0) * 255;
                }
		LCD.print("Set to "); LCD.print(val); LCD.print("?");
		delay(100);
 
		/* Press start button to save the new value */
		if (startbutton())
		{
			delay(100);
			if (startbutton())
			{
                                // Can max motor speed at +-700 so capping the speed at 700
                                if (menuIndex == 0)
                                {
                                        if ( val > 700) {
                                                LCD.clear(); LCD.home();
                                                LCD.print("Speed capped at 700.");
                                                val = 700;
                                                delay(250);
                                        }
                                }
                                
                                menuItems[menuIndex].Value = val;
				menuItems[menuIndex].Save();
				delay(250);
			}
		}
 
		/* Press stop button to exit menu */
		if (stopbutton())
		{
			delay(100);
			if (stopbutton())
			{
				LCD.clear(); LCD.home();
				LCD.print("Leaving menu");
				delay(500);
				return;
			}
		}
	}
}

