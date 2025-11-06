import processing.sound.*;

int state = 0;

SceneLoading sceneLoading;
SceneMenu sceneMenu;
SceneKota sceneKota;
ScenePegunungan scenePegunungan;
ScenePantai scenePantai;

void setup() {
  size(800, 600, P3D); 
  
  sceneLoading = new SceneLoading();
  sceneMenu = new SceneMenu();
  
  sceneKota = new SceneKota(this);
  scenePegunungan = new ScenePegunungan(this);
  scenePantai = new ScenePantai(this);
}

void draw() {
  switch(state) {
    case 0:
      sceneLoading.tampilkan();
      break;
    case 1:
      sceneMenu.tampilkan();
      break;
    case 2:
      sceneKota.tampilkan();
      break;
    case 3:
      scenePegunungan.tampilkan();
      break;
    case 4:
      scenePantai.tampilkan();
      break;
  }
}

void keyPressed() {
  if (key == 'm' || key == 'M') {
    if (state == 2 || state == 3 || state == 4) {
      sceneKota.stopMusic();
      scenePegunungan.stopMusic();
      scenePantai.stopMusic();
      
      state = 1; 
    }
  }
}

void mousePressed() {
  if (state == 1) {
    sceneMenu.handleMouseClick();
  }
}

void goToScene(int newState) {
  state = newState;
  
  sceneKota.stopMusic();
  scenePegunungan.stopMusic();
  scenePantai.stopMusic();
  if (state == 2) sceneKota.playMusic();
  if (state == 3) scenePegunungan.playMusic();
  if (state == 4) scenePantai.playMusic();
}
