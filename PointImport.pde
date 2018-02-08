byte[] readBytes;
String[] readLines;

void readVelodyneBinary() {
  readBytes = loadBytes(fileName);
   for (int i = 0; i < readBytes.length; i+=16) { 
     byte[] bytesX = { readBytes[i], readBytes[i+1], readBytes[i+2], readBytes[i+3] };
     byte[] bytesY = { readBytes[i+4], readBytes[i+5], readBytes[i+6], readBytes[i+7] };
     byte[] bytesZ = { readBytes[i+8], readBytes[i+9], readBytes[i+10], readBytes[i+11] };
     byte[] bytesW = { readBytes[i+12], readBytes[i+13], readBytes[i+14], readBytes[i+15] };

    float x = asFloat(bytesX);
    float y = asFloat(bytesY);
    float z = asFloat(bytesZ);
    float w = asFloat(bytesW);
    if (!Float.isNaN(x) && !Float.isNaN(y) && !Float.isNaN(z)) {
      points.add(new PVector(x, y, z));
      displayPoints.add(new PVector(x, -z, y).mult(globalScale));
    }
  }
  println("Read " + fileName + ".");
}

void readVelodyneText() {
  readLines = loadStrings(fileName);
   for (int i = 0; i < readBytes.length; i+=16) { 
     byte[] bytesX = { readBytes[i], readBytes[i+1], readBytes[i+2], readBytes[i+3] };
     byte[] bytesY = { readBytes[i+4], readBytes[i+5], readBytes[i+6], readBytes[i+7] };
     byte[] bytesZ = { readBytes[i+8], readBytes[i+9], readBytes[i+10], readBytes[i+11] };
     byte[] bytesW = { readBytes[i+12], readBytes[i+13], readBytes[i+14], readBytes[i+15] };

    float x = asFloat(bytesX);
    float y = asFloat(bytesY);
    float z = asFloat(bytesZ);
    float w = asFloat(bytesW);
    if (!Float.isNaN(x) && !Float.isNaN(y) && !Float.isNaN(z)) {
      points.add(new PVector(x, y, z));
      displayPoints.add(new PVector(x, -z, y).mult(globalScale));
    }
  }
  println("Read " + fileName + ".");
}