import java.math.BigInteger;
import java.util.*;

void setup() {
  size(2000, 1200);
  colorMode(RGB, 255, 255, 255, 100.0);
  background (255);
  smooth(5);
  setuptt();
  setupbt();
  setuptx();
  setupta();
  setuphg();
  setupno();
  setupga();
  drawhg();
  println(rprop.length);
  println(rprop.length);
}
void draw() {
  drawback();
  drawbt();
  drawtx();
  drawte();
  drawno();
  
  //draw1ga(p.pop.length-1);
  draw1ss(p.pop.length-1);
  //draw1ga(p.pop.length/2);
  drawbestsga(100);
  //drawpop();
  if (bState[0]) for (int i=0; i<5000; i++) evolvega();
  //if (bState[0]) for (int i=0; i<100; i++) evolvega();
  //ellipse(mouseX,mouseY,5,5);
}

void mousePressed() {
  pressbt();
  presstx();
    pressno();
    if (key=='s') {
      saveFrame("abc.tiff");
      print("save");
    }
}
void keyPressed() {
  typetx(); 
}
void mouseWheel(MouseEvent event) {
  if (event.getCount()==+1) scrollno(true);
  if (event.getCount()==-1) scrollno(false);
}