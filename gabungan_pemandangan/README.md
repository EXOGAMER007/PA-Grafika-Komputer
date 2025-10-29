# Project Gabungan Pemandangan

Project Processing yang menggabungkan 3 pemandangan berbeda (Kota, Pegunungan, dan Pantai) dengan sistem menu navigasi.

## Struktur Project

```
gabungan_pemandangan/
├── gabungan_pemandangan.pde   # File utama
├── MenuScene.pde               # Menu navigasi
├── KotaScene.pde              # Pemandangan kota
├── PantaiScene.pde            # Pemandangan pantai
├── PegununganScene.pde        # Pemandangan pegunungan
└── data/                      # Folder audio
    ├── street.mp3
    ├── pantai.mp3
    └── suaraAngin.mp3
```

## Fitur

1. **Menu Utama**: Menampilkan 3 tombol untuk memilih pemandangan
2. **Pemandangan Kota**:

   - Gedung-gedung dengan jendela
   - **Jalan dengan animasi garis bergerak dari kanan ke kiri**
   - Pohon dan kursi taman
   - **Mobil dengan animasi terbang dan berputar** (sama seperti pegunungan)
   - Audio suara kota (street.mp3)

3. **Pemandangan Pantai**:

   - Laut dengan ombak bergerak (Perlin noise)
   - Pohon kelapa
   - Perahu
   - **Jalanan dan pagar bergerak dari kanan ke kiri**
   - **Mobil dengan animasi terbang dan berputar** (sama seperti pegunungan)
   - Audio suara pantai (pantai.mp3)

4. **Pemandangan Pegunungan**:
   - Gunung dengan dataran hijau
   - **Awan bergerak dari kanan ke kiri**
   - **Pagar bergerak dari kanan ke kiri**
   - **Jalanan bergerak dari kanan ke kiri**
   - **Mobil dengan animasi terbang dan berputar**
   - Audio suara angin (suaraAngin.mp3)

## Animasi Mobil

**Semua tiga pemandangan memiliki animasi mobil yang sama:**

- Mobil akan terbang ke atas setinggi 200 pixel
- Saat mencapai puncak, mobil akan berputar 360 derajat
- Setelah berputar, mobil akan turun kembali ke posisi awal
- Animasi akan berulang secara otomatis setiap beberapa detik
- Menggunakan logic yang identik dari scene pegunungan

## Animasi Jalan

**Animasi jalan bergerak dari kanan ke kiri untuk memberikan ilusi mobil bergerak maju:**

- **Kota**: Garis jalan putus-putus bergerak dari kanan ke kiri
- **Pantai**: Garis kuning jalan dan pagar besi bergerak dari kanan ke kiri
- **Pegunungan**: Garis jalan dan pagar kayu bergerak dari kanan ke kiri
- Kecepatan: 5 pixel per frame
- Menggunakan sistem 2 layer untuk kontinuitas animasi

## Cara Menggunakan

1. Buka file `gabungan_pemandangan.pde` di Processing
2. Klik tombol Run
3. Di menu utama, klik salah satu tombol:
   - **KOTA** - untuk melihat pemandangan kota dengan mobil animasi terbang
   - **PEGUNUNGAN** - untuk melihat pemandangan pegunungan dengan mobil animasi terbang
   - **PANTAI** - untuk melihat pemandangan pantai dengan mobil animasi terbang

## Catatan

- Pastikan semua file audio ada di folder `data/`
- Jika audio tidak tersedia, program tetap berjalan tanpa suara
- Setiap kali pindah pemandangan, audio sebelumnya akan dihentikan
- **Animasi mobil menggunakan logic yang sama di semua scene**
- Saat ini animasi mobil dalam mode normal (tidak terbang), ubah `animasiMobil = false` menjadi `true` untuk mengaktifkan animasi terbang

## Navigasi

- **Klik tombol** di menu untuk memilih pemandangan
- **Tekan M** atau **ESC** untuk kembali ke menu dari pemandangan manapun
- Audio akan otomatis berganti sesuai pemandangan yang dipilih

## Catatan

- Pastikan semua file audio ada di folder `data/`
- Jika audio tidak tersedia, program tetap berjalan tanpa suara
- Setiap kali pindah pemandangan, audio sebelumnya akan dihentikan
- **Animasi mobil akan otomatis berjalan saat pemandangan ditampilkan**
- Kecepatan mobil: 3 pixel per frame

## Detail Teknis

### Animasi Mobil (Semua Scene)

```java
// Variabel animasi
boolean animasiMobil = false;  // Set true untuk mengaktifkan animasi terbang
float KecepatanTerbang = 5;
float kecepatanPutar = 5;
boolean terbang = true;
boolean putar = true;
float perputaran = 0;
int terbangTiap = 0;
float tinggiTerbang = 0;

// Logic animasi (sama persis di Kota, Pantai, dan Pegunungan)
// 1. Mobil terbang ke atas (-200 pixel)
// 2. Berputar 360 derajat di puncak
// 3. Turun kembali ke posisi awal
// 4. Tunggu beberapa saat lalu ulangi
```

### Animasi Jalan (Kota & Pantai)

```java
// Variabel animasi jalan (bergerak kanan ke kiri)
float offset = 0;
float offset2 = 800;
boolean ulang = false;
float kecepatan = 5;

// Logic: Menggunakan 2 layer untuk kontinuitas
// Layer 1 bergerak dari kanan ke kiri
// Layer 2 mulai bergerak saat layer 1 mencapai posisi tertentu
// Ketika layer keluar layar, reset ke posisi awal
```

### State Management

- `currentScene = 0` → Menu
- `currentScene = 1` → Kota
- `currentScene = 2` → Pegunungan
- `currentScene = 3` → Pantai

## Library yang Digunakan

- `processing.sound.*` - untuk memutar audio background

## Kontrol Audio

- Audio akan otomatis dimulai saat memilih pemandangan
- Audio akan otomatis berhenti saat kembali ke menu atau pindah ke pemandangan lain
- Hanya satu audio yang berjalan pada satu waktu

---

**Proyek Akhir Grafika Komputer**
