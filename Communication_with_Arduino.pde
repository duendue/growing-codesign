import processing.serial.*;

Serial myPort;  // Create object from Serial class
String portName;
String val;     // Data received from the serial port
float fVal;
float step;

void setup()
{
  // I know that the first port in the serial list on my mac
  // is Serial.list()[0].
  // On Windows machines, this generally opens COM1.
  // Open whatever port is the one you're using.
  portName = Serial.list()[0]; //change the 0 to a 1 or 2 etc. to match your port
  myPort = new Serial(this, portName, 9600);
  
  step = 1;         //the x value of the graph
  
  size(640, 360);
  background(102);
  
}

void draw()
{

  val = myPort.readStringUntil('\n');         // read it and store it in val
  fVal = float(val);                          //converting String to float 
  
  println(val); //print it out in the console
  println(portName);
  
  stroke(255);
    line(step, fVal, step++, fVal);
  
  
}
