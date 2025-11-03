//pushMatrix();
//translate(0,0);
//popMatrix();

import processing.sound.*;
SoundFile suaraBGM;

//class
mobil mobil = new mobil();

// posisi awal awan paling kiri untuk x
//int bergerak = -639;
int bergerak = 800;
int bergerak2 = 800;
boolean ulang = false;
float kecepatan = 2;

//animasi jalanan dan pagar
boolean animasi= true;//memakai animasi atau tidak
boolean animasiMobil = false; //animasi mobil
int bergerakJalanan = 0;//jarak muncul
int bergerakJalanan2 = 800;//jarak muncul
boolean ulangJalanan = false; //triger animasi jalanan ke 2 dimulai
float kecepatanJalanan = 5; //kecepatan animasi

//animasi mobil
float KecepatanTerbang = 5;
float kecepatanPutar = 5;
boolean terbang = true;
boolean putar = true;
float perputaran = 0;
int terbangTiap = 0;
int coba = 0;
float tinggiTerbang =0;//tinggi terbang saat ini


void setup() {
  size(800, 600, P3D);
}

void draw() {
  suaraBGM = new SoundFile(this, "./data/suaraAngin.mp3");

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
  //mobil.gambarMobil(10, 430);
  animasiMobil(10, 430, animasiMobil);
  //testTerbang(10, 430);
  //rect(0, 545, 40, 5);

  noStroke();
  //suaraBGM.play();
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
  while (x < 800) {
    pagar(x, y);
    x+=100;
  }
  fill(255);
}

void pagar(float x, float y) {
  pushMatrix();
  //translate(0, 0);
  rect(x+90, y, 10, 50);//paku

  rect(x, y, 100, 5);//pembatas atas
  rect(x, y+15, 100, 5);//pembatas tengah
  rect(x, y+30, 100, 5);//pembatas bawah
  popMatrix();
}

void animasiPagar(float x, float y) {
  if (ulangJalanan) {
    pushMatrix();
    translate(bergerakJalanan2, 0);

    pagarPanjang(x, y);//bagian utama

    popMatrix();
    bergerakJalanan2-=kecepatanJalanan;
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

  pagarPanjang(x, y);//bagian utama

  popMatrix();
  bergerakJalanan-=kecepatanJalanan;
}

void munculPagar(float x, float y, boolean animation) {
  if (animation) {
    animasiPagar(x, y);
  } else {
    pagarPanjang(x, y);
  }
}

void gunung(float x, float y) {
  //tinggi = 315  dan panjang = 420

  x-=52.5;
  y+=52.5;

  //kordinat umum
  int x2 = 210;
  int y2 = 315;

  pushMatrix();
  translate(x, y);
  fill(#37A037);
  beginShape();
  vertex(-x2+x2, y2);
  vertex(0+x2, 0);
  vertex(x2+x2, y2);
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
  noStroke();
  fill(#FFFF00);
  circle(0+40, 0+40, 80);
  fill(255);
  popMatrix();
}
void bulat(float x, float y) {
  pushMatrix();
  x+=20;
  y+=20;
  translate(x, y);
  circle(0, 0, 40);
  popMatrix();
}

void awan(float x, float y) {
  pushMatrix();

  translate(x, y);
  noStroke();
  //bulatan awan
  bulat(0, 11.5500);
  bulat(14, 0);
  bulat(50, 0);
  bulat(69, 12.5499);
  bulat(54, 30);
  bulat(14, 30);

  //noStroke();
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
    bergerak2-=kecepatan;
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
  bergerak-=kecepatan;
}

void jalan(float x, float y, boolean animation) {
  pushMatrix();
  translate(x, y);
  noStroke();
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
  y+=55;
  pushMatrix();
  translate(0, 0);
  while (x < 800) {
    rect(x, y, 40, 5);
    x+=80;
  }
  popMatrix();
}

void animasiJalanan(float x, float y) {
  if (ulangJalanan) {
    pushMatrix();
    translate(bergerakJalanan2, 0);

    garisJalan(x, y);//bagian utama

    popMatrix();
    bergerakJalanan2-=kecepatanJalanan;
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

  garisJalan(x, y);//bagian utama

  popMatrix();
  bergerakJalanan-=kecepatanJalanan;
}

void animasiMobil(float x, float y, Boolean animation) {


  pushMatrix();
  translate(x, y);
  stroke(1);

  if (animation) {
    pushMatrix();
    translate(0, tinggiTerbang);


    if (tinggiTerbang <= -200 && putar && perputaran < 359) { //animasi berputar
      translate(145, 66.275); // Pindah ke pusat mobil
      rotate(radians(perputaran));
      translate(-145, -66.275); // Kembali ke posisi semula
      perputaran+=kecepatanPutar;
    } else if (perputaran >= 359) {// berhenti berputar
      terbang = false;
      putar = false;
      perputaran =0;
    }

    //  terbang dan turun
    if (terbang && tinggiTerbang > -200) {
      // Masih terbang ke atas
      tinggiTerbang -= KecepatanTerbang;
    } else if (!putar) {
      if (!terbang && tinggiTerbang < 0) {
        // Turun kembali ke posisi awal
        tinggiTerbang += KecepatanTerbang;
      } else if (!terbang && tinggiTerbang >= 0) {
        // Sudah kembali ke posisi awal
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
      terbangTiap = 0; // Reset counter
    }

    stroke(1);
    mobil.gambarMobil(0, 0);
    noStroke();
    
    popMatrix();
    // Cek apakah sudah waktunya terbang lagi
  } else {
    pushMatrix();
    //translate(0, 0);
    mobil.gambarMobil(0, 0);
    popMatrix();
  }
  popMatrix();
}
