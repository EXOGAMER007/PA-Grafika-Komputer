import processing.sound.*;
SoundFile musik;
float waveOffset = 0.0; // Untuk menggerakkan ombak


void setup() {
  size(800, 600);
  musik = new SoundFile(this,"./data/pantai.mp3");
}

void draw() {
  
  musik.play();
  // Latar Belakang
  background(135, 206, 235); // Warna biru langit cerah
  // Menggambar Matahari
  noStroke(); // Tanpa garis tepi
  fill(255, 255, 0); // Warna kuning
  ellipse(700, 100, 80, 80); // Lingkaran untuk matahari

  // Laut 
  fill(0, 119, 190); // Warna biru laut
  noStroke();
  
  //buat ombak
  beginShape();
  float xoff = waveOffset; // Mulai offset untuk noise
  // Iterasi di sepanjang sumbu X
  for (float x = 0; x <= width; x += 10) {
    // Hitung nilai y menggunakan noise()
    // map() mengubah rentang nilai noise (0-1) menjadi rentang y (280-300)
    float y = map(noise(xoff), 0, 1, 280, 300);
    vertex(x, y); // Buat titik di koordinat (x, y)
    xoff += 0.05;
  }
  // Selesaikan bentuk laut sampai ke dasar
  vertex(width, 500); 
  vertex(0, 500);    
  endShape(CLOSE);
  
  waveOffset += 0.01; // Tambah offset agar ombak bergerak di frame berikutnya

  // pasir
  fill(245, 222, 179); // Warna pasir (wheat)
  noStroke();
  beginShape();
  vertex(0, 350);       // Titik awal kiri
  // curveVertex() digunakan untuk membuat garis melengkung
  curveVertex(0, 350);
  curveVertex(250, 420);  // Lekukan pertama
  curveVertex(500, 390);  // Lekukan kedua
  curveVertex(800, 450);  // Titik akhir kanan
  vertex(800, 450);
  vertex(800, 500);     // Batas bawah (sampai jalan)
  vertex(0, 500);       // Batas bawah (sampai jalan)
  endShape(CLOSE);

  // perahu
  fill(139, 69, 19); // Coklat kayu
  noStroke();
  //      (x1, y1,   x2, y2,   x3, y3,   x4, y4)
  quad(280, 415, 270, 390, 400, 390, 390, 415);
  stroke(139, 69, 19);
  strokeWeight(4);
  line(350, 400, 350, 330); // (x1, y1, x2, y2)
  noStroke();
  fill(#FF0000);
  rect(349, 320, 50, 20);
  fill(#FFFAFA);
  rect(349, 340, 50, 20);
  
  
  // Tikar Pantai
  fill(255, 0, 0); // Merah
  noStroke();
  //      (x1, y1,   x2, y2,   x3, y3,   x4, y4)
  quad(540, 450, 620, 450, 600, 410, 560, 410);
  
  // Tiang Payung
  stroke(100); // Abu-abu
  strokeWeight(4);
  line(540, 440, 540, 380); // (x1, y1, x2, y2)
  // Payung Pantai
  fill(#CCFA03);
  noStroke();
  // Setengah lingkaran
  arc(540, 380, 100, 100, PI, TWO_PI);

  // pohon kelapa
  // Batang Pohon
  fill(139, 69, 19); // Warna coklat
  noStroke();
  rect(100, 280, 20, 220); // Batang pohon 1
  rect(180, 300, 20, 200); // Batang pohon 2
  
  stroke(34, 139, 34); // Warna hijau tua
  strokeWeight(7);    // Ketebalan daun
  noFill(); // Kita hanya ingin garisnya, bukan bentuk terisi
  
  // Daun Pohon 1 (pangkal di 110, 280)
  bezier(110, 280, 90, 260, 70, 250, 50, 260);    // Kiri-atas
  bezier(110, 280, 130, 260, 150, 250, 170, 260);   // Kanan-atas
  bezier(110, 280, 70, 280, 40, 290, 20, 310);    // Kiri-tengah
  bezier(110, 280, 150, 280, 180, 290, 200, 310);   // Kanan-tengah
  bezier(110, 280, 90, 300, 80, 320, 70, 340);    // Kiri-bawah
  bezier(110, 280, 130, 300, 140, 320, 150, 340);   // Kanan-bawah
  
  // Daun Pohon 2 (pangkal di 190, 300)
  bezier(190, 300, 170, 280, 150, 270, 130, 280);   // Kiri-atas
  bezier(190, 300, 210, 280, 230, 270, 250, 280);   // Kanan-atas
  bezier(190, 300, 150, 300, 120, 310, 100, 330);   // Kiri-tengah
  bezier(190, 300, 230, 300, 260, 310, 280, 330);   // Kanan-tengah
  bezier(190, 300, 170, 320, 160, 340, 150, 360);   // Kiri-bawah
  bezier(190, 300, 210, 320, 220, 340, 230, 360);   // Kanan-bawah
  bezier(190, 300, 230, 320, 250, 340, 260, 360);   // Kanan-bawah
  
  // Buah Kelapa (digambar setelah daun agar terlihat di depan)
  noStroke();
  fill(101, 67, 33); // Coklat lebih gelap
  ellipse(105, 295, 20, 20); 
  ellipse(120, 295, 20, 20);
  ellipse(185, 315, 20, 20); 
  ellipse(200, 315, 20, 20);

  // jalanan
  fill(#2E2E2E); 
  noStroke();
  rect(0, 500, 800, 100); 
  
  fill(#CBBB23);
  for (int x = 0; x < 800; x+= 60) {
  rect(0 + x, 545, 30, 10);
  }
  
  fill(#ABADAB);
  rect(0, 450, 800, 10);
  for (int x = 0; x < 800; x+= 40) {
  rect(0 + x, 450, 10, 50);
  }
  
  
  // mobile
  gambarMobil(40,420);
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
