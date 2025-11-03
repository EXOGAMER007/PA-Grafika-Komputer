// File: SceneLoading.pde
// Ini class buat ngatur semua tampilan pas adegan loading

class SceneLoading {
  
  // Variabel-variabel ini 'milik' class SceneLoading
  // Dipindahin dari file loading.pde yang asli
  int loading = 0; // Buat nyimpen progress loading bar-nya udah sejauh mana
  float perputaranX = 0; // Nyimpen info rotasi kotak 3D di sumbu X
  float perputaranY = 0; // Nyimpen info rotasi kotak 3D di sumbu Y
  String text = "MEMUAT..."; // Teks yang mau ditampilin

  // Constructor
  // Ini fungsi yang jalan pas kita bikin `new SceneLoading()`
  // Di sini kosong, soalnya gak ada yang perlu disiapin
  SceneLoading() {
  }

  // Ini fungsi 'draw()'-nya si SceneLoading
  // Bakal dipanggil terus-menerus sama 'draw()' utama pas 'state' lagi 0
  void tampilkan() {
    background(100, 150, 200); // Bersihin layar + kasih warna latar
    
    // Panggil fungsi-fungsi internal biar rapi
    kotak(); // Gambar kotak 3D
    loadingBar(); // Gambar loading bar
  }

  // Fungsi internal buat gambar kotak 3D yang muter
  void kotak() {
    pushMatrix(); // 'Simpen' setingan 'dunia' (posisi 0,0,0)
    
    // Pindahin titik 'origin' (0,0) ke tengah layar agak ke atas
    // '10' di Z itu biar kotaknya agak 'maju' dikit
    translate(width/2, height/2-130, 10);
    
    // Puter 'dunia'-nya
    rotateY(perputaranX);
    rotateZ(perputaranY);
    
    fill(50, 80, 120); // Kasih warna kotaknya
    box(160); // Gambar kotaknya
    
    // Update sudut putar, biar di frame selanjutnya kotaknya gerak
    perputaranY += 0.05;
    perputaranX += 0.05;
    
    popMatrix(); // 'Balikin' setingan 'dunia' kayak semula
    noFill(); // Matiin fill, biar gak ngaruh ke gambar lain
  }

  // Fungsi buat gambar loading bar (termasuk bingkai + teks)
  void loadingBar() { 
    pushMatrix(); // 'Simpen' setingan 'dunia'
    translate(0, 0, 10); // Majuin dikit (biar di depan background)
    
    // Gambar bingkai loading bar-nya (kotak kosong)
    rect(width/2-200, height/2+50, 410, 40); 
    
    // Panggil fungsi buat gambar 'isi' bar-nya
    loadingFill();
    
    // --- Bagian Teks "MEMUAT..." ---
    pushMatrix(); // 'Simpen' setingan 'dunia' (yang udah di-translate Z=10)
    // Majuin lagi (Z=30), biar teks-nya dijamin di depan bar
    translate(0, 0, 30); 
    textSize(20);
    fill(0); // Warna teks hitam
    text(text, width/2-35, height/2+73); // Tulis teksnya
    popMatrix(); // 'Balikin' setingan 'dunia' (kembali ke Z=10)
    
    popMatrix(); // 'Balikin' setingan 'dunia' (kembali ke Z=0)
  }

  // Fungsi buat gambar 'isi' loading bar yang bergerak
  void loadingFill() {
    pushMatrix(); // 'Simpen' setingan 'dunia'
    // Majuin (Z=20). Posisinya di antara bingkai (Z=10) dan teks (Z=30).
    translate(10, 2, 20); 
    noStroke(); // 'Isi' bar gak perlu garis pinggir
    fill(50, 80, 120); // Kasih warna 'isi'-nya
    
    // Gambar kotaknya, lebarnya pake variabel 'loading'
    rect(width/2-200, height/2+50, loading, 30);
    
    // --- Logika Animasi Loading ---
    if (loading < 388) { // Cek, apa bar-nya udah penuh?
      loading += 2; // Kalo belum, tambahin lebarnya 2 pixel
    } else {
      // Kalo udah penuh (loading >= 388)...
      // **INI PENTING**: Kita ganti 'state' global ke 1 (Menu).
      // Nanti di 'draw()' utama, dia bakal liat 'state' udah 1,
      // jadi dia bakal ganti nampilin 'sceneMenu'.
      state = 1; 
    }
    
    popMatrix(); // 'Balikin' setingan 'dunia'
    noFill(); // Matiin fill
    stroke(1); // Nyalain lagi stroke (garis pinggir) buat bingkai
  }
}
