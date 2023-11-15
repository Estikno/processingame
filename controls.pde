float shootIntensity = .05;
float[] mousePos = new float[2];
boolean valid = false;

void mousePressed(){
  float dX = mouseX - 200;
  float dY = mouseY - 400;
  
  float distance = sqrt(dX*dX + dY*dY);
  
  if(distance < 40) valid = true;
  else valid = false;
}

void mouseReleased(){
  mousePos[0] = mouseX;
  mousePos[1] = mouseY;
  
  if(valid){
    float[] dir = {mouseX-200, mouseY-400};
    float[] vel = {dir[0]*shootIntensity, dir[1]*shootIntensity};
    
    ball = new Circle(new float[] {200, 400}, vel, 20, new float[] {0, gravity});
    
    printArray(dir);
  }
}
