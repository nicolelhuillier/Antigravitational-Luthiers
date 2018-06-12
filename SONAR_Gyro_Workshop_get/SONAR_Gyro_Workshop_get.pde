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

  gyro01 = new GyroBuss("http://18.111.22.145/");
  gyro02 = new GyroBuss("http://18.111.26.121/");
  gyro03 = new GyroBuss("http://18.111.2.182/");
  gyro04 = new GyroBuss("http://18.111.2.12/");
  gyro05= new GyroBuss("http://18.111.27.196/"); 


  //delta theshold value
  gyro01.setDeltaThreshold(2, 8, 5);
  gyro02.setDeltaThreshold(2, 8, 5);
  gyro03.setDeltaThreshold(2, 8, 5);
  gyro04.setDeltaThreshold(2, 8, 5);
  gyro05.setDeltaThreshold(2, 8, 5);

  //mapping range
  gyro01.setRangeGyroX(-220, 200);
  gyro01.setRangeGyroY(-220, 200);
  gyro01.setRangeGyroZ(-220, 200);

  //mapping range
  gyro02.setRangeGyroX(-220, 200);
  gyro02.setRangeGyroY(-220, 200);
  gyro02.setRangeGyroZ(-220, 200);

  //mapping range
  gyro03.setRangeGyroX(-220, 200);
  gyro03.setRangeGyroY(-220, 200);
  gyro03.setRangeGyroZ(-220, 200);


  //mapping range
  gyro04.setRangeGyroX(-220, 200);
  gyro04.setRangeGyroY(-220, 200);
  gyro04.setRangeGyroZ(-220, 200);


  //mapping range
  gyro05.setRangeGyroX(-220, 200);
  gyro05.setRangeGyroY(-220, 200);
  gyro05.setRangeGyroZ(-220, 200);

  //set channel midi output for z, y, z
  gyro01.setChannel(0, 0, 0);
  gyro02.setChannel(1, 1, 1);
  gyro03.setChannel(2, 2, 2);
  gyro04.setChannel(3, 3, 3);
  gyro05.setChannel(4, 4, 4);


  frameRate(60); // 60 frames por segundo
  println("finish");

  MidiBus.list(); // List all available Midi devices on STDOUT. This will show each device's index and name.
  myBus = new MidiBus(this, 0, 1);
}


void draw() {
  gyro01.processGyroMidi();
  gyro02.processGyroMidi();
  gyro03.processGyroMidi();
  gyro04.processGyroMidi();
  gyro05.processGyroMidi();

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