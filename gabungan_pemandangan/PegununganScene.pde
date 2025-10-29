class PegununganScene {
  SoundFile suaraBGM;
  PApplet parent;
  
  MobilPegunungan mobil;
  
  int bergerak = 800;
  int bergerak2 = 800;
  boolean ulang = false;
  float kecepatan = 2;
  
  boolean animasi = true;
  boolean animasiMobil = false;
  int bergerakJalanan = 0;
  int bergerakJalanan2 = 800;
  boolean ulangJalanan = false;
  float kecepatanJalanan = 5;
  
  float KecepatanTerbang = 5;
  float kecepatanPutar = 5;
  boolean terbang = true;
  boolean putar = true;
  float perputaran = 0;
  int terbangTiap = 0;
  float tinggiTerbang = 0;
  
  boolean audioLoaded = false;
  
  PegununganScene(PApplet p) {
    parent = p;
    mobil = new MobilPegunungan();
    
    try {
      suaraBGM = new SoundFile(parent, "data/suaraAngin.mp3");
      audioLoaded = true;
    } catch (Exception e) {
      println("Audio file not found: data/suaraAngin.mp3");
      audioLoaded = false;
    }
  }
  
  void display() {
    background(#3399FF);
    parkiran();
    dataranHijau();
    gunung(-87.5, -43.75);
    gunung(135, 0);
    gunung(385, -15);
    gunung(610, 60);
    munculPagar(0, 390, animasi);
    tambalanHijau();
    matahari(355, 20);
    animasiAwan();
    jalan(0, 490, animasi);
    animasiMobil(10, 430, animasiMobil);
    
    displayHint();
  }
  
  void parkiran() {
    pushMatrix();
    fill(#808080);
    translate(0, 430);
    rect(0, 0, 800, 170);
    fill(255);
    popMatrix();
  }
  
  void pagarPanjang(float x, float y) {
    fill(#CC6600);
    float startX = x;
    while (x < 800) {
      pagar(x, y);
      x += 100;
    }
    fill(255);
  }
  
  void pagar(float x, float y) {
    pushMatrix();
    rect(x + 90, y, 10, 50);
    rect(x, y, 100, 5);
    rect(x, y + 15, 100, 5);
    rect(x, y + 30, 100, 5);
    popMatrix();
  }
  
  void animasiPagar(float x, float y) {
    if (ulangJalanan) {
      pushMatrix();
      translate(bergerakJalanan2, 0);
      pagarPanjang(x, y);
      popMatrix();
      bergerakJalanan2 -= kecepatanJalanan;
    }
    if (bergerakJalanan == 0) {
      ulangJalanan = true;
    }
    if (bergerakJalanan2 <= -800) {
      bergerakJalanan2 = 800;
    }
    if (bergerakJalanan <= -800) {
      bergerakJalanan = 800;
    }
    pushMatrix();
    translate(bergerakJalanan, 0);
    pagarPanjang(x, y);
    popMatrix();
    bergerakJalanan -= kecepatanJalanan;
  }
  
  void munculPagar(float x, float y, boolean animation) {
    if (animation) {
      animasiPagar(x, y);
    } else {
      pagarPanjang(x, y);
    }
  }
  
  void gunung(float x, float y) {
    x -= 52.5;
    y += 52.5;
    int x2 = 210;
    int y2 = 315;
    pushMatrix();
    translate(x, y);
    fill(#37A037);
    beginShape();
    vertex(-x2 + x2, y2);
    vertex(0 + x2, 0);
    vertex(x2 + x2, y2);
    endShape();
    fill(255);
    popMatrix();
  }
  
  void dataranHijau() {
    pushMatrix();
    translate(0, 0);
    fill(#37A037);
    rect(0, 270, 800, 160);
    fill(255);
    popMatrix();
  }
  
  void tambalanHijau() {
    pushMatrix();
    noStroke();
    translate(0, 0);
    fill(#37A037);
    rect(490, 345, 40, 30);
    fill(255);
    stroke(0);
    popMatrix();
  }
  
  void matahari(float x, float y) {
    pushMatrix();
    translate(x, y);
    fill(#FFFF00);
    circle(0 + 40, 0 + 40, 80);
    fill(255);
    popMatrix();
  }
  
  void bulat(float x, float y) {
    pushMatrix();
    x += 20;
    y += 20;
    translate(x, y);
    circle(0, 0, 40);
    popMatrix();
  }
  
  void awan(float x, float y) {
    pushMatrix();
    translate(x, y);
    bulat(0, 11.5500);
    bulat(14, 0);
    bulat(50, 0);
    bulat(69, 12.5499);
    bulat(54, 30);
    bulat(14, 30);
    noStroke();
    rect(14, 12.5499, 81, 40);
    rect(34, 10.5499, 40, 20);
    rect(34, 34.5499, 40, 20);
    rect(11, 15.55, 10, 10);
    stroke(0);
    popMatrix();
  }
  
  void animasiAwan() {
    if (ulang) {
      pushMatrix();
      translate(bergerak2, 0);
      awan(140, 16);
      awan(450, 110);
      awan(670, 47.5);
      popMatrix();
      bergerak2 -= kecepatan;
    }
    if (bergerak == 0) {
      ulang = true;
    }
    if (bergerak2 <= -800) {
      bergerak2 = 800;
    }
    if (bergerak <= -800) {
      bergerak = 800;
    }
    pushMatrix();
    translate(bergerak, 0);
    awan(140, 16);
    awan(450, 110);
    awan(670, 47.5);
    popMatrix();
    bergerak -= kecepatan;
  }
  
  void jalan(float x, float y, boolean animation) {
    pushMatrix();
    translate(x, y);
    fill(#4D4D4D);
    rect(0, 0, 800, 110);
    fill(255);
    popMatrix();
    if (animation) {
      animasiJalanan(x, y);
    } else {
      garisJalan(x, y);
    }
  }
  
  void garisJalan(float x, float y) {
    y += 55;
    pushMatrix();
    translate(0, 0);
    float startX = x;
    while (x < 800) {
      rect(x, y, 40, 5);
      x += 80;
    }
    popMatrix();
  }
  
  void animasiJalanan(float x, float y) {
    if (ulangJalanan) {
      pushMatrix();
      translate(bergerakJalanan2, 0);
      garisJalan(x, y);
      popMatrix();
      bergerakJalanan2 -= kecepatanJalanan;
    }
    if (bergerakJalanan == 0) {
      ulangJalanan = true;
    }
    if (bergerakJalanan2 <= -800) {
      bergerakJalanan2 = 800;
    }
    if (bergerakJalanan <= -800) {
      bergerakJalanan = 800;
    }
    pushMatrix();
    translate(bergerakJalanan, 0);
    garisJalan(x, y);
    popMatrix();
    bergerakJalanan -= kecepatanJalanan;
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
    if (audioLoaded && suaraBGM != null) {
      suaraBGM.loop();
    }
  }
  
  void stopAudio() {
    if (audioLoaded && suaraBGM != null && suaraBGM.isPlaying()) {
      suaraBGM.stop();
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

class MobilPegunungan {
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
