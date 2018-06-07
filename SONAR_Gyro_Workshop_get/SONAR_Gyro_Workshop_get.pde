import http.requests.*;
import themidibus.*; //Import the library

MidiBus myBus; // The MidiBus

GyroBuss gyro01;
GyroBuss gyro02;
GyroBuss gyro03;
GyroBuss gyro04;
GyroBuss gyro05;

public void setup() 
{
  size(400, 400);
  smooth();

  //gyro 1
  gyro01 = new GyroBuss("http://18.111.10.32/");

  //delta theshold value
  gyro01.setDeltaThreshold(2, 8, 5);

  //mapping range
  gyro01.setRangeGyroX(-220, 200);
  gyro01.setRangeGyroY(-220, 200);
  gyro01.setRangeGyroZ(-220, 200);

  //set channel midi output for z, y, z
  gyro01.setChannel(0, 0, 0);


  gyro02 = new GyroBuss("http://18.111.10.32/");
  gyro03 = new GyroBuss("http://18.111.10.32/");
  gyro04 = new GyroBuss("http://18.111.10.32/");
  gyro05= new GyroBuss("http://18.111.10.32/"); 



  frameRate(60); // 60 frames por segundo
  println("finish");

  MidiBus.list(); // List all available Midi devices on STDOUT. This will show each device's index and name.
  myBus = new MidiBus(this, 0, 1);
}


void draw() {
  gyro01.processGyroMidi();
}

void keyPressed() {
  if (key == '1') {
    gyro01.getContent();
  }

  if (key == '2') {
    gyro02.getContent();
  }

  if (key == '3') {
    gyro03.getContent();
  }

  if (key == '4') {
    gyro04.getContent();
  }

  if (key == '5') {
    gyro05.getContent();
  }
}