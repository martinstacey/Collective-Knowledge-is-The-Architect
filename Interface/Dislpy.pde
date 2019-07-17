void drawte() {
  textAlign(CORNER);
  textSize(18);
  fill(100);
  text("Collective Knowledge is the Architect", 30, 30);
}
void drawbackgrid() {
  fill(255);
  rectMode(CORNER);
  noStroke();
  rect(0, 80, width, 380);
  rect(0, 460, width, height-460);
}

void drawback() {
  fill(255);
  rectMode(CORNER);
  noStroke();
  rect(0, 0, width, 80);
  rect(0, 460, width, height-460);
}