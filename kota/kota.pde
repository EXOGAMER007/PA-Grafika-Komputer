import processing.sound.*;

SoundFile audioStreet;

Langit langit = new Langit();
Jalan jalan = new Jalan();

Gedung gedung1 = new Gedung(100, 500, 190, 400, color(60, 50, 70));
Gedung gedung2 = new Gedung(250, 500, 100, 300, color(45, 40, 60));
Gedung gedung3 = new Gedung(400, 500, 100, 350, color(70, 60, 80));
Gedung gedung4 = new Gedung(550, 500, 190, 450, color(55, 45, 65));

Kursi kursi1 = new Kursi(340, 520, color(70, 50, 40));
Kursi kursi2 = new Kursi(480, 520, color(70, 50, 40));

Pohon pohon1 = new Pohon(690, 500);
Pohon pohon2 = new Pohon(250, 500);

void setup () {
  size(800, 600);
  background(255);
  audioStreet = new SoundFile(this, "data/street.mp3");
  audioStreet.loop();
}

void draw () {
  langit.tampilkan();
  
  jalan.tampilkan();

  gedung1.tampilkan();
  gedung2.tampilkan();
  gedung3.tampilkan();
  gedung4.tampilkan();

  kursi1.tampilkan();
  kursi2.tampilkan();

  pohon1.tampilkan();
  pohon2.tampilkan();
}
