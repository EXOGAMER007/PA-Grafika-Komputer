class Jalan {
  float offset = 0;
  
  Jalan() {
  }

  void tampilkan() {
    // Gambar Trotoar
    fill(80, 75, 70);
    rect(0, 500, width, 100); // Trotoar abu-abu gelap

    // Gambar jalan
    fill(40, 38, 35);
    rect(0, 550, width, 50); // Jalan aspal gelap

    // Gambar garis jalan bergerak
    stroke(200, 180, 120);
    strokeWeight(3);
    for (int i = 0; i < width; i += 40) {
      line(i + offset, 575, i + 20 + offset, 575);
    }
    noStroke();
    
    // Update offset untuk animasi
    offset += 2;
    if (offset >= 40) {
      offset = 0;
    }
  }
}
