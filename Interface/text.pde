String [] textVal = {"", "", "6x10" };
PVector tpos0= new PVector(30, 30*17);
PVector tpos1= new PVector(30, 30*18+5);
PVector tpos2= new PVector(30, 30*19+10);
PVector insize = new PVector(200, 15);
ArrayList <Textedit> te = new ArrayList <Textedit>();


void setuptx() {
  te.add(new Textedit(tpos0, insize, textVal[0], "Input Rooms No Structure", 13));
  te.add(new Textedit(tpos1, insize, textVal[1], "Input Rooms As Tree Structure", 13));
  te.add(new Textedit(tpos2, insize, textVal[2], "Terrain Dimensions", 13));
}
void drawtx() {
  for (Textedit t : te) t.display();
}
void presstx() {
  for (Textedit t : te) t.select();
  for (int i=0; i<textVal.length; i++) textVal[i] = te.get(i).text;
  if (te.get(0).isover()) if (!te.get(0).select) {
    String [] tsplit = split(te.get(0).text, ",");
    ButtonSl[1]=ButtonSl[2] = 0;
    leafcodes = tsplit;
    setupbt(); 
    setupno();
    setupga();
  }
  if (te.get(1).isover()) if (!te.get(1).select) {
    ButtonSl[1]=ButtonSl[2] = 0;
    setupbt(); 
    setupno2(te.get(1).text);
    
    setupga();
  }
  if (te.get(2).isover()) if (!te.get(2).select) {
    housesize = new PVector (float(split(textVal[2], 'x')[0]), float(split(textVal[2], 'x')[1]));
    setupno();
  }
}
void typetx() {
  for (Textedit t : te) t.type();
}
class Textedit {
  PVector pos, size, halfsize, poscenter, dim;
  String text, tittle;
  String dash = "|";
  boolean select;
  int textsize;
  Textedit(PVector _pos, PVector _size, String _intext, String _tittle, int _textsize) {
    pos=_pos;
    size=_size;
    text=_intext;
    tittle = _tittle;
    halfsize = PVector.mult(size, .5);
    poscenter = PVector.add(pos, halfsize);
    textsize = _textsize;
  }
  void display() {
    rectMode(CORNER);
    if (select) fill(230);
    else fill(255);
    stroke(200);
    rect(pos.x, pos.y, size.x, size.y);
    fill(100);
    textAlign(CORNER, CENTER);
    textSize(12);
    text(tittle, pos.x, pos.y-10);
    if (text.length()<50) {
      if (select) text(text+dash, pos.x+5, poscenter.y);
      else text(text, pos.x+5, poscenter.y);
    }
  }
  boolean isover() {
    if (mouseX>poscenter.x-halfsize.x&&mouseX<poscenter.x+halfsize.x&&mouseY>poscenter.y-halfsize.y&&mouseY<poscenter.y+halfsize.y) return true;
    else return false;
  }
  void select() {
    if (isover()) select = !select;
  }
  String gettext() {
    return text;
  }
  void type() {
    if (select) {
      if ((key >= 'A' && key <= 'z') ||(key >= '0' && key <= '9') || key == ' '|| key=='('|| key==')'|| key==','|| key=='.'|| key=='|')  text = text + key;
      if (key==BACKSPACE ) if (text.length()>0) text = text.substring(0, text.length()-1);
    }
  }
}
class textrect {
  PVector pos, size;
  String text;
  int i;
  textrect(PVector _pos, PVector _size, String _text, int _i) {
    pos=_pos;
    size=_size;
    text=_text;
    i=_i;
  }
  void display() {
    fill(255);
    textAlign(CENTER, CENTER);
    rect(pos.x, pos.y, size.x, size.y);
    fill(100);
    if (text!=null) text(text, pos.x + size.x*.5, pos.y + size.y*.5);
  }
}