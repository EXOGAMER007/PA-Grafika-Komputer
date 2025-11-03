class ScenePantai {

  SoundFile musik;
  float waveOffset = 0.0;
  float offsetX = 0;
  float speed = 3;
  mobil mobil;

  ScenePantai(PApplet app) {
    musik = new SoundFile(app, "./data/pantai.mp3"); 
    mobil = new mobil();
  }

  void tampilkan() {
    
    background(135, 206, 235);
    
    noStroke();
    fill(255, 255, 0);
    ellipse(700, 100, 80, 80);

    fill(0, 119, 190);
    noStroke();
    
    beginShape();
    float xoff = waveOffset;
    
    for (float x = 0; x <= width; x += 10) {
      float y = map(noise(xoff), 0, 1, 280, 300);
      vertex(x, y);
      xoff += 0.05;
    }
    vertex(width, 500);
    vertex(0, 500);    
    endShape(CLOSE);
    
    waveOffset += 0.01;
    fill(245, 222, 179);
    noStroke();
    beginShape();
    vertex(0, 350);
    curveVertex(0, 350);
    curveVertex(250, 420);
    curveVertex(500, 390);
    curveVertex(800, 450);
    vertex(800, 450);
    vertex(800, 500);
    vertex(0, 500);
    endShape(CLOSE);

    fill(139, 69, 19);
    noStroke();
    quad(280, 415, 270, 390, 400, 390, 390, 415);
    stroke(139, 69, 19);
    strokeWeight(4);
    line(350, 400, 350, 330);
    noStroke();
    fill(#FF0000);
    rect(349, 320, 50, 20);
    fill(#FFFAFA);
    rect(349, 340, 50, 20);
    
    
    fill(255, 0, 0);
    noStroke();
    quad(540, 450, 620, 450, 600, 410, 560, 410);
    stroke(100);
    strokeWeight(4);
    line(540, 440, 540, 380);
    
    fill(#CCFA03);
    noStroke();
    arc(540, 380, 100, 100, PI, TWO_PI);
    fill(139, 69, 19);
    noStroke();
    rect(100, 280, 20, 220);
    rect(180, 300, 20, 200);
    
    stroke(34, 139, 34);
    strokeWeight(7);
    noFill();
    
    bezier(110, 280, 90, 260, 70, 250, 50, 260);
    bezier(110, 280, 130, 260, 150, 250, 170, 260); 
    bezier(110, 280, 70, 280, 40, 290, 20, 310);
    bezier(110, 280, 150, 280, 180, 290, 200, 310); 
    bezier(110, 280, 90, 300, 80, 320, 70, 340);
    bezier(110, 280, 130, 300, 140, 320, 150, 340); 
    
    bezier(190, 300, 170, 280, 150, 270, 130, 280);
    bezier(190, 300, 210, 280, 230, 270, 250, 280); 
    bezier(190, 300, 150, 300, 120, 310, 100, 330);
    bezier(190, 300, 230, 300, 260, 310, 280, 330); 
    bezier(190, 300, 170, 320, 160, 340, 150, 360);
    bezier(190, 300, 210, 320, 220, 340, 230, 360); 
    bezier(190, 300, 230, 320, 250, 340, 260, 360);
    noStroke();
    fill(101, 67, 33);
    ellipse(105, 295, 20, 20); 
    ellipse(120, 295, 20, 20);
    ellipse(185, 315, 20, 20);
    ellipse(200, 315, 20, 20); 

    fill(#2E2E2E);
    rect(0, 500, 800, 100);
    fill(#ABADAB);
    rect(0, 450, 800, 10);

    fill(#CBBB23);
    float offsetGaris = offsetX % 60;
    for (int x = -60; x < 800; x += 60) {
      rect(x + offsetGaris, 545, 30, 10);
    }
    
    fill(#ABADAB);
    float offsetTiang = offsetX % 40;
    for (int x = -40; x < 800; x += 40) {
      rect(x + offsetTiang, 450, 10, 50);
    }

    offsetX -= speed;
    stroke(1);
    strokeWeight(2);
    mobil.gambarMobil(20, 450);
    noStroke();
    
    displayHint();
  }

  void playMusic() {
    musik.loop();
  }

  void stopMusic() {
    musik.stop();
  }
  
  void displayHint() {
    noStroke();
    fill(255, 255, 255, 180);
    rect(20, 20, 200, 30, 5);
    fill(0);
    textAlign(LEFT, CENTER);
    textSize(14);
    text("Tekan M untuk ke Menu", 35, 35);
  }
}
