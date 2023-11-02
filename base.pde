float deltaTime = 1/60; // no es necesario si se ejecuta desde el draw
float gravity = .3;

ArrayList<Object> objects = new ArrayList<Object>();
Circle circle1 = new Circle(new float[] {200, 19}, new float[] {5, 0}, 20, new float[] {0, gravity});
Circle circle2 = new Circle(new float[] {600, 100}, new float[] {-5, 0}, 20, new float[] {0, gravity});
Circle circle3 = new Circle(new float[] {20, 50}, new float[] {5, 0}, 20, new float[] {0, gravity});
Circle circle4 = new Circle(new float[] {400, 75}, new float[] {5, 0}, 20, new float[] {0, gravity});
Circle circle5 = new Circle(new float[] {100, 60}, new float[] {5, 0}, 20, new float[] {0, gravity});
//Circle circle1 = new Circle(new float[] {480, 30}, new float[] {5, 0}, 10, new float[] {0, gravity});

void setup(){
  size(700, 500);
}

void draw(){
  background(255);
  
  fill(255, 0, 0);
  circle1.Update();
  fill(0, 255, 0);
  circle2.Update();
  circle3.Update();
  circle4.Update();
  circle5.Update();
  //circle1.Update();
  
  detectCollisions();
}

interface Object{
  float[] pos();
  ArrayList<float[]> getCols();
  void colDetected(int[] colMap);
  float r();
  float[] v();
}

class Square implements Object{
  float[] pos = new float[2];
  float[] vel = new float[2];
  float _height;
  float[] a = new float[2];
  
  Col collision;
  
  Square(float[] _pos, float[] _speed, int h, float[] _a){
    pos = _pos;
    vel = _speed;
    _height = h;
    a = _a;
    
    collision = new RectCol(h, h, pos);
    
    objects.add(this);
  }
  
  void Update(){
    vel[0] += a[0];
    vel[1] += a[1];
    
    pos[0] += vel[0];
    pos[1] += vel[1];
    
    collision.Update(pos);
    
    square(pos[0]-_height/2, pos[1]-_height/2, _height);
  }
  
  float[] pos(){
    return pos;
  }
  
  ArrayList<float[]> getCols(){
    return collision.Collisions();
  }
  
  float r(){
    return _height/2;
  }
  
  float[] v(){
    return vel;
  }
  
  void colDetected(int[] colMap){
    if(colMap[0] == 1) vel[0] = -vel[0]; //right or left
    if(colMap[1] == 1) vel[1] = -vel[1]; //up or down
  }
}

class Circle implements Object{
  float[] pos = new float[2];
  float[] vel = new float[2];
  float r;
  float[] a = new float[2];
  
  Col collision;
  
  Circle(float[] _pos, float[] _speed, int _r, float[] _a){
    pos = _pos;
    vel = _speed;
    r = _r;
    a = _a;
    
    collision = new CircleCol(10, new float[] {100, 30});
    
    objects.add(this);
  }
  
  void Update(){
    vel[0] += a[0];
    vel[1] += a[1];
    
    pos[0] += vel[0];
    pos[1] += vel[1];
    
    collision.Update(pos);
    
    circle(pos[0], pos[1], r);
  }
  
  float[] pos(){
    return pos;
  }
  
  ArrayList<float[]> getCols(){
    return collision.Collisions();
  }
  
  float r(){
    return r;
  }
  
  float[] v(){
    return vel;
  }
  
  void colDetected(int[] colMap){
    if(colMap[0] == 1) vel[0] = -vel[0]; //right or left
    if(colMap[1] == 1) vel[1] = -vel[1]; //up or down
  }
}
