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
  LCD.setCursor(0,0); LCD.print("Frequency");
  int waveIn;
  waveIn = digitalRead(0);
  double totalTime;
  int iter = 10000;
  int x;
  for (x = 0; x < iter; x++) {
     double timeStart = millis();
     while (waveIn == HIGH) {waveIn = digitalRead(0);}
     while (waveIn == LOW) {waveIn = digitalRead(0);}
     double timeEnd = millis();
     double time = timeEnd - timeStart;
     totalTime += time;
  }
  double averageTime = totalTime / iter;
  LCD.setCursor(0,1); LCD.print(1/(averageTime/1000));
}
