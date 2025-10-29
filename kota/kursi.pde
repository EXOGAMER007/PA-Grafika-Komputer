class Kursi {
  float x, y;
  color c;

  Kursi(float x, float y, color c) {
    this.x = x;
    this.y = y;
    this.c = c;
  }

  void tampilkan() {
    fill(c);
    rect(x, y, 50, 8);
    rect(x, y + 8, 50, 15);

    rect(x, y + 8, 5, 22);
    rect(x + 45, y + 8, 5, 22);
  }
}
