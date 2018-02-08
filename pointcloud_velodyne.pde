String fileName = "example001.bin";
String fileNameNoExt = "";
float globalScale = 1;

ReadMode readMode = ReadMode.BIN;

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
  String ext = splits[splits.length-1].toLowerCase();
  if (ext.equals("bin")) {
    readMode = ReadMode.BIN;
    readVelodyneBinary();
  } else {
    readMode = ReadMode.TXT;
    readVelodyneText();
  }

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

// TODO replace with PointExport methods
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