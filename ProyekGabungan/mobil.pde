// File: mobil.pde
// Ini adalah file class 'mobil' yang dipakai bareng-bareng
// sama ScenePegunungan dan ScenePantai.
// Kita pisah filenya biar rapi dan gak duplikat kode.

class mobil { 
  
  // --- Metode Utama ---
  // Ini fungsi 'utama' buat gambar mobil.
  // Kalo scene lain mau gambar mobil, mereka tinggal panggil fungsi ini.
  // Parameter x dan y nentuin di mana mobilnya bakal digambar.
  void gambarMobil(float x, float y) {
    pushMatrix(); // 'Simpen' setingan 'dunia' (posisi, rotasi, dll.)
    
    // Geser 'dunia' ke posisi (x, y) yang diminta
    // 'y += 50' ini kayaknya buat penyesuaian posisi,
    // biar pas digambar, rodanya pas di 'y' yang dituju
    y += 50; 
    translate(x, y); // Pindahin 'origin' (0,0) ke (x, y)
    
    // Panggil fungsi-fungsi internal buat gambar tiap bagian mobil
    // Ini biar rapi aja, gak numpuk semua di satu fungsi
    badanMobil(); // Gambar badan
    jendelaMobil(); // Gambar jendela/kabin
    peganganPintuMobil(); // Gambar gagang pintu
    
    popMatrix(); // 'Balikin' setingan 'dunia' kayak semula
  }

  // --- Metode Internal (Helper Functions) ---
  // Fungsi-fungsi ini cuma buat bantu 'gambarMobil()'
  // Biar kodenya kebagi-bagi dan gampang dibaca.

  // Fungsi buat gambar badan mobil (bagian bawah)
  void badanMobil() {
    pushMatrix(); // Simpen setingan
    translate(0, 0); // (Gak wajib, soalnya udah di 0,0 relatif ke gambarMobil)
    fill(#999900); // Warna badan (kuning lumpur)
    rect(0, 0, 290, 60); // Gambar kotak badan mobil
    
    // Panggil fungsi bantu lagi buat detail di badan
    lampuMobil(); // Gambar lampu di atas badan
    banMobil(); // Gambar ban di bawah badan
    
    popMatrix(); // Balikin setingan
  }

  // Fungsi buat gambar lampu
  void lampuMobil() {
    pushMatrix(); // Simpen
    translate(0, 0); // (Gak wajib juga)
    fill(#FF3333); // Merah (lampu rem/kiri)
    rect(0, 10, 20, 10); // Lampu di ujung kiri
    fill(#0000FF); // Biru (?? lampu kanan)
    rect(270, 10, 20, 10); // Lampu di ujung kanan
    popMatrix(); // Balikin
  }

  // Fungsi buat gambar ban
  void banMobil() {
    pushMatrix(); // Simpen
    // Majuin dikit (Z=10), biar ban-nya keliatan 'nempel' di luar badan
    // Kalo P3D gak aktif, translate Z ini gak ada efeknya
    translate(0, 0, 10); 
    fill(#4D4D4D); // Abu-abu gelap (warna ban)
    circle(53, 60, 40); // Ban kiri
    circle(240, 62.04, 40); // Ban kanan

    fill(0); // Hitam (buat velg/tengah ban)
    circle(53, 60, 5); // Velg kiri
    circle(240, 62.04, 5); // Velg kanan
    fill(255); // Balikin warna fill ke putih (default, jaga-jaga)
    popMatrix(); // Balikin
  }

  // Fungsi buat gambar kabin/jendela (bagian atas mobil)
  void jendelaMobil() {
    pushMatrix(); // Simpen
    translate(0, 0); // (Gak wajib)
    fill(#666666); // Abu-abu (warna kaca)
    
    // 'beginShape()' buat gambar bentuk custom (trapesium miring)
    // Titik (0,0) nya relatif ke 'badanMobil'
    beginShape();
    vertex(0, 0); // Kiri bawah (nempel badan)
    vertex(45, -50); // Kiri atas (puncak kaca depan)
    vertex(196, -50); // Kanan atas (puncak kaca belakang)
    vertex(245, 0); // Kanan bawah (nempel badan)
    endShape(); // Selesai gambar bentuk

    // Gambar garis-garis pembatas (pintu & jendela)
    line(45, -50, 45, 0); // Kaca depan
    line(100, -50, 100, 60); // Antara pintu depan & belakang
    line(150, -50, 150, 60); // Antara pintu belakang & bagasi
    line(245, 0, 245, 42); // Kaca belakang

    popMatrix(); // Balikin
  }

  // Fungsi buat gambar gagang pintu
  void peganganPintuMobil() {
    pushMatrix(); // Simpen
    translate(0, 0); // (Gak wajib)
    fill(255); // Putih
    
    // Gambar 2 kotak kecil
    rect(110, 10, 8, 3); // Gagang 1 (pintu depan)
    rect(160, 10, 8, 3); // Gagang 2 (pintu belakang)
    popMatrix(); // Balikin
  }
}
