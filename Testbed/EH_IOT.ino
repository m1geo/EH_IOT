/*
 Energy Harvesting For The Internet-of-Things: Measurements And Probability Models
 
 George Smart <g.smart@ee.ucl.ac.uk>
 John Atkinson <john.atkinson.10@ucl.ac.uk>
 
 Department of Electronic & Electrical Engineering
 University College London
 
 13 July 2015
 
 SD Card Interconnects attach to SPI the bus as follows:
  - MOSI    - pin 11
  - MISO    - pin 12
  - CLK     - pin 13
  - CS      - pin 10

 Analog Sensors Interconnects:
  - Solar   - pin A0
  - Diode   - pin A1
  - Thermal - pin A2
  - Piezo   - pin A3
  
 Envronment Sensors:
  - DHT11   - pin 2
  - BH1750  - I2C Bus (A4/A5)
  
 Debug LEDs:
  - Solar   - pin 4
  - Diode   - pin 5
  - Thermal - pin 6
  - Piezo   - pin 7
*/

#include <SPI.h>
#include <SD.h>
#include <Wire.h>
#include <BH1750.h>
#include "DHT.h"

// Ethernet Shield, CS = pin 4.
// Standard SD Sheild, CS = pin 10.
const int chipSelect = 10;

#define DHTPIN 2
#define DHTTYPE DHT11   // DHT 11 
DHT dht(DHTPIN, DHTTYPE);
BH1750 lightMeter;

uint8_t sensor_read = 0;

unsigned long currMeasure = 0;

char filename[] = "LOGGER00.CSV"; // auto set later to be 00-99.

#define DHT    2
#define SDACT  3
#define LEDA   4
#define LEDB   5
#define LEDC   6
#define LEDD   7

void setup()
{
  // Open serial communications and wait for port to open:
  Serial.begin(115200);
  while (!Serial) {
    ; // wait for serial port to connect. Needed for Leonardo only
  }
  
  lightMeter.begin();
  dht.begin();
  
  Serial.print("Initialising SD card...");
  // set CS to output (uses default for library, even if not used)
  pinMode(10, OUTPUT);
  
  pinMode(SDACT, OUTPUT);
  pinMode(DHT,   INPUT);
  pinMode(LEDA,  OUTPUT);
  pinMode(LEDB,  OUTPUT);
  pinMode(LEDC,  OUTPUT);
  pinMode(LEDD,  OUTPUT);

  // see if the card is present and can be initialised:
  if (!SD.begin(chipSelect)) {
    Serial.println("Card failed, or not present");
    // don't do anything more:
    return;
  }
  Serial.println("Card initialised.");
  
  // find the lowest filename that's not used.
  for (uint8_t i = 0; i < 100; i++) {
   filename[6] = i/10 + '0';
   filename[7] = i%10 + '0';
   if (!SD.exists(filename)) {
    break; 
   }
  }
  
  Serial.print("Logging to: ");
  Serial.println(filename);
  
  digitalWrite(LEDA, HIGH);
  digitalWrite(LEDB, HIGH);
  digitalWrite(LEDC, HIGH);
  digitalWrite(LEDD, HIGH);
  delay(250);
  
  // write CSV column headers
  File dataFile = SD.open(filename, FILE_WRITE);
  dataFile.println("msTime,Solar,Diode,Therm,Piezo,LightMeter,TempMeter,HumiMeter");
  dataFile.close();
  
  // Strobe output LEDs
  digitalWrite(LEDA, LOW);
    delay(100);
    digitalWrite(LEDA, HIGH);
  digitalWrite(LEDB, LOW);
    delay(100);
    digitalWrite(LEDB, HIGH);
  digitalWrite(LEDC, LOW);
    delay(100);
    digitalWrite(LEDC, HIGH);
  digitalWrite(LEDD, LOW);
    delay(100);
    digitalWrite(LEDD, HIGH);  
}

uint16_t lux = 0;
double humi = 0;
double temp = 0;

void loop()
{
  currMeasure = millis();
  // force sensor reading every 300 readings (30 seconds)
  if (sensor_read == 0) {
    lux = lightMeter.readLightLevel();
    humi = dht.readHumidity();  //DHT11 is very slow
    temp = dht.readTemperature();
  }
  sensor_read++;
  if (sensor_read >= 20) {
    sensor_read = 0;
  }
  
  int Solar = analogRead(A0);
  int Diode = analogRead(A1);
  int Therm = analogRead(A2);
  int Piezo = analogRead(A3);
  
  if (Solar > 0) {digitalWrite(LEDA, LOW);} else {digitalWrite(LEDA, HIGH);}
  if (Diode > 0) {digitalWrite(LEDB, LOW);} else {digitalWrite(LEDB, HIGH);}
  if (Therm > 0) {digitalWrite(LEDC, LOW);} else {digitalWrite(LEDC, HIGH);}
  if (Piezo > 0) {digitalWrite(LEDD, LOW);} else {digitalWrite(LEDD, HIGH);}
  
  // make a string for assembling the data to log:
  String dataString = "";
  dataString += String(currMeasure);
  dataString += ",";
  dataString += String(Solar);
  dataString += ",";
  dataString += String(Diode);
  dataString += ",";
  dataString += String(Therm);
  dataString += ",";
  dataString += String(Piezo);
  dataString += ",";
  dataString += String(lux);
  dataString += ",";
  dataString += String((int)temp);
  dataString += ",";
  dataString += String((int)humi);
  
  // open the file. note that only one file can be open at a time,
  // so you have to close this one before opening another.
  File dataFile = SD.open(filename, FILE_WRITE);

  // if the file is available, write to it:
  if (dataFile) {
    digitalWrite(SDACT, HIGH);
    dataFile.println(dataString);
    dataFile.close();
    digitalWrite(SDACT, LOW);

    Serial.println(dataString);
  }
  // if the file isn't open, pop up an error:
  else {
    Serial.print("error opening ");
    Serial.println(filename);
  }
  
  // wait until the next measurement time...
  while (millis() < (currMeasure + 100));
}









