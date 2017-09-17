
/*
  Arduino Sensor
  Used to Read MaxSonar MB1210
  Written for Arduino Uno
  Reading Pin A0 output (# being the pin for PW, AN, or TX)
  Started 12/22/2016
  by Haig Armen
*/
#include "QuickStats.h"

QuickStats stats; //initialize an instance of this class

int i;           // Variables
float averG;
int sum = 0;     // Variable to calculate SUM
const int numReadings = 60;         // Quantity of values to average
float readings[numReadings];

const int anPin = 0;
float anVolt, mm, inches;

void setup() {
  Serial.begin(9600);
}

void read_sensor() {
  for (i = 0; i < numReadings ; i++) {
    readings[i] = analogRead(anPin);
//    sum += analogRead(anPin);

    delay(1);
  }
  averG = stats.average(readings,numReadings);
  mm = averG * 5;
  inches = mm / 25.4;
  sum = 0;
}

void print_range() {
/*  
  Serial.println("Descriptive Statistics");
  Serial.print("Average: ");
  Serial.println(stats.average(readings,numReadings));
  Serial.print("Geometric mean: ");
  Serial.println(stats.g_average(readings,numReadings));
  Serial.print("Minimum: ");
  Serial.println(stats.minimum(readings,numReadings));
  Serial.print("Maximum: ");
  Serial.println(stats.maximum(readings,numReadings));
  Serial.print("Standard Deviation: ");
  Serial.println(stats.stdev(readings,numReadings));
  Serial.print("Standard Error: ");
  Serial.println(stats.stderror(readings,numReadings));
  Serial.print("Coefficient of Variation (%): ");
  Serial.println(stats.CV(readings,numReadings));
  Serial.print("Median: ");
  Serial.println(stats.median(readings,numReadings));
  Serial.print("Mode: ");
  Serial.println(stats.mode(readings,numReadings,0.00001));
*/

  Serial.println(inches);  //Print average of all measured values
  Serial.println(inches);  //Print average of all measured values
}

void loop() {
  read_sensor();
  print_range();
  delay(100);
}


