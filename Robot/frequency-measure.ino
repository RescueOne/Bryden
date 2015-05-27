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
  int pinNumber = 2;
  int variable = LOW;
  LCD.setCursor(0,0); LCD.print("Frequency Test");
  LCD.setCursor(0,1);
  variable = digitalRead(pinNumber);
  int count = 0;
  double totalTime;
  while( count < 1000 ) {
   count++;
   if(variable == HIGH){
      double timeStart = millis();
      while(variable == HIGH){
        variable = digitalRead(pinNumber);
      }
      while(variable == LOW){
        variable = digitalRead(pinNumber);
      }
      double timeEnd = millis();
      double time = timeEnd - timeStart;
      totalTime += time;
//      double tempFreq = 1/(time/1000.0);
//      freq += tempFreq;
     }
     
  }
  double avTime = totalTime/(1000.0*1000.0);
  double freq = 1/avTime;
//  int val;
//  if( Serial.available() > 0)
//  {
//    val = Serial.read(); 
//  }
//  analogWrite(freq, val);
  LCD.print(freq);
}

