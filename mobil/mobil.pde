//pushMatrix();
//translate(0,0);
//popMatrix();

void setup() {
  size(800, 600);
}

void draw() {
  background(255);
  gambarMobil(0,0);
}

void gambarMobil(float x, float y) {
  pushMatrix();
  y+=50;
  translate(x, y);//penentuan lokasi mobil
  badanMobil();
  jendelaMobil();
  peganganPintuMobil();
  popMatrix();
}

void badanMobil() {
  pushMatrix();
  translate(0, 0);
  fill(#999900);
  rect(0, 0, 290, 60);
  lampuMobil();
  banMobil();
  popMatrix();
}

void lampuMobil() {
  pushMatrix();
  translate(0, 0);
  fill(#FF3333);
  rect(0, 10, 20, 10);//kiri
  fill(#0000FF);
  rect(270, 10, 20, 10);//kanan
  popMatrix();
}

void banMobil() {
  pushMatrix();
  translate(0, 0);
  fill(#4D4D4D);
  circle(53, 60, 40);//ban kiri
  circle(240, 62.04, 40);//ban kanan

  fill(0);
  circle(53, 60, 5);//ban kecil kiri
  circle(240, 62.04, 5);//ban kecil kanan
  fill(255);
  popMatrix();
}

void jendelaMobil() {
  pushMatrix();
  translate(0, 0);
  fill(#666666);
  beginShape();
  vertex(0, 0);
  vertex(45, -50);
  vertex(196, -50);
  vertex(245, 0);
  endShape();
  
  //pintu dan kaca dari kiri
  line(45, -50, 45, 0);
  line(100, -50, 100, 60);
  line(150, -50, 150, 60);
  line(245, 0, 245, 42);
  
  popMatrix();
}

void peganganPintuMobil() {
  pushMatrix();
  translate(0,0);
  fill(255);
  rect(110, 10, 8, 3);
  
  rect(160, 10, 8, 3);
  popMatrix();
}
