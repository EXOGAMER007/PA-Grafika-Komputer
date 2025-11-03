class SceneMenu {

  float btnKotaX = 300, btnKotaY = 200, btnW = 200, btnH = 50;
  float btnGunungX = 300, btnGunungY = 300, btnHutanX = 300, btnHutanY = 400;

  SceneMenu() {
  }

  void tampilkan() {
    background(50, 50, 80);
    
    textSize(40);
    fill(255);
    textAlign(CENTER, CENTER);
    text("PILIH PANORAMA", width/2, 100);

    fill(100, 100, 150);
    
    if (isMouseOver(btnKotaX, btnKotaY, btnW, btnH)) {
      fill(150, 150, 200);
    }
    rect(btnKotaX, btnKotaY, btnW, btnH, 10);
    
    fill(255);
    textSize(25);
    text("KOTA", btnKotaX + btnW/2, btnKotaY + btnH/2);

    fill(100, 150, 100);
    if (isMouseOver(btnGunungX, btnGunungY, btnW, btnH)) {
      fill(150, 200, 150);
    }
    rect(btnGunungX, btnGunungY, btnW, btnH, 10);
    fill(255);
    textSize(25);
    text("PEGUNUNGAN", btnGunungX + btnW/2, btnGunungY + btnH/2);
    
    fill(150, 150, 100);
    if (isMouseOver(btnHutanX, btnHutanY, btnW, btnH)) {
      fill(200, 200, 150);
    }
    rect(btnHutanX, btnHutanY, btnW, btnH, 10);
    fill(255);
    textSize(25);
    text("PANTAI", btnHutanX + btnW/2, btnHutanY + btnH/2);
  }

  void handleMouseClick() {
    
    if (isMouseOver(btnKotaX, btnKotaY, btnW, btnH)) {
      goToScene(2);
    }
    
    if (isMouseOver(btnGunungX, btnGunungY, btnW, btnH)) {
      goToScene(3);
    }
    
    if (isMouseOver(btnHutanX, btnHutanY, btnW, btnH)) {
      goToScene(4);
    }
  }

  boolean isMouseOver(float x, float y, float w, float h) {
    return (mouseX >= x && mouseX <= x + w &&
            mouseY >= y && mouseY <= y + h);
  }
}
