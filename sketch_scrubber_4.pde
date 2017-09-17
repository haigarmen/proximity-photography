/* Proximity Photography
 by Haig Armen 
 May 2017
 Using arduino with ultrasonic sensor to feed value via serial port
 then scrub through an array of still images
 */

import processing.serial.*;
import java.io.File;

String [] filenames;
PImage[] images = new PImage[115];
int currentFrame = 0;
int scrubNum;
int position;
float scrubberFrame;
int minDistance = 10;
int maxDistance = 40;
float sensorValue = 0;
int scrubNumOld = 0;
int frameDifference;

Serial myPort;  // Create object from Serial class
String val;      // Data received from the serial port

void setup() {
  //fullScreen();
  size(1080, 608);
  frameRate(30);

  // load images from Data Folder dynamically
  java.io.File dir = new java.io.File(dataPath(""));
  filenames = dir.list();
  for (int i = 0; i <= filenames.length - 1; i++) {
    images[i] = loadImage(filenames[i]);
  } 

  String portName = Serial.list()[3];
  myPort = new Serial(this, portName, 9600);
  //  printArray(Serial.list());
} 

void draw() { 
  background(0);
  textSize(14);
  int position = mouseX;
  if ( myPort.available() > 0) {  // If data is available,
    val = myPort.readStringUntil('\n');// read it and store it in val
    println(val);
    if (val == null) {
      image(images[scrubNum], 0, 0, width, height);
    }
  }
  if (val != null) {
    sensorValue = float(val);
    if (sensorValue <= minDistance) {
      image(images[1], 0, 0, width, height);
      text("Minimum Frame Number ", 10, height-15);
    }
    if (sensorValue >= maxDistance) {
      image(images[(images.length-1)], 0, 0, width, height);
      text("Maximum Frame Number", 10, height-15);
    }
    if ((sensorValue > minDistance) && (sensorValue < maxDistance)) {
      float scrubberFrame = map(sensorValue, minDistance, maxDistance, 0, (images.length-1));
      scrubNum = int(round(scrubberFrame));

      //currentFrame = (currentFrame+1) % (images.length-1);  // Use % to cycle through frames
      //frameDifference = scrubNum - scrubNumOld;
      image(images[scrubNum], 0, 0, width, height);

      text("sensor value: " + sensorValue, 10, height-45);
      text("calculation: " + scrubberFrame, 10, height-30);
      text("Frame number: " + scrubNum, 10, height-15);
    }
    scrubNumOld = scrubNum;
  }
}

int roundToN(float a, int n) {
  return (round(a/n)*n);
} 