////////////////////////////////////////////////
// TINAH Template Program - UBC Engineering Physics 253
// (nakane, 2015 Jan 2)  - Updated for use in Arduino IDE (1.0.6)
/////////////////////////////////////////////////

#include <phys253.h>          
#include <LiquidCrystal.h>    

void setup()
{  
  #include <phys253setup.txt>
  Serial.begin(9600) ;
  
}

void loop()
{
  int KNOB = 6;
  int MOTOR = 0;
  
  LCD.setCursor(0,0); LCD.print("POWER");
  
  while (true) {
    double knob6 = knob(KNOB);
    int speedM = (knob6/2.0)-254.5;
    motor.speed(MOTOR, speedM);
    LCD.setCursor(0,1); LCD.print("      "); 
    LCD.setCursor(0,1); LCD.print(speedM);
  }
}
