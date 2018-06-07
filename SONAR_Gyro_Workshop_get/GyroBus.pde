class GyroBuss {

  String IP = "";
  int gyroX = 0;
  int gyroY = 0;
  int gyroZ = 0;

  int minGyroX;
  int maxGyroX;

  int minGyroY;
  int maxGyroY;

  int minGyroZ;
  int maxGyroZ;

  int gyroXDelta = 0;
  int gyroYDelta = 0;
  int gyroZDelta = 0;

  int mapGyroX = 0;
  int mapGyroY = 0;
  int mapGyroZ = 0;

  //sesibilidad
  int deltaX;
  int deltaY;
  int deltaZ;

  int midiChannelX;
  int midiChannelY;
  int midiChannelZ;

  GyroBuss(String IP) {
    this.IP = IP;

    this.deltaX = 2;
    this.deltaY = 8;
    this.deltaZ = 5;

    midiChannelX = 0;
    midiChannelY = 0;
    midiChannelZ = 0;

    minGyroX = -220;
    maxGyroX = 220;

    minGyroY = -220;
    maxGyroY = 220;

    minGyroZ = -220;
    maxGyroZ = 220;
  }

  void setDeltaThreshold(int deltaX, int deltaY, int deltaZ) {
    this.deltaX = deltaX;
    this.deltaY = deltaY;
    this.deltaZ = deltaZ;
  }

  void setChannel(int midiChannelX, int midiChannelY, int midiChannelZ) {
    this.midiChannelX = midiChannelX;
    this.midiChannelY = midiChannelY;
    this.midiChannelZ = midiChannelZ;
  }

  void setRangeGyroX(int minGyroX, int maxGyroX) {
    this.minGyroX = minGyroX;
    this.maxGyroX = maxGyroX;
  }

  void setRangeGyroY(int minGyroY, int maxGyroY) {
    this.minGyroY = minGyroY;
    this.maxGyroY = maxGyroY;
  }

  void setRangeGyroZ(int minGyroZ, int maxGyroZ) {
    this.minGyroZ = minGyroZ;
    this.maxGyroZ = maxGyroZ;
  }

  void getContent() {
    GetRequest get = new GetRequest(IP);
    get.send();
    println("Reponse Content: " + get.getContent());
  }

  void processGyroMidi() {
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

    println(IP+" X: "+gyroX+" Y: "+gyroY+" Z: "+gyroZ);

    //x
    if (abs( gyroX - gyroXDelta) > deltaX) {
      mapGyroX = int(map(gyroX, minGyroX, maxGyroX, 0, 127));
      // - num min gyro (-127), num max gyro (127) cambiar con infor gyro
      myBus.sendNoteOn(midiChannelX, mapGyroX, 127);
    }

    //y
    if (abs( gyroY - gyroYDelta) > deltaY) {
      mapGyroY = int(map(gyroY, minGyroY, maxGyroY, 0, 127));

      // - num min gyro (-127), num max gyro (127) cambiar con infor gyro
      myBus.sendNoteOn(midiChannelY, mapGyroY, 127);
    }

    //z
    if (abs( gyroZ - gyroZDelta) > deltaZ) {
      mapGyroZ = int(map(gyroZ, minGyroY, maxGyroY, 0, 127));

      // - num min gyro (-127), num max gyro (127) cambiar con infor gyro
      myBus.sendNoteOn(midiChannelZ, mapGyroZ, 127);
    }
  }
}