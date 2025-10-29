import processing.sound.*;

// State management
int currentScene = 0; // 0 = menu, 1 = kota, 2 = pegunungan, 3 = pantai

// Objects
MenuScene menu;
KotaScene kota;
PegununganScene pegunungan;
PantaiScene pantai;

void setup() {
  size(800, 600);
  
  // Initialize scenes
  menu = new MenuScene();
  kota = new KotaScene(this);
  pegunungan = new PegununganScene(this);
  pantai = new PantaiScene(this);
}

void draw() {
  background(255);
  
  switch(currentScene) {
    case 0:
      menu.display();
      break;
    case 1:
      kota.display();
      break;
    case 2:
      pegunungan.display();
      break;
    case 3:
      pantai.display();
      break;
  }
}

void mousePressed() {
  if (currentScene == 0) {
    // Check menu buttons
    int selected = menu.checkClick(mouseX, mouseY);
    if (selected > 0) {
      currentScene = selected;
      
      // Stop all audio first
      kota.stopAudio();
      pegunungan.stopAudio();
      pantai.stopAudio();
      
      // Start audio for selected scene
      if (currentScene == 1) kota.startAudio();
      else if (currentScene == 2) pegunungan.startAudio();
      else if (currentScene == 3) pantai.startAudio();
    }
  }
}

void keyPressed() {
  // Press ESC or 'M' to return to menu
  if (key == 'M' || key == 'm' || keyCode == ESC) {
    if (currentScene != 0) {
      key = 0; // Prevent ESC from closing the program
      
      // Stop all audio
      kota.stopAudio();
      pegunungan.stopAudio();
      pantai.stopAudio();
      
      currentScene = 0;
    }
  }
}
