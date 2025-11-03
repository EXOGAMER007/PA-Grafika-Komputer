// File: SceneMenu.pde
// Ini class yang ngatur semua tampilan dan logika buat menu utama.

class SceneMenu {

  // --- Properti/Variabel Milik SceneMenu ---
  // Kita tentuin dulu koordinat (x,y) dan ukuran (lebar, tinggi) buat semua tombol.
  // Kalo mau ganti posisi tombol, tinggal ganti angka di sini aja.
  float btnKotaX = 300, btnKotaY = 200, btnW = 200, btnH = 50;
  float btnGunungX = 300, btnGunungY = 300, btnHutanX = 300, btnHutanY = 400;

  // Constructor
  // Fungsi yang jalan pas bikin `new SceneMenu()`
  // Kita gak perlu nyiapin apa-apa di sini, jadi biarin kosong.
  SceneMenu() {
    // Constructor
  }

  // --- Metode Utama (Mirip draw()) ---
  // Ini 'draw()'-nya si SceneMenu. 
  // Dipanggil terus-menerus sama 'draw()' utama pas 'state' lagi 1.
  void tampilkan() {
    background(50, 50, 80); // Kasih warna latar menu (biru gelap)
    
    // --- Bagian Judul ---
    textSize(40); // Ukuran font
    fill(255); // Warna teks (putih)
    textAlign(CENTER, CENTER); // Bikin teksnya rata tengah (horizontal & vertikal)
    text("PILIH PANORAMA", width/2, 100); // Tulis teksnya di tengah (width/2)

    // --- Tombol 1: Kota ---
    fill(100, 100, 150); // Set warna default tombol (biru agak ungu)
    
    // Cek: Apa mouse lagi di atas area tombol ini?
    if (isMouseOver(btnKotaX, btnKotaY, btnW, btnH)) {
      fill(150, 150, 200); // Kalo iya, ganti warna jadi lebih terang (efek hover)
    }
    rect(btnKotaX, btnKotaY, btnW, btnH, 10); // Gambar kotak tombolnya (10 = sudut rounded)
    
    fill(255); // Ganti warna jadi putih (buat teks di dalem tombol)
    textSize(25); // Ukuran font teks
    // Tulis teksnya. Posisinya di (x + lebar/2) dan (y + tinggi/2) biar pas di tengah tombol.
    text("KOTA", btnKotaX + btnW/2, btnKotaY + btnH/2);

    // --- Tombol 2: Pegunungan ---
    fill(100, 150, 100); // Warna default tombol (hijau)
    if (isMouseOver(btnGunungX, btnGunungY, btnW, btnH)) {
      fill(150, 200, 150); // Warna hover (hijau muda)
    }
    rect(btnGunungX, btnGunungY, btnW, btnH, 10); // Gambar kotak tombolnya
    fill(255); // Warna teks
    textSize(25);
    text("PEGUNUNGAN", btnGunungX + btnW/2, btnGunungY + btnH/2);
    
    // --- Tombol 3: Pantai ---
    fill(150, 150, 100); // Warna default (kuning/pasir)
    if (isMouseOver(btnHutanX, btnHutanY, btnW, btnH)) {
      fill(200, 200, 150); // Warna hover (kuning muda)
    }
    rect(btnHutanX, btnHutanY, btnW, btnH, 10); // Gambar kotak tombolnya
    fill(255); // Warna teks
    textSize(25);
    text("PANTAI", btnHutanX + btnW/2, btnHutanY + btnH/2);
  }

  // --- Metode Aksi (Dipanggil dari `mousePressed()` global) ---
  // Fungsi ini bakal dipanggil dari 'ProyekGabungan.pde'
  // setiap kali mouse diklik, *tapi cuma kalo kita lagi di state 1 (Menu)*.
  void handleMouseClick() {
    
    // Cek: Apa mouse diklik pas lagi di atas tombol Kota?
    if (isMouseOver(btnKotaX, btnKotaY, btnW, btnH)) {
      goToScene(2); // Kalo iya, panggil fungsi global buat pindah ke state 2 (Kota)
    }
    
    // Cek: Apa mouse diklik pas lagi di atas tombol Pegunungan?
    if (isMouseOver(btnGunungX, btnGunungY, btnW, btnH)) {
      goToScene(3); // Kalo iya, pindah ke state 3 (Pegunungan)
    }
    
    // Cek: Apa mouse diklik pas lagi di atas tombol Pantai?
    if (isMouseOver(btnHutanX, btnHutanY, btnW, btnH)) {
      goToScene(4); // Kalo iya, pindah ke state 4 (Pantai)
    }
  }

  // --- Metode Internal (Helper Function) ---
  // Ini fungsi bantu buat nge-cek posisi mouse.
  // 'boolean' artinya fungsinya bakal ngembaliin nilai 'true' atau 'false'.
  boolean isMouseOver(float x, float y, float w, float h) {
    // Cek:
    // 1. Apa mouseX ada di antara 'x' dan 'x + w' (area horizontal tombol)?
    // 2. DAN (&&) Apa mouseY ada di antara 'y' dan 'y + h' (area vertikal tombol)?
    return (mouseX >= x && mouseX <= x + w &&
            mouseY >= y && mouseY <= y + h);
    // Kalo dua-duanya bener, fungsinya ngasih 'true'. Kalo salah satu aja salah, ngasih 'false'.
  }
}
