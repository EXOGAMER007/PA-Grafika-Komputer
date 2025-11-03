// File: SceneKota.pde
// Oke, ini class buat ngatur semua yang ada di scene 'Kota'.
// Anggep aja ini kayak file .pde khusus buat kota, tapi dibungkus jadi satu 'objek'.

class SceneKota {

  // 1. "Properti" atau "Variabel Milik" SceneKota
  // Kita deklarasiin dulu 'properti' apa aja yang dipunya si SceneKota.
  // Ini kayak "bahan-bahan" yang dibutuhin buat nampilin scene ini.
  SoundFile audioStreet; // Buat BGM (suara jalanan)
  Langit langit;     // Objek langit
  Jalan jalan;       // Objek jalan
  Gedung gedung1, gedung2, gedung3, gedung4; // Objek-objek gedung
  Kursi kursi1, kursi2; // Objek-objek kursi
  Pohon pohon1, pohon2; // Objek-objek pohon
  mobil mobil;       // Objek mobil

  // 2. "Constructor"
  // Ini fungsi yang bakal kepanggil pas kita bikin `new SceneKota()` di file utama.
  // Tugasnya 'mempersiapkan' semua properti di atas.
  SceneKota(PApplet app) {
    // Kita butuh `(PApplet app)` ini biar bisa 'nempel' ke sketch utama (ProyekGabungan).
    // Gunanya cuma satu: biar bisa ngeload SoundFile.
    audioStreet = new SoundFile(app, "data/street.mp3"); 
    
    // "Menghidupkan" semua objek (memanggil constructor-nya masing-masing).
    langit = new Langit();
    jalan = new Jalan();
    // Ngasih parameter (posisi, ukuran, warna) pas bikin gedung
    gedung1 = new Gedung(100, 500, 190, 400, color(60, 50, 70)); 
    gedung2 = new Gedung(250, 500, 100, 300, color(45, 40, 60)); 
    gedung3 = new Gedung(400, 500, 100, 350, color(70, 60, 80)); 
    gedung4 = new Gedung(550, 500, 190, 450, color(55, 45, 65)); 
    
    kursi1 = new Kursi(340, 520, color(70, 50, 40));
    kursi2 = new Kursi(480, 520, color(70, 50, 40)); 
    
    pohon1 = new Pohon(690, 500);
    pohon2 = new Pohon(250, 500); 
    
    // Bikin objek mobilnya juga
    mobil = new mobil();
  }

  // 3. "Metode Tampilkan"
  // Nah, ini 'jantung'-nya SceneKota. Isinya mirip `draw()` tapi khusus buat scene ini aja.
  // Dipanggil terus-terusan dari `draw()` utama di ProyekGabungan.
  void tampilkan() {
    
    // --- Blok 1: Gambar Langit ---
    pushMatrix(); // 'Simpen' setingan (posisi, rotasi, dll.) 'dunia'
    translate(0, 10, 0); // Geser 'dunia'-nya dikit (biar langit agak ke atas)
    langit.tampilkan();  // Suruh objek langit buat gambar dirinya
    popMatrix();  // 'Balikin' setingan 'dunia' kayak semula
    
    // --- Blok 2: Gambar Jalan, Gedung, dll. ---
    pushMatrix(); // 'Simpen' setingan 'dunia' lagi
    // Majuin 'dunia' dikit ke depan (sumbu Z). 
    // Biar jalanan, gedung, dll. keliatan di depan langit (yang di Z=0).
    translate(0, 0, 20); 
    
    // Suruh semua objek ini gambar diri mereka (di 'dunia' yang udah dimajuin)
    jalan.tampilkan();
    gedung1.tampilkan();
    gedung2.tampilkan();
    gedung3.tampilkan();
    gedung4.tampilkan();
    kursi1.tampilkan();
    kursi2.tampilkan();
    pohon1.tampilkan();
    pohon2.tampilkan();
    
    popMatrix(); // 'Balikin' setingan 'dunia' lagi (kembali ke Z=0)
    
    
    // --- Blok 3: Gambar Mobil ---
    // Mobil ini digambar di 'dunia' terpisah biar gampang ngatur Z-index (biar di depan)
    pushMatrix(); // 'Simpen' setingan 'dunia' (yang Z=0)
    // Pindah ke posisi X=100, Y=420, dan Z=100 (paling depan)
    translate(100, 420, 100);
    // 'Dunia' dikecilin jadi 20% (0.2) dari titik (100, 420) itu.
    // Efeknya, semua yang digambar setelah ini jadi kecil.
    scale(0.2); 
    
    stroke(1); // Kasih garis pinggir
    strokeWeight(2); // Tebal garisnya 2
    
    // Gambar mobil di koordinat (100, 400) *RELATIF* ke 'dunia' yang udah
    // di-translate dan di-scale.
    mobil.gambarMobil(100, 400);
    
    popMatrix(); // 'Balikin' setingan 'dunia' ke Z=0, skala 1.0
    
    
    // --- Blok 4: Teks Petunjuk ---
    pushMatrix(); // 'Simpen' setingan 'dunia' (Z=0)
    // Majuin dikit (Z=40), biar di depan langit (Z=0) & jalan (Z=20),
    // tapi di belakang mobil (Z=100).
    translate(0, 0, 40);
    // Panggil fungsi internal buat nampilin teks "Tekan M"
    displayHint();
    popMatrix(); // 'Balikin' setingan 'dunia'
  }

  // 4. "Metode Kontrol Musik"
  // Fungsi-fungsi ini dipanggil dari file utama (ProyekGabungan)
  
  // Dipanggil pas kita *masuk* ke scene ini
  void playMusic() {
    audioStreet.loop(); // Puter musiknya (loop = ngulang terus)
  }

  // Dipanggil pas kita *keluar* dari scene ini (misal, pas tekan 'M')
  void stopMusic() {
    audioStreet.stop(); // Berhentiin musiknya
  }
  
  // 5. "Metode Internal" (Helper Function)
  // Fungsi ini cuma buat bantu-bantu di dalem class ini aja.
  // Buat nampilin kotak petunjuk "Tekan M".
  void displayHint() {
    noStroke(); // Gak pake garis pinggir
    fill(255, 255, 255, 180); // Warna putih, agak transparan (alpha 180)
    rect(40, 25, 200, 30, 5); // Gambar kotak rounded
    fill(0); // Ganti warna jadi hitam buat teks
    textAlign(LEFT, CENTER); // Ratain teksnya
    textSize(14);
    text("Tekan M untuk ke Menu", 50, 40); // Tulis teksnya
  }

  // 6. --- INNER CLASSES ---
  // Di bawah ini semua adalah 'Inner Class'.
  // Ini class-class pembantu (Langit, Jalan, dll.) yang 'bersarang' di dalem SceneKota.
  // Ini cara rapiin kode biar semua yang berhubungan sama 'Kota' ada di satu file.
  // (Alternatifnya bisa bikin file .pde baru buat tiap class, kayak 'mobil.pde')

  // === Isi dari langit.pde ===
  class Langit { 
    Langit() {} // Constructor-nya kosong, gak ngapa-ngapain
    void tampilkan() {  
      // Loop buat bikin gradasi langit (atas)
      for (int i = 0; i < 300; i++) {
        float inter = map(i, 0, 300, 0, 1); // Hitung posisi gradasi
        // lerpColor = nyampur 2 warna. Dari biru gelap (25,25,70) ke oranye (255,140,80)
        int c = lerpColor(color(25, 25, 70), color(255, 140, 80), inter); 
        stroke(c); // Set warna garis
        line(0, i, width, i); // Gambar garis horizontal
      } 
      // Loop buat bikin gradasi langit (bawah)
      for (int i = 300; i < 500; i++) {
        float inter = map(i, 300, 500, 0, 1);
        // Nyampur dari oranye (255,140,80) ke pink (255,100,130)
        int c = lerpColor(color(255, 140, 80), color(255, 100, 130), inter); 
        stroke(c);
        line(0, i, width, i);
      }
      noStroke(); // Matikan garis pinggir buat gambar matahari
      
      // Gambar Matahari (agak transparan)
      pushMatrix(); 
      translate(0, 0, 10); // Majuin dikit mataharinya (biar 'di dalem' langit)
      fill(255, 120, 80, 200); // Oranye, transparan
      ellipse(100, 100, 180, 180);
      fill(255, 140, 100, 100); // Oranye muda, lebih transparan (buat aura)
      ellipse(100, 100, 240, 240); 
      popMatrix();
    }
  }

  // === Isi dari jalan.pde ===
  class Jalan { 
    float offset = 0; // Variabel buat animasi garis jalan
    Jalan() {} // Constructor kosong
    void tampilkan() {
      // Gambar Trotoar
      fill(80, 75, 70);
      rect(0, 500, width, 100); 
      // Gambar Jalan
      fill(40, 38, 35);
      rect(0, 550, width, 50); 
      
      // Gambar garis jalan putus-putus
      stroke(200, 180, 120); // Warna kuning
      strokeWeight(3); 
      for (int i = 0; i < width; i += 40) {
        // 'offset' bikin garisnya keliatan gerak
        line(i + offset, 575, i + 20 + offset, 575); 
      }
      noStroke(); // Matiin stroke buat gambar lain
      
      // Update animasi garis jalan
      offset += 2; // Geser garisnya 2 pixel
      if (offset >= 40) { // Kalo udah geser 40 pixel (panjang 1 siklus)
        offset = 0; // Reset lagi ke 0
      }
    }
  }

  // === Isi dari gedung.pde ===
  class Gedung { 
    float x, y, w, h; // Properti posisi (x,y) dan ukuran (lebar, tinggi)
    color c; // Properti warna
    
    // Constructor buat 'nangkep' data pas bikin `new Gedung(...)`
    Gedung(float x, float y, float w, float h, color c) { 
      // Simpen data-nya ke variabel milik objek ini
      this.x = x; this.y = y; this.w = w; this.h = h; this.c = c; 
    }
    
    // Fungsi internal buat gambar jendela
    void generateWindow() {
      // Loop bersarang buat bikin grid jendela
      for (float i = x + 10; i < x + w - 10; i += 30) { // Loop horizontal
        for (float j = y - h + 10; j < y - 10; j += 30) { // Loop vertikal
          fill(255, 200, 150); // Warna jendela nyala
          rect(i, j, 20, 20); // Gambar 1 jendela
        }
      }
    }
    
    // Fungsi utama buat nampilin gedung
    void tampilkan() {
      fill(c); // Pakai warna gedung yang udah disimpen
      rect(x, y - h, w, h); // Gambar badan gedungnya
      generateWindow(); // Panggil fungsi buat gambar jendelanya
    }
  }
  
  // === Isi dari kursi.pde ===
  class Kursi { 
    float x, y;
    color c;
    
    // Constructor-nya
    Kursi(float x, float y, color c) {
      this.x = x; this.y = y; this.c = c; 
    }
    
    // Fungsi buat gambar kursi (cuma tumpukan kotak)
    void tampilkan() {
      fill(c); // Pakai warna kursi
      rect(x, y, 50, 8); // Dudukan
      rect(x, y + 8, 50, 15); // Sandaran
      rect(x, y + 8, 5, 22); // Kaki 1
      rect(x + 45, y + 8, 5, 22); // Kaki 2
    }
  }
  
  // === Isi dari pohon.pde ===
  class Pohon { 
    float x, y;
    
    // Constructor-nya
    Pohon(float x, float y) {
      this.x = x; this.y = y; 
    }
    
    // Fungsi buat gambar pohon
    void tampilkan() {
      // Batang
      fill(80, 50, 30); // Coklat
      rect(x, y, 20, 50); 
      // Daun
      fill(50, 80, 45); // Hijau
      ellipse(x + 10, y - 35, 80, 80); 
    }
  }
}
