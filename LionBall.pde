float deltaTime = 1/60; // no es necesario si se ejecuta desde el draw
float gravity = .4;
float collisionOffset = .6;
ArrayList<Object> objects = new ArrayList<Object>();

Circle ball;
//Rectangle recto = new Rectangle(new float[] {250, 300}, 200, 100);

void setup(){
  //loadAllLevels();
  size(1000, 600);
}

void draw(){
  background(255);
  
  fill(255, 0, 0);
  if(ball != null) ball.Update();
  fill(0, 255, 0);
  //recto.Update();
  
  circle(200, 400, 40);
  
  detectCollisions();
  
  if(valid) line(200, 400, mousePos[0], mousePos[1]);
}
