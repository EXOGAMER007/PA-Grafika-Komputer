// File: ProyekGabungan.pde
// Ini file utama kita, "otak" dari semua sketch.
// Semua scene (loading, menu, kota, dll.) akan diatur dari sini.

import processing.sound.*; // Kita butuh library ini buat ngurusin audio (BGM, SFX).

// Variabel 'state' ini adalah kunci dari "State Machine" kita.
// Fungsinya buat nandain kita lagi di adegan mana.
// 0 = Loading, 1 = Menu, 2 = Kota, 3 = Pegunungan, 4 = Pantai
int state = 0; 

// Kita deklarasiin dulu "wadah" buat nyimpen objek dari tiap class scene.
// Nanti di setup() baru kita isi (inisialisasi).
SceneLoading sceneLoading;
SceneMenu sceneMenu;
SceneKota sceneKota;
ScenePegunungan scenePegunungan;
ScenePantai scenePantai;

// Fungsi setup() cuma jalan SEKALI pas aplikasi pertama kali dibuka.
void setup() {
  // Nentuin ukuran window 800x600, dan pakai P3D biar bisa 3D (box, translate Z, dll).
  size(800, 600, P3D); 
  
  // "Menghidupkan" atau inisialisasi setiap objek scene.
  // Kita panggil constructor-nya (new NamaClass()).
  sceneLoading = new SceneLoading();
  sceneMenu = new SceneMenu();
  
  // Nah, untuk scene yang butuh muter suara (SoundFile),
  // kita perlu passing 'this'. 'this' ini nunjuk ke sketch utama (ProyekGabungan.pde).
  // Biar class SceneKota, dkk. bisa pakai fungsi bawaan Processing kayak loadSoundFile.
  sceneKota = new SceneKota(this);
  scenePegunungan = new ScenePegunungan(this);
  scenePantai = new ScenePantai(this);
}

// Fungsi draw() ini adalah "jantung" aplikasi.
// Jalan terus-menerus (default-nya 60x per detik / 60 FPS).
void draw() {
  // Ini inti dari State Machine.
  // Kita cek isi variabel 'state' sekarang nilainya berapa.
  switch(state) {
    case 0:
      // Kalau state=0, kita panggil fungsi tampilkan() punya sceneLoading.
      sceneLoading.tampilkan();
      break;
    case 1:
      // Kalau state=1, kita panggil fungsi tampilkan() punya sceneMenu.
      sceneMenu.tampilkan();
      break;
    case 2:
      // Kalau state=2, panggil punya sceneKota.
      sceneKota.tampilkan();
      break;
    case 3:
      // dan seterusnya...
      scenePegunungan.tampilkan();
      break;
    case 4:
      scenePantai.tampilkan();
      break;
  }
  // Hasilnya, cuma satu scene yang digambar di satu waktu. Gak tumpuk-tindih.
}

// --- Global Input Handlers ---
// Fungsi-fungsi di bawah ini nangani input (keyboard/mouse) secara global.

// Fungsi ini otomatis kepanggil SETIAP KALI tombol keyboard ditekan.
void keyPressed() {
  // Kita cek, tombol yang ditekan 'm' atau 'M' bukan?
  if (key == 'm' || key == 'M') {
    // Kalo 'M' ditekan, kita cek lagi, apa kita lagi di scene game (2, 3, atau 4)?
    if (state == 2 || state == 3 || state == 4) {
      // Kalo iya, matiin semua musik dulu sebelum balik ke menu.
      sceneKota.stopMusic();
      scenePegunungan.stopMusic();
      scenePantai.stopMusic();
      
      // Ganti state jadi 1 (Menu).
      // Nanti di 'draw()' selanjutnya, otomatis sceneMenu yang bakal tampil.
      state = 1; 
    }
  }
}

// Fungsi ini otomatis kepanggil SETIAP KALI tombol mouse diklik.
void mousePressed() {
  // Kita cuma mau nanggepin klik kalo lagi di menu (state 1).
  if (state == 1) {
    // Kita "lempar" tugas nge-handle klik ini ke objek sceneMenu.
    // Biar sceneMenu yang ngecek sendiri apakah klik-nya kena tombol atau enggak.
    // Ini namanya 'Event Delegation'.
    sceneMenu.handleMouseClick();
  }
}

// Ini fungsi buatan kita sendiri (helper function) buat pindah scene.
// Fungsi ini dipanggil dari dalam 'sceneMenu' pas tombol diklik.
void goToScene(int newState) {
  // Update state global kita ke state baru yang dikirim (misal 2, 3, atau 4).
  state = newState;
  
  // Best practice: Selalu matiin SEMUA musik dulu...
  sceneKota.stopMusic();
  scenePegunungan.stopMusic();
  scenePantai.stopMusic();
  
  // ...baru puter musik yang sesuai dengan scene yang baru.
  if (state == 2) sceneKota.playMusic();
  if (state == 3) scenePegunungan.playMusic();
  if (state == 4) scenePantai.playMusic();
}
