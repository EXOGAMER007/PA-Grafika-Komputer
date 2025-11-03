class Langit {
  
  Langit() {
  }

  void tampilkan() {  
    // Background
    for (int i = 0; i < 300; i++) {
      float inter = map(i, 0, 300, 0, 1);
      int c = lerpColor(color(25, 25, 70), color(255, 140, 80), inter);
      stroke(c);
      line(0, i, width, i);
    }

    for (int i = 300; i < 500; i++) {
      float inter = map(i, 300, 500, 0, 1);
      int c = lerpColor(color(255, 140, 80), color(255, 100, 130), inter);
      stroke(c);
      line(0, i, width, i);
    }
    noStroke();
    
    pushMatrix();
    translate(0,0,10);
    // Matahari
    fill(255, 120, 80, 200);
    ellipse(100, 100, 180, 180);
    fill(255, 140, 100, 100);
    ellipse(100, 100, 240, 240); 
    popMatrix();
    
  }
}
