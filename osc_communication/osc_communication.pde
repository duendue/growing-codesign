import oscP5.*;
import netP5.*;

NetAddress remote;
OscP5 oscP5;

void setup(){
  oscP5 = new OscP5(this,12000);
  
  //Addressen som der sendes til. Jeg går ud fra at denne skal bruges i PureData
  remote = new NetAddress("127.0.0.1",1234);
}

void draw(){
  //Navnet på OSC beskeden
  OscMessage msg = new OscMessage("/sensor-data");
  
  //Til denne sketch sender jeg et tilfældigt tal mellem 300 og 500 for at imitere plantesensoren.
  msg.add(floor(random(300, 500)));
  
  oscP5.send(msg,remote);
}
