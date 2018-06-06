import http.requests.*;
import themidibus.*; //Import the library

MidiBus myBus; // The MidiBus

String IP = "http://18.111.10.32/";

int gyroX = 0;
int gyroY = 0;
int gyroZ = 0;

int gyroXDelta = 0;
int gyroYDelta = 0;
int gyroZDelta = 0;

int mapGyroX = 0;
int mapGyroY = 0;
int mapGyroZ = 0;

//sesibilidad
int deltaX = 2;
int deltaY = 8;
int deltaZ = 5;

public void setup() 
{
  size(400, 400);
  smooth();

  GetRequest get = new GetRequest(IP);
  get.send();
  println("Reponse Content: " + get.getContent());
  // println("Reponse Content-Length Header: " + get.getHeader("Content-Length"));

  frameRate(60); // 60 frames por segundo
  println("finish");

  MidiBus.list(); // List all available Midi devices on STDOUT. This will show each device's index and name.
  myBus = new MidiBus(this, 0, 1);
}


void draw()

{ 
  if ( frameCount % 1 ==  0) {
    GetRequest get = new GetRequest(IP);
    get.send();
    //println("Reponse Content: " + get.getContent());

    String content = get.getContent();
    String[] output = content.split(" ");

    for (int i = 0; i < output.length; i++) {
      // println(output[i]);
      if (output[i].equals("X:")) {
        gyroXDelta = gyroX;
        gyroX = int(output[i + 1]);
      }
      if (output[i].equals("Y:")) {
        gyroYDelta = gyroY;
        gyroY = int(output[i + 1]);
      }

      if (output[i].equals("Z:")) {
        gyroZDelta = gyroZ;
        gyroZ = int(output[i + 1]);
      }
    }

    println("X: "+gyroX+" Y: "+gyroY+" Z: "+gyroZ);

    //x
    if (abs( gyroX - gyroXDelta) > deltaX) {
      mapGyroX = int(map(gyroX, -220, 220, 0, 127));
      // - num min gyro (-127), num max gyro (127) cambiar con infor gyro
      myBus.sendNoteOn(0, mapGyroX, 127);
    }

    //y
    if (abs( gyroY - gyroYDelta) > deltaY) {
      mapGyroY = int(map(gyroY, -220, 220, 0, 127));
      
      // - num min gyro (-127), num max gyro (127) cambiar con infor gyro
     // myBus.sendNoteOn(1, mapGyroY, 127);
    }

    //z
    if (abs( gyroZ - gyroZDelta) > deltaZ) {
      mapGyroZ = int(map(gyroZ, -220, 220, 0, 127));
      
      // - num min gyro (-127), num max gyro (127) cambiar con infor gyro
      //myBus.sendNoteOn(2, mapGyroZ, 127);
    }


    //myBus.sendNoteOn(0, mapX, 127); // (channel, pitch, velocity) --- with velocity 0 there was no sound
    // myBus.sendNoteOn(1, mapY, 127); // (channel, pitch, velocity) --- with velocity 0 there was no sound
    //myBus.sendNoteOn(2, mapZ, 127); // (channel, pitch, velocity) --- with velocity 0 there was no sound

    //delay(200);

    //myBus.sendNoteOff(0, mapX, 127);
    //myBus.sendNoteOff(1, mapY, 127);
    //myBus.sendNoteOff(2, mapZ, 127);

    // println("Reponse Content-Length Header: " + get.getHeader("Content-Length"));
    println("get");
  }
}

void keyPressed() {
  if (key == 'a') {
    println("get");
    GetRequest get = new GetRequest(IP);
    get.send();
    println("Reponse Content: " + get.getContent());
    //println("Reponse Content-Length Header: " + get.getHeader("Content-Length"));
  }
}

/*void noteOn(int channel, int pitch, int velocity) {
 // Receive a noteOn
 println();
 println("Note On:");
 println("--------");
 println("Channel:"+channel);
 println("Pitch:"+pitch);
 println("Velocity:"+velocity);
 }*/

/*void sendNote(int pitch, int channel) {
 
 int velocity = 127;
 
 myBus.sendNoteOn(channel, pitch, velocity); // Send a Midi noteOn
 delay(200);
 myBus.sendNoteOff(channel, pitch, velocity); // Send a Midi nodeOff
 
 int number = 0;
 int value = 60;
 
 myBus.sendControllerChange(channel, number, value); // Send a controllerChange
 //delay(2000);
 
 }*/