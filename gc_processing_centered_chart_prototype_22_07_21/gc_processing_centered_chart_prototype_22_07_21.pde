import processing.serial.*;

Serial myPort;        // The serial port
float inByte;         // Incoming serial data
boolean newData = false;
int xPos;         // horizontal position of the graph 

//Variables to draw a continuous line.
int lastxPos;
int lastheight;

void setup () {
  // set the window size:
  fullScreen();
  //size(500, 500);
  noCursor();

  myPort = new Serial(this, Serial.list()[2], 9600);  

  // A serialEvent() is generated when a newline character is received :
  myPort.bufferUntil('\n');
  xPos = width/2; 
  lastxPos = width/2;
  lastheight = floor(random(0, height));
  
  background(0);  // set inital background:
  
  /*
  text("0", 10, height/2);
  text("300", 10, (height/2));
  text("400", 10, (height/3));
  */
}
void draw () {
  if (newData) {
    //Drawing a line from Last inByte to the new one.
    stroke(127,34,255);     //stroke color
    strokeWeight(4);        //stroke wider
    line(lastxPos, lastheight, xPos, height - inByte + (height/5));
    
    lastxPos = xPos;
    lastheight = int(height-inByte + (height/5));
    
    loadPixels();
    for(int i = 0; i < pixels.length; i++){
      if(i % width != 0 && i < pixels.length - 1) pixels[i]=pixels[i+1];
      else pixels[i] = pixels[i]; //pixels[i] = color(0);
    }
    updatePixels();
      

    /*
    // at the edge of the window, go back to the beginning:
    if (xPos >= width) {
      xPos = 0;
      lastxPos= 0;
      background(0);  //Clear the screen.
    } 
    else {
      // increment the horizontal position:
      xPos++;
    }
    */
   newData =false;
 }
}

void serialEvent (Serial myPort) {
  // get the ASCII string:
  String inString = myPort.readStringUntil('\n');
  if (inString != null) {
    inString = trim(inString);                // trim off whitespaces.
    inByte = float(inString);           // convert to a number.
    inByte = map(inByte, 0, 1023, 0, height); //map to the screen height.
    newData = true; 
  }
}
