class Gedung {
  float x, y;
  float w, h;
  color c;

  Gedung(float x, float y, float w, float h, color c) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.c = c;
  }

  void generateWindow() {
    for (float i = x + 10; i < x + w - 10; i += 30) {
      for (float j = y - h + 10; j < y - 10; j += 30) {
        fill(255, 200, 150);
        rect(i, j, 20, 20);
      }
    }
  }

  void tampilkan() {
    fill(c);
    rect(x, y - h, w, h);
    generateWindow();
  }
}
