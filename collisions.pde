void detectCollisions() {
  //detectar paredes
  
  if(ball == null) return;
  
  float[] v0 = ball.v();
  float[] pos = ball.pos();
  float x0 = pos[0];
  float y0 = pos[1];
  float r = ball.r();
    
  float y = pos[1] + v0[1]*.5 + .5*gravity*.75;
  float x = pos[0] + v0[0]*.5;
    
  if(x-r-collisionOffset <= 0 || x+r+collisionOffset >= width){
    ball.colDetected(new int[] {1, 0});
    return;
  }
    
  if(y+r+collisionOffset >= height || y-r-collisionOffset <= 0){
    ball.colDetected(new int[] {0, 1});
    return;
  }
  
  for(int i = 0; i < objects.size(); i++){
    Object o = objects.get(i);
    float[] rectPos = o.pos();
    //ArrayList<float[]> cols = o.getCols();
    
    float testX = x;
    float testY = y;
    
    if(x < rectPos[0]) testX = rectPos[0]; //left
    else if (x > rectPos[0] + o._width()) testX = rectPos[0] + o._width();
    
    if(y < rectPos[1]) testY = rectPos[1];
    else if(y > rectPos[1] + o._height()) testY = rectPos[1] + o._height();
    
    float distanceX = x - testX + collisionOffset;
    float distanceY = y - testY + collisionOffset;
    
    circle(testX, testY, 10);
    
    float distance = sqrt(distanceX*distanceX + distanceY*distanceY);
    
    if(distance < r){ //collision
      if(testX == x) ball.colDetected(new int[] {0, 1});
      if(testY == y) ball.colDetected(new int[] {1, 0});
      if(o.isMeta()) print("you won");
    }
  }
}


interface Col{
  void Update(float[] _pos);
  ArrayList<float[]> Collisions();
}

class RectCol implements Col{
  float w, h;
  
  float[] pos = new float[2];
  
  float[] left = new float[2];
  float[] right = new float[2];
  float[] up = new float[2];
  float[] down = new float[2];
  
  RectCol(float _w, float _h, float[] _pos){
    pos = _pos;
    w = _w;
    h = _h;
    
    left = new float[] {pos[0], pos[1]+h/2};
    right = new float[] {pos[0] + w, pos[1]+h/2};
    up = new float[] {pos[0]+w/2, pos[1]};
    down = new float[] {pos[0]+w/2, pos[1] + h};
  }
  
  void Update(float[] _pos){
    pos = _pos;
    
    left = new float[] {pos[0], pos[1]+h/2};
    right = new float[] {pos[0] + w, pos[1]+h/2};
    up = new float[] {pos[0]+w/2, pos[1]};
    down = new float[] {pos[0]+w/2, pos[1] + h};
  }
  
  ArrayList<float[]> Collisions(){
    ArrayList<float[]> al = new ArrayList<float[]>();
    al.add(left);
    al.add(right);
    al.add(up);
    al.add(down);
    
    return al;
  }
}

//linear interpolation
float interpolation(float x0, float x1, float t){
  return t*x0 + (1-t) * x1;
}
