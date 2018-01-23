String fileName = "output1.bin";
String fileNameNoExt = "";
float globalScale = 1;

byte[] readBytes;
String[] readLines;
ArrayList<PVector> points = new ArrayList<PVector>();
ArrayList<PVector> displayPoints = new ArrayList<PVector>();
Cam cam;
int densityHigh = 1;
int densityLow = 20;
int density = densityLow;
int strokeWeightHigh = 2;
int strokeWeightLow = 6;

void setup() {
  size(960, 540, P3D);
  
  String[] splits = split(fileName, ".");
  for (int i=0; i<splits.length-1; i++) {
    fileNameNoExt += splits[i];
  }
  
  readPointCloud();
  writePointCloud();
  
  cam = new Cam();
  cam.displayText = "Press space for detail";
  
  strokeWeight(strokeWeightLow);
  stroke(255, 127);
}

void draw() {
  background(0);
  for (int i=0; i<points.size(); i+=density) {
    PVector p = displayPoints.get(i);
    point(p.x, p.y, p.z);
  }
  
  cam.run();

  surface.setTitle(""+frameRate);
}

void readPointCloud() {
  readBytes = loadBytes(fileName);
  //readLines = decodeNBits(readBytes, 12);
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

void writePointCloud() {
  String[] writeLines = new String[points.size()];
  for (int i=0; i<points.size(); i++) {
    writeLines[i] = formatPointCloudLine(points.get(i));
  }
  String url = fileNameNoExt + ".asc";
  saveStrings("data/" + url, writeLines);
  println("Wrote " + url + ".");
}

String formatPointCloudLine(PVector p) {
  String returns = p.x + " " + p.y + " " + p.z;
  return returns;
}