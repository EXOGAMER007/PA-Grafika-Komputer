// File: ScenePantai.pde
// Ini class buat ngatur semua tampilan dan logika buat scene 'Pantai'.

class ScenePantai {

  // --- Properti/Variabel Milik ScenePantai ---
  // Variabel-variabel ini 'milik' class ScenePantai
  SoundFile musik; // Buat BGM (suara pantai)
  float waveOffset = 0.0; // Buat ngatur animasi ombak (biar gerak naik turun)
  float offsetX = 0; // Buat ngatur animasi jalanan (biar garis & tiang gerak)
  float speed = 3; // Kecepatan gerak jalanan
  mobil mobil; // Objek mobil

  // --- Constructor ---
  // Fungsi yang jalan pas kita bikin `new ScenePantai()` di file utama.
  ScenePantai(PApplet app) {
    // Kita butuh `(PApplet app)` ini biar bisa 'nempel' ke sketch utama (ProyekGabungan)
    // dan bisa ngeload SoundFile.
    musik = new SoundFile(app, "./data/pantai.mp3"); 
    mobil = new mobil(); // "Menghidupkan" objek mobil
  }

  // --- Metode Utama (Mirip draw()) ---
  // Ini 'draw()'-nya si ScenePantai.
  // Dipanggil terus-menerus sama 'draw()' utama pas 'state' lagi 4.
  void tampilkan() {
    // Kode di bawah ini aslinya dari 'draw()' di file PA_Pantai.pde
    
    // Latar Belakang (Langit)
    background(135, 206, 235); // Warna biru langit
    
    // Menggambar Matahari
    noStroke(); // Gak pake garis pinggir
    fill(255, 255, 0); // Warna kuning
    ellipse(700, 100, 80, 80); // Gambar lingkarannya

    // Menggambar Laut 
    fill(0, 119, 190); // Warna biru laut
    noStroke();
    
    // --- Bagian Bikin Ombak (Animasi) ---
    beginShape(); // Mulai gambar bentuk custom
    float xoff = waveOffset; // 'xoff' ini kayak 'seed' buat Perlin Noise
    
    // Loop buat gambar titik-titik ombak di sepanjang layar
    for (float x = 0; x <= width; x += 10) {
      // 'noise(xoff)' ngasih angka acak tapi mulus (0.0 - 1.0)
      // 'map()' ngubah rentang (0-1) jadi (280-300) buat koordinat Y
      float y = map(noise(xoff), 0, 1, 280, 300);
      vertex(x, y); // Buat titik di (x, y)
      xoff += 0.05; // Geser 'seed'-nya dikit biar titik selanjutnya beda
    }
    // Tutup bentuk lautnya (sampai ke dasar layar)
    vertex(width, 500); 
    vertex(0, 500);    
    endShape(CLOSE); // Selesai gambar bentuk custom
    
    // Update 'waveOffset' biar di frame selanjutnya 'seed' noise-nya beda
    // Ini yang bikin ombaknya keliatan gerak
    waveOffset += 0.01; 

    // --- Bagian Bikin Pasir ---
    fill(245, 222, 179); // Warna pasir
    noStroke();
    beginShape(); // Mulai gambar bentuk custom (pasir)
    vertex(0, 350); // Titik awal
    // 'curveVertex()' bikin garis melengkung
    curveVertex(0, 350);
    curveVertex(250, 420); // Lekukan 1
    curveVertex(500, 390); // Lekukan 2
    curveVertex(800, 450); // Titik akhir
    vertex(800, 450);
    // Tutup bentuk pasirnya (sampai ke dasar)
    vertex(800, 500);     
    vertex(0, 500);
    endShape(CLOSE); // Selesai

    // --- Bagian Bikin Perahu ---
    fill(139, 69, 19); // Coklat kayu
    noStroke();
    // 'quad()' gambar bidang 4 sisi (badan perahu)
    quad(280, 415, 270, 390, 400, 390, 390, 415); 
    stroke(139, 69, 19); // Warna tiang
    strokeWeight(4); // Tebal tiang
    line(350, 400, 350, 330); // Gambar tiang (garis)
    noStroke(); // Matiin stroke buat gambar layar
    fill(#FF0000); // Merah
    rect(349, 320, 50, 20); // Bendera/layar atas
    fill(#FFFAFA); // Putih
    rect(349, 340, 50, 20); // Bendera/layar bawah
    
    
    // --- Bagian Tikar Pantai ---
    fill(255, 0, 0); // Merah
    noStroke();
    // 'quad()' gambar tikar (bidang 4 sisi miring)
    quad(540, 450, 620, 450, 600, 410, 560, 410); 
    
    // --- Bagian Tiang Payung ---
    stroke(100); // Abu-abu
    strokeWeight(4); // Tebal tiang
    line(540, 440, 540, 380); // Gambar tiang (garis)
    
    // --- Bagian Payung Pantai ---
    fill(#CCFA03); // Hijau stabilo
    noStroke();
    // 'arc()' gambar setengah lingkaran (PI sampai TWO_PI)
    arc(540, 380, 100, 100, PI, TWO_PI); 
    
    // --- Bagian Pohon Kelapa ---
    fill(139, 69, 19); // Coklat (batang)
    noStroke();
    rect(100, 280, 20, 220); // Batang pohon 1
    rect(180, 300, 20, 200); // Batang pohon 2
    
    stroke(34, 139, 34); // Hijau tua (daun)
    strokeWeight(7); // Tebal daun
    noFill(); // Kita gak mau 'isi' bentuk daunnya, cuma garisnya
    
    // Daun Pohon 1 (pakai 'bezier()' buat bikin lengkungan)
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
    
    // --- Bagian Buah Kelapa ---
    noStroke(); // Gambar kelapa (lingkaran)
    fill(101, 67, 33); // Coklat tua
    ellipse(105, 295, 20, 20); 
    ellipse(120, 295, 20, 20);
    ellipse(185, 315, 20, 20);
    ellipse(200, 315, 20, 20); 

    // --- Bagian Jalanan (Statis) ---
    fill(#2E2E2E); // Abu-abu gelap (aspal)
    rect(0, 500, 800, 100); // Jalan
    fill(#ABADAB); // Abu-abu muda (guardrail)
    rect(0, 450, 800, 10); // Rel guardrail horizontal

    // --- Garis Tengah Jalan (Animasi) ---
    fill(#CBBB23); // Kuning
    // '% 60' (modulo) bikin 'offsetGaris' nilainya ngulang (0-59)
    // Ini penting buat bikin animasi 'looping'
    float offsetGaris = offsetX % 60; 
    // Mulai gambar dari luar layar (-60) biar gak ada garis 'pop-in'
    for (int x = -60; x < 800; x += 60) { // 60 = 30px garis + 30px spasi
      // Gambar garisnya, tapi geser posisinya pake 'offsetGaris'
      rect(x + offsetGaris, 545, 30, 10); 
    }
    
    // --- Tiang Guardrail (Animasi) ---
    fill(#ABADAB); // Abu-abu muda
    // '% 40' (modulo) bikin 'offsetTiang' nilainya ngulang (0-39)
    float offsetTiang = offsetX % 40; 
    for (int x = -40; x < 800; x += 40) { // 40 = 10px tiang + 30px spasi
      // Gambar tiangnya, geser pake 'offsetTiang'
      rect(x + offsetTiang, 450, 10, 50); 
    }

    // --- Update Animasi Jalan ---
    // Kurangin 'offsetX' pake 'speed'. 
    // Ini yang bikin 'offsetGaris' dan 'offsetTiang' berubah tiap frame.
    offsetX -= speed; 
    
    // --- Gambar Mobil ---
    stroke(1); // Nyalain stroke buat mobil
    strokeWeight(2); // Tebal garis mobil
    mobil.gambarMobil(20, 450); // Panggil fungsi gambar mobil
    noStroke(); // Matiin lagi stroke-nya
    
    // --- Tampilkan Petunjuk ---
    // Panggil fungsi internal buat nampilin "Tekan M"
    displayHint();
  }

  // --- Metode Kontrol Musik ---
  // Dipanggil dari 'ProyekGabungan' pas kita *masuk* scene ini
  void playMusic() {
    musik.loop(); // Puter musiknya (loop = ngulang terus)
  }

  // Dipanggil dari 'ProyekGabungan' pas kita *keluar* scene ini
  void stopMusic() {
    musik.stop(); // Berhentiin musiknya
  }
  
  // --- Metode Internal (Helper Function) ---
  // Fungsi ini cuma buat nampilin kotak petunjuk "Tekan M"
  void displayHint() {
    noStroke(); // Pastiin gak ada stroke
    fill(255, 255, 255, 180); // Warna putih, agak transparan
    rect(20, 20, 200, 30, 5); // Gambar kotak rounded
    fill(0); // Warna teks hitam
    textAlign(LEFT, CENTER); // Ratain teks
    textSize(14);
    text("Tekan M untuk ke Menu", 35, 35); // Tulis teksnya
  }
}
