class PantaiScene {
  SoundFile musik;
  PApplet parent;
  float waveOffset = 0.0;
  
  MobilPantai mobil;
  
  // Animasi mobil (sama seperti pegunungan)
  boolean animasiMobil = false; // animasi mobil terbang
  float KecepatanTerbang = 5;
  float kecepatanPutar = 5;
  boolean terbang = true;
  boolean putar = true;
  float perputaran = 0;
  int terbangTiap = 0;
  float tinggiTerbang = 0;
  
  // Animasi jalanan (dari kanan ke kiri)
  float jalanOffset = 0;
  float jalanOffset2 = 800;
  boolean jalanUlang = false;
  float jalanKecepatan = 5;
  
  float pagarOffset = 0;
  float pagarOffset2 = 800;
  boolean pagarUlang = false;
  float pagarKecepatan = 5;
  
  boolean audioLoaded = false;
  
  PantaiScene(PApplet p) {
    parent = p;
    mobil = new MobilPantai();
    
    try {
      musik = new SoundFile(parent, "data/pantai.mp3");
      audioLoaded = true;
    } catch (Exception e) {
      println("Audio file not found: data/pantai.mp3");
      audioLoaded = false;
    }
  }
  
  void display() {
    // Latar Belakang
    background(135, 206, 235);
    
    // Matahari
    noStroke();
    fill(255, 255, 0);
    ellipse(700, 100, 80, 80);
    
    // Laut dengan ombak
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
    
    // Pasir
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
    
    // Perahu
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
    
    // Tikar Pantai
    fill(255, 0, 0);
    noStroke();
    quad(540, 450, 620, 450, 600, 410, 560, 410);
    
    // Payung Pantai
    stroke(100);
    strokeWeight(4);
    line(540, 440, 540, 380);
    fill(#CCFA03);
    noStroke();
    arc(540, 380, 100, 100, PI, TWO_PI);
    
    // Pohon Kelapa
    drawPohonKelapa();
    
    // Jalanan dengan animasi
    fill(#2E2E2E); 
    noStroke();
    rect(0, 500, 800, 100);
    
    // Garis kuning jalan bergerak dari kanan ke kiri
    fill(#CBBB23);
    pushMatrix();
    translate(jalanOffset, 0);
    for (int x = 0; x < 800; x += 60) {
      rect(0 + x, 545, 30, 10);
    }
    popMatrix();
    
    if (jalanUlang) {
      pushMatrix();
      translate(jalanOffset2, 0);
      for (int x = 0; x < 800; x += 60) {
        rect(0 + x, 545, 30, 10);
      }
      popMatrix();
      jalanOffset2 -= jalanKecepatan;
    }
    
    // Update animasi jalan
    if (jalanOffset == 0) {
      jalanUlang = true;
    }
    if (jalanOffset2 <= -800) {
      jalanOffset2 = 800;
    }
    if (jalanOffset <= -800) {
      jalanOffset = 800;
    }
    jalanOffset -= jalanKecepatan;
    
    // Pagar bergerak dari kanan ke kiri
    fill(#ABADAB);
    rect(0, 450, 800, 10);
    
    pushMatrix();
    translate(pagarOffset, 0);
    for (int x = 0; x < 800; x += 40) {
      rect(0 + x, 450, 10, 50);
    }
    popMatrix();
    
    if (pagarUlang) {
      pushMatrix();
      translate(pagarOffset2, 0);
      for (int x = 0; x < 800; x += 40) {
        rect(0 + x, 450, 10, 50);
      }
      popMatrix();
      pagarOffset2 -= pagarKecepatan;
    }
    
    // Update animasi pagar
    if (pagarOffset == 0) {
      pagarUlang = true;
    }
    if (pagarOffset2 <= -800) {
      pagarOffset2 = 800;
    }
    if (pagarOffset <= -800) {
      pagarOffset = 800;
    }
    pagarOffset -= pagarKecepatan;
    
    // Mobil dengan animasi (sama seperti pegunungan)
    animasiMobil(40, 420, animasiMobil);
    
    // Display hint
    displayHint();
  }
  
  void drawPohonKelapa() {
    // Batang Pohon
    fill(139, 69, 19);
    noStroke();
    rect(100, 280, 20, 220);
    rect(180, 300, 20, 200);
    
    stroke(34, 139, 34);
    strokeWeight(7);
    noFill();
    
    // Daun Pohon 1
    bezier(110, 280, 90, 260, 70, 250, 50, 260);
    bezier(110, 280, 130, 260, 150, 250, 170, 260);
    bezier(110, 280, 70, 280, 40, 290, 20, 310);
    bezier(110, 280, 150, 280, 180, 290, 200, 310);
    bezier(110, 280, 90, 300, 80, 320, 70, 340);
    bezier(110, 280, 130, 300, 140, 320, 150, 340);
    
    // Daun Pohon 2
    bezier(190, 300, 170, 280, 150, 270, 130, 280);
    bezier(190, 300, 210, 280, 230, 270, 250, 280);
    bezier(190, 300, 150, 300, 120, 310, 100, 330);
    bezier(190, 300, 230, 300, 260, 310, 280, 330);
    bezier(190, 300, 170, 320, 160, 340, 150, 360);
    bezier(190, 300, 210, 320, 220, 340, 230, 360);
    bezier(190, 300, 230, 320, 250, 340, 260, 360);
    
    // Buah Kelapa
    noStroke();
    fill(101, 67, 33);
    ellipse(105, 295, 20, 20); 
    ellipse(120, 295, 20, 20);
    ellipse(185, 315, 20, 20); 
    ellipse(200, 315, 20, 20);
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
  
  void startAudio() {
    if (audioLoaded && musik != null) {
      musik.loop();
    }
  }
  
  void stopAudio() {
    if (audioLoaded && musik != null && musik.isPlaying()) {
      musik.stop();
    }
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

class MobilPantai {
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
