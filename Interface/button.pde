boolean [] bState = {false};
boolean [] clState = {false};
int ButtonSl [] = { 2, 0, 0, 0, 0};             
ArrayList <ButtonSlider> m ;
ArrayList<Button> bt;
ArrayList<ClickBut> cl;

void setupbt() {
  m = new ArrayList< ButtonSlider> ();
  bt  = new ArrayList<Button>();
  cl= new ArrayList <ClickBut> ();
  m.add(new ButtonSlider(40, 220, 0, 3, 30*2, 20, "Database:"));
  m.add(new ButtonSlider(40, 220, 0, hloc[leafcodes.length-1].length-1, 30*21, 20, "Tree Number: "));  
  m.add(new ButtonSlider(40, 220, 0, factint(leafcodes.length)-1, 30*23, 20, "Room Configuration"));
  m.add(new ButtonSlider(40, 220, 0, hru.length-1, 30*25, 20, "Premade Tree:1"));  
  m.add(new ButtonSlider(40, 220, 0, factint(leafcodes.length)-1, 30*26, 20, "Premade Tree:2"));
  bt.add(new Button(40, 30*27, 20, "Evolve", bState[0]));
  cl.add(new ClickBut(40, 30*28,20,"Reset",clState[0]));                           //int x, int y, int bSize, String label, boolean state
}
void drawbt() {
  for (int i=0; i<m.size(); i++) m.get(i).display(ButtonSl[i]);    
  for (int i=0; i<m.size(); i++) ButtonSl[i]=m.get(i).value;
  fill(100);
  textAlign(LEFT, CENTER);
  textSize(12);
  text(flname[ButtonSl[0]], 120, 29*2);
  text("Possible Trees: " + catalanint(leafcodes.length-1), 30, 30*22);
  text("Possible Rooms: " + fact(leafcodes.length), 30, 30*24);

  for (Button b : bt)    b.display();
  for (int i=0; i<bt.size(); i++)  bState[i]=bt.get(i).state;
  for (int i=0; i<cl.size(); i++) cl.get(i).display();
  for (int i=0; i<cl.size(); i++) clState[i] = cl.get(i).state;
}
void pressbt() {
  for (int i=0; i<m.size(); i++) m.get(i).press();
  for (int i=0; i<m.size(); i++) ButtonSl[i] = m.get(i).value;  
  if (m.get(0).clickdown()||m.get(0).clickup()) {
    setuphg();
     drawhg();
     rprop = rp [ButtonSl[0]];
     setupga();
     setupno();
  }

  
  if (m.get(1).clickdown()||m.get(1).clickup()) setupno();
  
  
  if (m.get(2).clickdown()||m.get(2).clickup()) if (leafcodes.length>1) setupno();
  if (m.get(3).clickdown()||m.get(3).clickup()) setupno2(hru[ButtonSl[3]]);
  
  for (Button b : bt)   b.press();
  for (ClickBut c:cl)  c.press();
   if (bt.get(0).state) if (bt.get(0).isover()) no=gano;
   if (cl.get(0).isover()) setupga();
}
class ButtonSlider {
  int x, x2, y, bSize;
  String label;
  boolean state1, state2;
  int value;
  float min, max;
  float fc1;
  float fc2;
  ButtonSlider(int _x, int _x2, float _min, float _max, int _y, int _bSize, String _label) {
    x = _x;
    x2=_x2;
    y = _y;
    min=_min;
    max=_max;
    bSize = _bSize;
    label = _label;
  }
  void display(int _value) {
    strokeWeight(1);
    value = _value;
    pushStyle();
    colorMode(RGB, 255);
    textSize(12);
    stroke(200);
    textAlign(CENTER, CENTER);
    stroke(200);
    fill(255);
    if (state1) fill(230);
    else  fill(255);
    line( x+(bSize/4), y-(bSize/4), x-(bSize/4), y);
    line( x+(bSize/4), y+(bSize/4), x-(bSize/4), y);
    ellipse(x, y, bSize, bSize);
    if (state2) fill(230);
    else  fill(255);
    line(x2-(bSize/4), y-(bSize/4), x2+(bSize/4), y);
    line(x2-(bSize/4), y+(bSize/4), x2+(bSize/4), y);
    ellipse(x2, y, bSize, bSize);
    fill(100);
    textAlign(LEFT, CENTER);
    text(label, x+bSize, y-2);
    textAlign(RIGHT, CENTER);
    text(value, x2-bSize, y-2);
    popStyle();
    if (frameCount==fc1+10)state1=false;
    if (frameCount==fc2+10)state2=false;
  }
  boolean clickdown() {
    if (mouseX > (x - bSize/2.0) && mouseX < (x + bSize/2.0)  &&mouseY > (y - bSize/2.0) && mouseY < (y + bSize/2.0))  return true;
    else return false;
  }
  boolean clickup() {
    if (mouseX > (x2 - bSize/2.0) && mouseX < (x2 + bSize/2.0)  &&mouseY > (y - bSize/2.0) && mouseY < (y + bSize/2.0)) return true;
    else return false;
  }
  void press() {
    if (clickdown()) {   
      state1=true;
      fc1 = frameCount;
      if (value>min) value--;
    }
    if (clickup()) {
      state2=true;
      fc2 = frameCount;
      if (value<max)value++;
    }
  }
}

BigInteger fact(int _num) { 
  BigInteger num = new BigInteger(""+_num);
  if (num.compareTo(new BigInteger("1")) < 1) return new BigInteger("1");      
  else return num.multiply(fact(num.add(new BigInteger("-1")).intValue()));
}
BigInteger  catalan(int n) {
  return (fact(2*n)).divide((fact(n+1).multiply(fact(n))));
}
int  catalanint(int n) {
  BigInteger num = (fact(2*n)).divide((fact(n+1).multiply(fact(n))));
  return num.intValue();
}
int factint(int _num) {
  if (_num<=1) return 1;
  else return _num*factint(_num-1);
}



class Button {
  int x, y, bSize;
  String label;
  boolean state;
  Button(int _x, int _y, int _bSize, String _label, boolean _state) {
    x = _x;
    y = _y;
    bSize = _bSize;
    label = _label;
    state = _state;
  }
  void display() {
    pushStyle();
    colorMode(RGB, 255);
    textSize(13);
    stroke(200);
    textAlign(CENTER, CENTER);
    if (state) {
      stroke(200);
      fill(255);
      fill(230);
      ellipse(x, y, bSize, bSize);
    } else {
      fill(255);
      //fill(100);
      ellipse(x, y, bSize, bSize);
    } 
    fill(100);
    textAlign(LEFT, CENTER);
    text(label, x+bSize, y);
    popStyle();
  }
  boolean isover() {
    if (mouseX > (x - bSize/2) && mouseX < (x + bSize/2)  &&mouseY > (y - bSize/2) && mouseY < (y + bSize/2)) return true;
    else return false;
  }
  void press() {
    if (isover()) state = !state;
  }
}
class ClickBut {
  int x, y, bSize;
  String label;
  boolean state;
  ClickBut(int x, int y, int bSize, String label, boolean state) {
    this.x = x;
    this.y = y;
    this.bSize = bSize;
    this.label = label;
    this.state = state;
  }
  void display() {
    if (frameCount%15==0) state = false;
    pushStyle();
    colorMode(RGB, 255);
    textSize(13);
    stroke(200);
    textAlign(CENTER, CENTER);
    if (state) {
      stroke(200);
      fill(255);
      fill(230);
      ellipse(x, y, bSize, bSize);
    } else {
      fill(255);
      //fill(100);
      ellipse(x, y, bSize, bSize);
    } 
    fill(100);
    textAlign(LEFT, CENTER);
    text(label, x+bSize, y);
    popStyle();
  }
  boolean isover(){
    if (mouseX > (x - bSize/2) && mouseX < (x + bSize/2)  &&mouseY > (y - bSize/2) && mouseY < (y + bSize/2)) return  true;
    else return false;
  }
  void press() {
    if (isover()) state = !state;
  }
}