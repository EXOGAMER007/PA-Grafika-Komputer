class SceneKota {

  SoundFile audioStreet;
  Langit langit;
  Jalan jalan;
  Gedung gedung1, gedung2, gedung3, gedung4;
  Kursi kursi1, kursi2;
  Pohon pohon1, pohon2;
  mobil mobil;

  SceneKota(PApplet app) {
    audioStreet = new SoundFile(app, "data/street.mp3"); 
    
    langit = new Langit();
    jalan = new Jalan();
    gedung1 = new Gedung(100, 500, 190, 400, color(60, 50, 70));
    gedung2 = new Gedung(250, 500, 100, 300, color(45, 40, 60)); 
    gedung3 = new Gedung(400, 500, 100, 350, color(70, 60, 80));
    gedung4 = new Gedung(550, 500, 190, 450, color(55, 45, 65)); 
    
    kursi1 = new Kursi(340, 520, color(70, 50, 40));
    kursi2 = new Kursi(480, 520, color(70, 50, 40)); 
    
    pohon1 = new Pohon(690, 500);
    pohon2 = new Pohon(250, 500);
    mobil = new mobil();
  }

  void tampilkan() {
    
    pushMatrix();
    translate(0, 10, 0);
    langit.tampilkan();
    popMatrix();
    
    pushMatrix();
    translate(0, 0, 20);
    jalan.tampilkan();
    gedung1.tampilkan();
    gedung2.tampilkan();
    gedung3.tampilkan();
    gedung4.tampilkan();
    kursi1.tampilkan();
    kursi2.tampilkan();
    pohon1.tampilkan();
    pohon2.tampilkan();
    
    popMatrix();
    
    
    pushMatrix();
    translate(100, 420, 100);
    scale(0.2); 
    
    stroke(1);
    strokeWeight(2);
    
    mobil.gambarMobil(100, 400);
    
    popMatrix();
    
    
    pushMatrix();
    translate(0, 0, 40);
    displayHint();
    popMatrix();
  }

  void playMusic() {
    audioStreet.loop();
  }

  void stopMusic() {
    audioStreet.stop();
  }
  
  void displayHint() {
    noStroke();
    fill(255, 255, 255, 180);
    rect(40, 25, 200, 30, 5);
    fill(0);
    textAlign(LEFT, CENTER);
    textSize(14);
    text("Tekan M untuk ke Menu", 50, 40);
  }

  class Langit { 
    Langit() {}
    void tampilkan() {  
      for (int i = 0; i < 300; i++) {
        float inter = map(i, 0, 300, 0, 1);
        int c = lerpColor(color(25, 25, 70), color(255, 140, 80), inter);
        stroke(c);
        line(0, i, width, i);
      } 
      for (int i = 300; i < 500; i++) {
        float inter = map(i, 300, 500, 0, 1);
        int c = lerpColor(color(255, 140, 80), color(255, 100, 130), inter);
        stroke(c);
        line(0, i, width, i);
      }
      noStroke();
      
      pushMatrix();
      translate(0, 0, 10);
      fill(255, 120, 80, 200);
      ellipse(100, 100, 180, 180);
      fill(255, 140, 100, 100);
      ellipse(100, 100, 240, 240); 
      popMatrix();
    }
  }

  class Jalan { 
    float offset = 0;
    Jalan() {}
    void tampilkan() {
      fill(80, 75, 70);
      rect(0, 500, width, 100); 
      fill(40, 38, 35);
      rect(0, 550, width, 50);
      stroke(200, 180, 120);
      strokeWeight(3); 
      for (int i = 0; i < width; i += 40) {
        line(i + offset, 575, i + 20 + offset, 575);
      }
      noStroke();
      
      offset += 2;
      if (offset >= 40) {
        offset = 0;
      }
    }
  }

  class Gedung { 
    float x, y, w, h;
    color c;
    
    Gedung(float x, float y, float w, float h, color c) { 
      this.x = x;
      this.y = y; this.w = w; this.h = h; this.c = c;
    }
    
    void generateWindow() {
      for (float i = x + 10; i < x + w - 10; i += 30) {
        for (float j = y - h + 10; j < y - 10; j += 30) {
          fill(255, 200, 150);
          rect(i, j, 20, 20);
        }
      }
    }
    
    void tampilkan() {
      fill(c);
      rect(x, y - h, w, h);
      generateWindow();
    }
  }
  
  class Kursi { 
    float x, y;
    color c;
    
    Kursi(float x, float y, color c) {
      this.x = x;
      this.y = y; this.c = c; 
    }
    
    void tampilkan() {
      fill(c);
      rect(x, y, 50, 8);
      rect(x, y + 8, 50, 15);
      rect(x, y + 8, 5, 22);
      rect(x + 45, y + 8, 5, 22);
    }
  }
  
  class Pohon { 
    float x, y;
    Pohon(float x, float y) {
      this.x = x;
      this.y = y; 
    }
    
    void tampilkan() {
      fill(80, 50, 30);
      rect(x, y, 20, 50);
      fill(50, 80, 45);
      ellipse(x + 10, y - 35, 80, 80); 
    }
  }
}
