class Pohon {
  float x, y;
  
  Pohon(float x, float y) {
    this.x = x;
    this.y = y;
  }

  void tampilkan() {
    // Batang
    fill(80, 50, 30);
    rect(x, y, 20, 50);
    // Daun
    fill(50, 80, 45);
    ellipse(x + 10, y - 35, 80, 80);
  }
}
