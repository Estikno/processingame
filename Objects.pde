interface Object{
  float[] pos();
  ArrayList<float[]> getCols();
  float _width();
  float _height();
  boolean isMeta();
  void Update();
}

/*class Meta extends Rectangle {
  Meta(float[] _pos, int _w, int _h){
    super(_pos, _w, _h);
  }
  
  void colDetected(){
    actualLevel++;
  }
  
  boolean isMeta(){
    return true;
  }
}*/

class Rectangle implements Object{
  float[] pos = new float[2];
  float w;
  float h;
  boolean m;
  
  Col collision;
  
  Rectangle(float[] _pos, float _w, float _h, boolean isM){
    pos = _pos;
    h = _h;
    w = _w;
    m = isM;
    
    collision = new RectCol(w, h, pos);
    
    objects.add(this);
  }
  
  void Update(){
    collision.Update(pos);
    
    if(m) fill(0, 255, 0);
    else fill(0, 0, 255);
    
    rect(pos[0], pos[1], w, h);
  }
  
  float[] pos(){
    return pos;
  }
  
  ArrayList<float[]> getCols(){
    return collision.Collisions();
  }
  
  float _width(){
    return w;
  }
  
  float _height(){
    return h;
  }
  
  boolean isMeta(){
    return m;
  }
}

class Circle{
  float[] pos = new float[2];
  float[] vel = new float[2];
  float r;
  float[] a = new float[2];
  
  Circle(float[] _pos, float[] _speed, int _r, float[] _a){
    pos = _pos;
    vel = _speed;
    r = _r;
    a = _a;
    
    //objects.add(this);
  }
  
  void Update(){
    vel[0] += a[0];
    vel[1] += a[1];
    
    pos[0] += vel[0];
    pos[1] += vel[1];
    
    circle(pos[0], pos[1], r);
  }
  
  float[] pos(){
    return pos;
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
