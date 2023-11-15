float shootIntensity = .04;
float[] mousePos = new float[2];
boolean valid = false;
float[] initialBall = new float[2];
boolean canInteract = false;
boolean interacting = false;

void mousePressed(){
  if(!canInteract) return;
  interacting = true;
  
  float dX = mouseX - initialBall[0];
  float dY = mouseY - initialBall[1];
  
  float distance = sqrt(dX*dX + dY*dY);
  
  if(distance < 20) valid = true;
  else valid = false;
}

void mouseReleased(){
  mousePos[0] = mouseX;
  mousePos[1] = mouseY;
  
  if(valid){
    float[] dir = {mouseX-initialBall[0], mouseY-initialBall[1]};
    float[] vel = {dir[0]*shootIntensity, dir[1]*shootIntensity};
    
    ball = new Circle(new float[] {initialBall[0], initialBall[1]}, vel, 20, new float[] {0, gravity});
    interacting = false;
    
    printArray(dir);
  }
}

ArrayList<float[]> calculateTrajectory(float posx0, float posy0, float[] v0){
  ArrayList<float[]> points = new ArrayList<float[]>();
  
  if(v0[0] > 0){ //velocidad hacia la derecha
    for(float x = posx0; x < posx0+300; x++){
      float tn = t(x, posx0, v0[0]);
      float y = posy0+v0[1]*tn+.5*gravity*(tn*tn);
      points.add(new float[] {x, y});
    }
  }
  else{ //hacia la izquierda
    for(float x = posx0; x > posx0-300; x--){
      float tn = t(x, posx0, v0[0]);
      float y = posy0+v0[1]*tn+.5*gravity*(tn*tn);
      points.add(new float[] {x, y});
    }
  }
  
  return points;
}

float t(float x, float x0, float vx0){
  return (x-x0)/vx0;
}
