import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

float deltaTime = 1/60; // no es necesario si se ejecuta desde el draw
float gravity = .4;
float collisionOffset = .6;
ArrayList<Object> objects = new ArrayList<Object>();

Circle ball;
//Rectangle recto = new Rectangle(new float[] {250, 300}, 200, 100);

void setup(){
  size(1000, 600);
  
  //levels
  loadAllLevels();
  
  //audio
  se = new Minim(this);
}

void draw(){
  if(!levelGenerated){
    generateLevel(actualLevel);
    levelGenerated = true;
  }
  
  background(255);
  
  fill(255, 0, 0);
  if(levelGenerated) circle(initialBall[0], initialBall[1], 20);
  if(ball != null) ball.Update();
  
  detectCollisions();
  
  //if(valid) line(initialBall[0], initialBall[1], mousePos[0], mousePos[1]);
  if(interacting){
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
    
    ArrayList<float[]> trajectory = calculateTrajectory(initialBall[0], initialBall[1], vel);
    
    for(int i = 0; i < trajectory.size(); i++){
      if(i==0 || i==trajectory.size()-1) continue;
      
      line(trajectory.get(i-1)[0], trajectory.get(i-1)[1], trajectory.get(i)[0], trajectory.get(i)[1]);
    }
  }
  
  for(int i = 0; i < objects.size(); i++){
    objects.get(i).Update();
  }
}
