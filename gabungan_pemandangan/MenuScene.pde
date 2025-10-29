class MenuScene {
  Button btnKota, btnPegunungan, btnPantai;
  
  MenuScene() {
    // Create three buttons
    btnKota = new Button(300, 200, 200, 60, "KOTA", color(60, 50, 70));
    btnPegunungan = new Button(300, 300, 200, 60, "PEGUNUNGAN", color(55, 120, 55));
    btnPantai = new Button(300, 400, 200, 60, "PANTAI", color(0, 119, 190));
  }
  
  void display() {
    // Background gradient
    for (int i = 0; i < height; i++) {
      float inter = map(i, 0, height, 0, 1);
      int c = lerpColor(color(100, 150, 200), color(50, 80, 120), inter);
      stroke(c);
      line(0, i, width, i);
    }
    noStroke();
    
    // Title
    fill(255);
    textAlign(CENTER, CENTER);
    textSize(48);
    text("PILIH PEMANDANGAN", width/2, 80);
    
    textSize(20);
    text("Klik tombol untuk memilih pemandangan", width/2, 130);
    
    // Display buttons
    btnKota.display();
    btnPegunungan.display();
    btnPantai.display();
    
    // Instructions
    textSize(16);
    fill(200);
    text("Tekan M untuk kembali ke menu dari pemandangan manapun", width/2, height - 30);
  }
  
  int checkClick(int mx, int my) {
    if (btnKota.isClicked(mx, my)) return 1;
    if (btnPegunungan.isClicked(mx, my)) return 2;
    if (btnPantai.isClicked(mx, my)) return 3;
    return 0;
  }
}

class Button {
  float x, y, w, h;
  String label;
  color btnColor;
  
  Button(float x, float y, float w, float h, String label, color btnColor) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.label = label;
    this.btnColor = btnColor;
  }
  
  void display() {
    // Check if mouse is over button
    boolean over = isOver(mouseX, mouseY);
    
    // Button shadow
    fill(0, 0, 0, 100);
    rect(x + 5, y + 5, w, h, 10);
    
    // Button
    if (over) {
      fill(red(btnColor) + 30, green(btnColor) + 30, blue(btnColor) + 30);
    } else {
      fill(btnColor);
    }
    rect(x, y, w, h, 10);
    
    // Button border
    noFill();
    stroke(255);
    strokeWeight(2);
    rect(x, y, w, h, 10);
    noStroke();
    
    // Label
    fill(255);
    textAlign(CENTER, CENTER);
    textSize(24);
    text(label, x + w/2, y + h/2);
  }
  
  boolean isOver(int mx, int my) {
    return mx > x && mx < x + w && my > y && my < y + h;
  }
  
  boolean isClicked(int mx, int my) {
    return isOver(mx, my);
  }
}
