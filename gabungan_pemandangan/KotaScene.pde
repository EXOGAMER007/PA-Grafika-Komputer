class KotaScene {
  SoundFile audioStreet;
  PApplet parent;
  
  Langit langit;
  Jalan jalan;
  
  Gedung gedung1, gedung2, gedung3, gedung4;
  Kursi kursi1, kursi2;
  Pohon pohon1, pohon2;
  
  MobilKota mobil;
  
  // Animasi mobil (sama seperti pegunungan)
  boolean animasiMobil = false; // animasi mobil terbang
  float KecepatanTerbang = 5;
  float kecepatanPutar = 5;
  boolean terbang = true;
  boolean putar = true;
  float perputaran = 0;
  int terbangTiap = 0;
  float tinggiTerbang = 0;
  
  boolean audioLoaded = false;
  
  KotaScene(PApplet p) {
    parent = p;
    
    langit = new Langit();
    jalan = new Jalan();
    mobil = new MobilKota();
    
    gedung1 = new Gedung(100, 500, 190, 400, color(60, 50, 70));
    gedung2 = new Gedung(250, 500, 100, 300, color(45, 40, 60));
    gedung3 = new Gedung(400, 500, 100, 350, color(70, 60, 80));
    gedung4 = new Gedung(550, 500, 190, 450, color(55, 45, 65));
    
    kursi1 = new Kursi(340, 520, color(70, 50, 40));
    kursi2 = new Kursi(480, 520, color(70, 50, 40));
    
    pohon1 = new Pohon(690, 500);
    pohon2 = new Pohon(250, 500);
    
    try {
      audioStreet = new SoundFile(parent, "data/street.mp3");
      audioLoaded = true;
    } catch (Exception e) {
      println("Audio file not found: data/street.mp3");
      audioLoaded = false;
    }
  }
  
  void display() {
    langit.tampilkan();
    jalan.tampilkan();
    
    gedung1.tampilkan();
    gedung2.tampilkan();
    gedung3.tampilkan();
    gedung4.tampilkan();
    
    kursi1.tampilkan();
    kursi2.tampilkan();
    
    pohon1.tampilkan();
    pohon2.tampilkan();
    
    // Animasi mobil (sama seperti pegunungan)
    animasiMobil(10, 430, animasiMobil);
    
    // Display back to menu hint
    displayHint();
  }
  
  void startAudio() {
    if (audioLoaded && audioStreet != null) {
      audioStreet.loop();
    }
  }
  
  void stopAudio() {
    if (audioLoaded && audioStreet != null && audioStreet.isPlaying()) {
      audioStreet.stop();
    }
  }
  
  void animasiMobil(float x, float y, Boolean animation) {
    pushMatrix();
    translate(x, y);
    if (animation) {
      pushMatrix();
      translate(0, tinggiTerbang);
      if (tinggiTerbang <= -200 && putar && perputaran < 359) {
        translate(145, 66.275);
        rotate(radians(perputaran));
        translate(-145, -66.275);
        perputaran += kecepatanPutar;
      } else if (perputaran >= 359) {
        terbang = false;
        putar = false;
        perputaran = 0;
      }
      if (terbang && tinggiTerbang > -200) {
        tinggiTerbang -= KecepatanTerbang;
      } else if (!putar) {
        if (!terbang && tinggiTerbang < 0) {
          tinggiTerbang += KecepatanTerbang;
        } else if (!terbang && tinggiTerbang >= 0) {
          tinggiTerbang = 0;
          putar = true;
          perputaran = 0;
        }
      }
      if (putar && !terbang) {
        terbangTiap += 50;
      }
      if (terbangTiap >= 800 && putar == true) {
        terbang = true;
        terbangTiap = 0;
      }
      mobil.gambarMobil(0, 0);
      popMatrix();
    } else {
      pushMatrix();
      mobil.gambarMobil(0, 0);
      popMatrix();
    }
    popMatrix();
  }
  
  void displayHint() {
    fill(255, 255, 255, 180);
    rect(10, 10, 200, 30, 5);
    fill(0);
    textAlign(LEFT, CENTER);
    textSize(14);
    text("Tekan M untuk ke Menu", 20, 25);
  }
}

class Langit {
  void tampilkan() {
    // Background
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
    
    // Matahari
    fill(255, 120, 80, 200);
    ellipse(100, 100, 180, 180);
    fill(255, 140, 100, 100);
    ellipse(100, 100, 240, 240); 
  }
}

class Jalan {
  float offset = 0;
  float offset2 = 800;
  boolean ulang = false;
  float kecepatan = 5;
  
  void tampilkan() {
    // Gambar Trotoar
    fill(80, 75, 70);
    rect(0, 500, width, 100);
    
    // Gambar jalan
    fill(40, 38, 35);
    rect(0, 550, width, 50);
    
    // Gambar garis jalan bergerak dari kanan ke kiri (2 layer untuk kontinyu)
    stroke(200, 180, 120);
    strokeWeight(3);
    
    // Layer pertama
    pushMatrix();
    translate(offset, 0);
    for (int i = 0; i < width; i += 80) {
      line(i, 575, i + 40, 575);
    }
    popMatrix();
    
    // Layer kedua (untuk kontinuitas)
    if (ulang) {
      pushMatrix();
      translate(offset2, 0);
      for (int i = 0; i < width; i += 80) {
        line(i, 575, i + 40, 575);
      }
      popMatrix();
      offset2 -= kecepatan;
    }
    
    noStroke();
    
    // Update offset untuk animasi (kanan ke kiri)
    if (offset == 0) {
      ulang = true;
    }
    if (offset2 <= -800) {
      offset2 = 800;
    }
    if (offset <= -800) {
      offset = 800;
    }
    offset -= kecepatan;
  }
}

class Gedung {
  float x, y, w, h;
  color c;
  
  Gedung(float x, float y, float w, float h, color c) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.c = c;
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
    this.y = y;
    this.c = c;
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
    // Batang
    fill(80, 50, 30);
    rect(x, y, 20, 50);
    
    // Daun
    fill(50, 80, 45);
    ellipse(x + 10, y - 35, 80, 80);
  }
}

class MobilKota {
  void gambarMobil(float x, float y) {
    pushMatrix();
    y += 50;
    translate(x, y);
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
    rect(0, 10, 20, 10);
    fill(#0000FF);
    rect(270, 10, 20, 10);
    popMatrix();
  }
  
  void banMobil() {
    pushMatrix();
    translate(0, 0);
    fill(#4D4D4D);
    circle(53, 60, 40);
    circle(240, 62.04, 40);
    fill(0);
    circle(53, 60, 5);
    circle(240, 62.04, 5);
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
    line(45, -50, 45, 0);
    line(100, -50, 100, 60);
    line(150, -50, 150, 60);
    line(245, 0, 245, 42);
    popMatrix();
  }
  
  void peganganPintuMobil() {
    pushMatrix();
    translate(0, 0);
    fill(255);
    rect(110, 10, 8, 3);
    rect(160, 10, 8, 3);
    popMatrix();
  }
}
