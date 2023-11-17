float shootIntensity = .04;
float[] mousePos = new float[2];
boolean valid = false;
float[] initialBall = new float[2];
boolean canInteract = false;
boolean interacting = false;
float[] maxVel = {10, 20};

void mousePressed(){
  if(!canInteract) return;
  
  float dX = mouseX - initialBall[0];
  float dY = mouseY - initialBall[1];
  
  float distance = sqrt(dX*dX + dY*dY);
  
  if(distance < 20){
    valid = true;
    interacting = true;
  }
  else valid = false;
}

void mouseReleased(){
  mousePos[0] = mouseX;
  mousePos[1] = mouseY;
  
  if(valid && canInteract){
    float[] dir = {mouseX-initialBall[0], mouseY-initialBall[1]};
    float[] vel = {dir[0]*shootIntensity, dir[1]*shootIntensity};
    
    if(abs(vel[0]) > maxVel[0]){
      if(vel[0] >= 0) vel[0] = maxVel[0];
      else if(vel[0] < 0) vel[0] = -maxVel[0];
    }
    
    if(abs(vel[1]) > maxVel[1]){
      if(vel[1] >= 0) vel[1] = maxVel[1];
      else if(vel[1] < 0) vel[1] = -maxVel[1];
    }
    
    printArray(vel);
    
    ball = new Circle(new float[] {initialBall[0], initialBall[1]}, vel, 20, new float[] {0, gravity});
    interacting = false;
    canInteract = false;
  }
}

void keyPressed(){
  if(key=='r'){
    generateLevel(actualLevel);
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
