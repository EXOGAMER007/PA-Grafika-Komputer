// File: ScenePegunungan.pde
// Ini class yang ngatur semua tampilan dan logika buat scene 'Pegunungan'.
// Semua variabel dan fungsi dari pegunungan.pde lama kita kumpulin di sini.

class ScenePegunungan {

  // --- Properti/Variabel Milik ScenePegunungan ---
  // Variabel-variabel ini 'milik' class ScenePegunungan
  SoundFile suaraBGM; // Buat BGM (suara angin)
  mobil mobil; // Objek mobil (ngambil dari class 'mobil' di file mobil.pde)
  
  // --- Variabel buat Animasi Awan ---
  int bergerak = 800; // Posisi X awan grup 1
  int bergerak2 = 800; // Posisi X awan grup 2 (buat looping)
  boolean ulang = false; // Tanda buat mulai looping awan
  float kecepatan = 2; // Kecepatan gerak awan
  
  // --- Variabel buat Animasi Jalan & Pagar ---
  boolean animasi = true; // Saklar on/off animasi (kayaknya gak kepake, tapi oke)
  boolean animasiMobil = true; // Saklar on/off animasi mobil
  int bergerakJalanan = 0; // Posisi X jalan/pagar grup 1
  int bergerakJalanan2 = 800; // Posisi X jalan/pagar grup 2 (buat looping)
  boolean ulangJalanan = false; // Tanda buat mulai looping jalan/pagar
  float kecepatanJalanan = 5; // Kecepatan gerak jalan/pagar

  // --- Variabel buat Animasi Mobil (Terbang & Putar) ---
  float KecepatanTerbang = 5; // Seberapa cepet mobil naik/turun
  float kecepatanPutar = 5; // Seberapa cepet mobil muter
  boolean terbang = true; // Tanda apa mobil lagi terbang (state 1)
  boolean putar = true; // Tanda apa mobil lagi muter (state 2)
  float perputaran = 0; // Sudut rotasi mobil saat ini
  int terbangTiap = 0; // Counter/timer buat nunggu sebelum terbang lagi
  float tinggiTerbang = 0; // Posisi Y mobil saat ini
  
  // --- Constructor ---
  // Fungsi yang jalan pas kita bikin `new ScenePegunungan()` di file utama.
  ScenePegunungan(PApplet app) {
    // Kita butuh `(PApplet app)` ini biar bisa 'nempel' ke sketch utama
    // dan bisa ngeload SoundFile.
    mobil = new mobil(); // "Menghidupkan" objek mobil
    suaraBGM = new SoundFile(app, "./data/suaraAngin.mp3"); // Siapin file suaranya
  }

  // --- Metode Utama (Mirip draw()) ---
  // Ini 'draw()'-nya si ScenePegunungan.
  // Dipanggil terus-menerus sama 'draw()' utama pas 'state' lagi 3.
  void tampilkan() {
    // Ini kode dari 'draw()' di file pegunungan.pde yang lama
    background(#3399FF); // Gambar langit biru
    
    // Gambar semua elemen statis/latar dulu
    parkiran(); // Area abu-abu di bawah
    dataranHijau(); // Rumput hijau
    gunung(-87.5, -43.75); // Gambar 4 gunung di posisi beda-beda
    gunung(135, 0);
    gunung(385, -15);
    gunung(610, 60);
    
    // Gambar elemen animasi
    munculPagar(0, 390, animasi); // Pagar yang gerak
    tambalanHijau(); // Rumput kecil buat nutupin bug grafis
    matahari(355, 20); // Matahari
    animasiAwan(); // Awan yang gerak
    jalan(0, 490, animasi); // Jalan yang gerak
    animasiMobil(10, 430, animasiMobil); // Mobil yang terbang & muter
    
    noStroke(); // Matiin stroke buat jaga-jaga
    
    // Tampilkan petunjuk "Tekan M"
    displayHint();
  }

  // --- Metode Kontrol Musik ---
  // Dipanggil dari 'ProyekGabungan' pas kita *masuk* scene ini
  void playMusic() {
    suaraBGM.loop(); // Puter BGM-nya (loop = ngulang terus)
  }

  // Dipanggil dari 'ProyekGabungan' pas kita *keluar* scene ini
  void stopMusic() {
    suaraBGM.stop(); // Berhentiin BGM-nya
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

  // 5. --- SEMUA FUNGSI HELPER DARI pegunungan.pde ---
  // Ini semua fungsi 'asli' dari file pegunungan.pde
  // Kita pindahin ke sini biar jadi 'metode'-nya ScenePegunungan.

  // Gambar parkiran (area abu-abu bawah)
  void parkiran() {
    pushMatrix();
    fill(#808080);
    translate(0, 430); // Geser ke bawah
    rect(0, 0, 800, 170);
    fill(255);
    popMatrix(); 
  }

  // Gambar 1 blok pagar (isi 8 pagar kecil)
  void pagarPanjang(float x, float y) {
    fill(#CC6600); // Coklat
    while (x < 800) { // Loop buat gambar pagar sepanjang 800px
      pagar(x, y); // Panggil fungsi gambar 1 pagar
      x+=100; // Geser 100px
    } 
    fill(255);
  }

  // Gambar 1 biji pagar
  void pagar(float x, float y) {
    pushMatrix();
    rect(x+90, y, 10, 50); // Tiang
    rect(x, y, 100, 5); // Palang atas
    rect(x, y+15, 100, 5); // Palang tengah
    rect(x, y+30, 100, 5); // Palang bawah
    popMatrix(); 
  }
  
  // --- Logika Animasi Looping (Pagar) ---
  // Ini trik looping standar: pake 2 gambar, geser barengan.
  // Kalo 1 gambar udah kelewat layar, pindahin lagi ke belakang.
  void animasiPagar(float x, float y) {
    // Cek 'ulangJalanan', apa gambar ke-2 udah boleh jalan?
    if (ulangJalanan) {
      pushMatrix();
      translate(bergerakJalanan2, 0); // Geser 'dunia' ke posisi gambar 2
      pagarPanjang(x, y); // Gambar pagar grup 2
      popMatrix();
      bergerakJalanan2 -= kecepatanJalanan; // Geser posisi gambar 2 ke kiri
    }
    
    // Kalo gambar 1 udah di (0,0), nyalain gambar 2
    if (bergerakJalanan == 0) {
      ulangJalanan = true; 
    }
    
    // Kalo gambar 2 udah kelewat layar (di -800), 'teleport' lagi ke kanan (800)
    if (bergerakJalanan2 <= -800) {
      bergerakJalanan2 = 800; 
    }
    
    // Kalo gambar 1 udah kelewat layar (di -800), 'teleport' lagi ke kanan (800)
    if (bergerakJalanan <= -800) {
      bergerakJalanan = 800;
    }
    
    // Ini gambar grup 1 (yang jalan duluan)
    pushMatrix();
    translate(bergerakJalanan, 0); // Geser 'dunia' ke posisi gambar 1
    pagarPanjang(x, y); // Gambar pagar grup 1
    popMatrix();
    bergerakJalanan -= kecepatanJalanan; // Geser posisi gambar 1 ke kiri
  }

  // Fungsi 'saklar' buat milih mau animasi atau statis
  void munculPagar(float x, float y, boolean animation) {
    if (animation) {
      animasiPagar(x, y); // Kalo true, panggil fungsi animasi
    } else {
      pagarPanjang(x, y); // Kalo false, gambar 1x aja
    }
  }

  // Gambar 1 gunung (segitiga)
  void gunung(float x, float y) {
    x-=52.5; // Penyesuaian koordinat (biar gampang)
    y+=52.5; 
    int x2 = 210; // Setengah lebar
    int y2 = 315; // Tinggi
    pushMatrix();
    translate(x, y); // Pindah ke posisi gunung
    fill(#37A037); // Hijau
    beginShape(); // Bikin segitiga
    vertex(-x2+x2, y2); // Kiri bawah (0, 315)
    vertex(0+x2, 0); // Atas (210, 0)
    vertex(x2+x2, y2); // Kanan bawah (420, 315)
    endShape();
    fill(255);
    popMatrix();
  }

  // Gambar dataran rumput hijau
  void dataranHijau() {
    pushMatrix();
    translate(0, 0);
    fill(#37A037); // Hijau
    rect(0, 270, 800, 160);
    fill(255);
    popMatrix(); 
  }

  // Gambar 'tambalan' rumput (nutupin bug)
  void tambalanHijau() {
    pushMatrix();
    noStroke();
    translate(0, 0);
    fill(#37A037); // Hijau
    rect(490, 345, 40, 30);
    fill(255);
    stroke(0); // Nyalain stroke lagi (default)
    popMatrix(); 
  }

  // Gambar matahari
  void matahari(float x, float y) {
    pushMatrix();
    translate(x, y); // Pindah ke posisi matahari
    noStroke();
    fill(#FFFF00); // Kuning
    circle(0+40, 0+40, 80);
    fill(255);
    popMatrix(); 
  }
  
  // Fungsi bantu buat gambar 1 lingkaran awan
  void bulat(float x, float y) {
    pushMatrix();
    x+=20;
    y+=20;
    translate(x, y);
    circle(0, 0, 40);
    popMatrix(); 
  }

  // Fungsi buat gambar 1 awan (dari 6 lingkaran + 4 kotak)
  void awan(float x, float y) {
    pushMatrix();
    translate(x, y); // Pindah ke posisi awan
    noStroke();
    // Gambar 6 lingkaran
    bulat(0, 11.5500);
    bulat(14, 0);
    bulat(50, 0);
    bulat(69, 12.5499); 
    bulat(54, 30);
    bulat(14, 30);
    // Gambar 4 kotak (ngisi tengah)
    rect(14, 12.5499, 81, 40);
    rect(34, 10.5499, 40, 20);
    rect(34, 34.5499, 40, 20);
    rect(11, 15.55, 10, 10); 
    stroke(0); // Nyalain stroke lagi
    popMatrix();
  }

  // --- Logika Animasi Looping (Awan) ---
  // Trik-nya sama persis kayak 'animasiPagar'
  void animasiAwan() {
    // Cek 'ulang', apa gambar ke-2 udah boleh jalan?
    if (ulang) {
      pushMatrix();
      translate(bergerak2, 0); // Geser ke posisi awan grup 2
      awan(140, 16); // Gambar 3 awan di grup 2
      awan(450, 110);
      awan(670, 47.5);
      popMatrix();
      bergerak2 -= kecepatan; // Geser grup 2 ke kiri
    }
    
    // Kalo grup 1 udah di (0,0), nyalain grup 2
    if (bergerak == 0) {
      ulang = true; 
    }
    
    // Kalo grup 2 udah kelewat layar (-800), teleport ke kanan (800)
    if (bergerak2 <= -800) {
      bergerak2 = 800; 
    }
    
    // Kalo grup 1 udah kelewat layar (-800), teleport ke kanan (800)
    if (bergerak <= -800) {
      bergerak = 800;
    }
    
    // Ini gambar grup 1 (yang jalan duluan)
    pushMatrix();
    translate(bergerak, 0); // Geser ke posisi awan grup 1
    awan(140, 16); // Gambar 3 awan di grup 1
    awan(450, 110); 
    awan(670, 47.5);
    popMatrix();
    bergerak -= kecepatan; // Geser grup 1 ke kiri
  }

  // Fungsi buat gambar jalan
  void jalan(float x, float y, boolean animation) {
    pushMatrix();
    translate(x, y); // Pindah ke posisi jalan
    noStroke();
    fill(#4D4D4D); // Abu-abu gelap (aspal)
    rect(0, 0, 800, 110); 
    fill(255);
    popMatrix();
    
    // Cek, mau animasi atau statis?
    if (animation) {
      animasiJalanan(x, y); // Panggil fungsi animasi garis
    } else {
      garisJalan(x, y); // Panggil fungsi gambar statis
    }
  }

  // Gambar garis jalan (statis)
  void garisJalan(float x, float y) {
    y+=55; // Posisikan di tengah jalan
    pushMatrix();
    translate(0, 0);
    while (x < 800) { // Loop gambar garis putus-putus
      rect(x, y, 40, 5); // Gambar 1 garis
      x+=80; // Kasih spasi (lompat 80px)
    }
    popMatrix(); 
  }

  // --- Logika Animasi Looping (Garis Jalan) ---
  // Trik-nya sama persis kayak 'animasiPagar'
  void animasiJalanan(float x, float y) {
    // Cek 'ulangJalanan', apa grup 2 udah boleh jalan?
    if (ulangJalanan) {
      pushMatrix();
      translate(bergerakJalanan2, 0); // Geser ke posisi grup 2
      garisJalan(x, y); // Gambar garis grup 2
      popMatrix();
      bergerakJalanan2 -= kecepatanJalanan; // Geser grup 2
    }
    
    // Kalo grup 1 udah di (0,0), nyalain grup 2
    if (bergerakJalanan == 0) {
      ulangJalanan = true; 
    }
    
    // Kalo grup 2 kelewat layar, teleport
    if (bergerakJalanan2 <= -800) {
      bergerakJalanan2 = 800; 
    }
    
    // Kalo grup 1 kelewat layar, teleport
    if (bergerakJalanan <= -800) {
      bergerakJalanan = 800;
    }
    
    // Ini gambar grup 1 (yang jalan duluan)
    pushMatrix();
    translate(bergerakJalanan, 0); // Geser ke posisi grup 1
    garisJalan(x, y); // Gambar garis grup 1
    popMatrix();
    bergerakJalanan -= kecepatanJalanan; // Geser grup 1
  }

  // --- Logika Animasi Mobil Terbang & Putar ---
  void animasiMobil(float x, float y, Boolean animation) {
    pushMatrix(); // Simpen 'dunia'
    translate(x, y); // Pindah ke posisi awal mobil
    stroke(1); // Kasih garis pinggir
    
    if (animation) { // Cek, animasinya nyala?
      pushMatrix(); // Simpen 'dunia' (yang udah di x,y)
      
      // Geser mobilnya naik/turun pake 'tinggiTerbang'
      translate(0, tinggiTerbang); 
      
      // Cek: Apa mobil lagi di puncak (tinggi <= -200),
      // 'putar' = true, dan rotasinya ('perputaran') belum selesai ( < 359)?
      if (tinggiTerbang <= -200 && putar && perputaran < 359) { 
        // --- Ini trik buat muter di tengah ---
        translate(145, 66.275); // PENTING: Pindah dulu ke 'pusat rotasi' mobil
        rotate(radians(perputaran)); // Puter 'dunia'-nya dari titik pusat tadi
        translate(-145, -66.275); // Balikin lagi 'dunia'-nya ke posisi semula
        
        perputaran += kecepatanPutar; // Tambahin sudut putar buat frame brikutnya
        
      } else if (perputaran >= 359) { // Kalo rotasi udah selesai...
        terbang = false; // ...set 'terbang' = false (artinya "mode turun")
        putar = false; // ...set 'putar' = false (artinya "jangan muter lagi")
        perputaran = 0; // Reset sudut putar
      }
      
      // Cek: Kalo 'terbang' = true dan belum sampe puncak...
      if (terbang && tinggiTerbang > -200) {
        tinggiTerbang -= KecepatanTerbang; // ...mobil gerak ke atas (Y berkurang)
        
      } else if (!putar) { // Kalo 'putar' = false (artinya "mode turun")...
        // Cek: Kalo 'terbang' = false dan belum sampe darat...
        if (!terbang && tinggiTerbang < 0) {
          tinggiTerbang += KecepatanTerbang; // ...mobil gerak ke bawah (Y bertambah)
          
        } else if (!terbang && tinggiTerbang >= 0) { // Kalo udah sampe darat...
          tinggiTerbang = 0; // ...pas-in posisinya di 0
          putar = true; // ...set 'putar' = true (artinya "siap-siap muter lagi nanti")
          perputaran = 0; // Reset sudut putar
        }
      }
      
      // Cek: Kalo 'putar' = true tapi 'terbang' = false (artinya: lagi di darat)...
      if (putar && !terbang) {
        terbangTiap += 50; // ...mulai 'timer' nunggu
      }
      
      // Cek: Kalo 'timer' nunggu udah kelar (>= 800) dan 'putar' = true...
      if (terbangTiap >= 800 && putar == true) {
        terbang = true; // ...set 'terbang' = true (artinya "mode terbang")
        terbangTiap = 0; // Reset 'timer'
      }
      
      stroke(1);
      mobil.gambarMobil(0, 0); // Gambar mobilnya di (0,0) relatif
      noStroke();
      
      popMatrix(); // Balikin 'dunia' (sebelum translate tinggiTerbang)
      
    } else { // Kalo 'animation' = false
      pushMatrix();
      mobil.gambarMobil(0, 0); // Gambar mobil diem aja
      popMatrix(); 
    }
    popMatrix(); // Balikin 'dunia' (sebelum translate x,y)
  }
}
