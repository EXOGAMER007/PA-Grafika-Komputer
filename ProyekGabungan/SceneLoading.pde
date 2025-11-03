class SceneLoading {
  
  int loading = 0;
  float perputaranX = 0;
  float perputaranY = 0;
  String text = "MEMUAT...";

  SceneLoading() {
  }

  void tampilkan() {
    background(100, 150, 200);
    
    kotak();
    loadingBar();
  }

  void kotak() {
    pushMatrix();
    
    translate(width/2, height/2-130, 10);
    rotateY(perputaranX);
    rotateZ(perputaranY);
    
    fill(50, 80, 120);
    box(160);
    
    perputaranY += 0.05;
    perputaranX += 0.05;
    
    popMatrix();
    noFill();
  }

  void loadingBar() { 
    pushMatrix();
    translate(0, 0, 10);
    
    rect(width/2-200, height/2+50, 410, 40);
    loadingFill();
    pushMatrix();
    translate(0, 0, 30);
    textSize(20);
    fill(0);
    text(text, width/2-35, height/2+73);
    popMatrix();
    
    popMatrix();
  }

  void loadingFill() {
    pushMatrix();
    translate(10, 2, 20); 
    noStroke();
    fill(50, 80, 120);
    
    rect(width/2-200, height/2+50, loading, 30);
    if (loading < 388) {
      loading += 2;
    } else {
      state = 1; 
    }
    
    popMatrix();
    noFill();
    stroke(1);
  }
}
