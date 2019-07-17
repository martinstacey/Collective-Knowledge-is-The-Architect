class Gene {
  float value, step, min, max;
  PVector  pos;
  boolean select=false;
  PVector size=new PVector (15, 15);
  Gene(float _value, float _min, float _step, float _max, PVector _pos) {
    value=_value;
    step=_step;
    min=_min;
    max=_max;
    pos=_pos;
  }
  void display() {
    if (select) fill(200);
    else fill(255);
    rectMode(CENTER);
    rect(pos.x, pos.y, size.x, size.y, size.y*.25);
    fill(100);
    text(nf(value, 0, 0), pos.x, pos.y);
  }
  boolean selected() {
    if (mouseX>pos.x-(size.x/2.0)&&mouseX<pos.x+(size.x/2.0)&&mouseY>pos.y-(size.y/2.0)&&mouseY<pos.y+(size.y/2.0)) return true;
    else return false;
  }
  void press() {
    if (selected()) select =!select;
  }
  void scroll(boolean updown) {
    if (select&&!updown&&value<max) value = value + step;
    if (select&&updown&&value>min) value = value - step;
    if (value<min) value=min;
    if (value>max) value=max;
  }
}