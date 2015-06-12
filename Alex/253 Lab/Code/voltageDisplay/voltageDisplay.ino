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
  int analogPin = 0;
  double Vout;
  double factor = 5.0 / 1023.0;
  //LCD.clear(); LCD.home();
  LCD.setCursor(0,0); LCD.print("Vout");
  while (true) {
    Vout = ((double) analogRead(analogPin)) * factor;
    LCD.setCursor(0,1); LCD.print(Vout);
    delay(200);
    if (stopbutton()) {
      break; 
    }
  }
}

