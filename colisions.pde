void detectCollisions(){
  //detectar paredes
  for(int i = 0; i < objects.size(); i++){
    Object o = objects.get(i);
    ArrayList<float[]> cols = o.getCols();
    float[] v0 = o.v();
    float[] pos0 = o.pos();
    float r = o.r();
    
    float y = pos0[1] + v0[1]*1.5 + .5*gravity*2.25;
    float x = pos0[0] + v0[0]*1;
    
    //pared de abajo
    float tc = (height - r - y)/(pos0[1]-y);
    //pared arriba
    float tc2 = (0 + r - y)/(pos0[1]-y);
    //pared derecha
    float tc3 = (width - r - x)/(pos0[0]-x);
    //pared izquierda
    float tc4 = (0 + r - x)/(pos0[0]-x);
    
    if(x <= 0 || x >= width){
      o.colDetected(new int[] {1, 0});
    }
    
    if(y >= height || y <= 0){
      o.colDetected(new int[] {0, 1});
    }
    
    /*if(tc < 1 && tc > 0){
      o.colDetected(new int[] {0, 1});
    }
    
    if(tc2 < 1 && tc2 > 0){
      o.colDetected(new int[] {0, 1});
    }
    
    if(tc3 <= 1 && tc3 >= 0){
      o.colDetected(new int[] {1, 0});
    }
    
    if(tc4 <= 1 && tc4 >= 0){
      o.colDetected(new int[] {1, 0});
    }*/
  }
  
  //agrupar en grupos de dos los objetos
  ArrayList<Object[]> groups = new ArrayList<Object[]>();
  for(int i = 0; i < objects.size(); i++){
    for(int a = i+1; a < objects.size(); a++){
      groups.add(new Object[] {objects.get(i), objects.get(a)});
    }
  }
  
  //detectar colisiones entre parejas
  for(int i = 0; i < groups.size(); i++){
    Object[] pareja = groups.get(i);
    ArrayList<float[]> cols1 = pareja[0].getCols();
    ArrayList<float[]> cols2 = pareja[1].getCols();
    
    float[] pos1 = pareja[0].pos();
    float[] pos2 = pareja[1].pos();
    
    float[] v1 = pareja[0].v();
    float[] v2 = pareja[0].v();
    
    float r1 = pareja[0].r();
    float r2 = pareja[1].r();
    
    float y1 = pos1[1] + v1[1] + .5*gravity;
    float x1 = pos1[0] + v1[0];
    
    float y2 = pos2[1] + v2[1] + .5*gravity;
    float x2 = pos2[0] + v2[0];
    
    float d = dist(x1, y1, x2, y2);
   
    //abajo
    float tc = (y2-r2/2 - r1 - y1)/(pos1[1]-y1);
    //arriba
    float tc2 = (y2+r2/2 + r1 - y1)/(pos1[1]-y1);
    //derecha
    float tc3 = (x2-r2/2 - r1 - x1)/(pos1[0]-x1);
    //izquierda
    float tc4 = (x2+r2/2 + r1 - x1)/(pos1[0]-x1);
    
    if((x1-r1/2 <= x2+r2/2) && (d <= r1 + r2)) {
      pareja[0].colDetected(new int[] {1, 0});
      pareja[1].colDetected(new int[] {1, 0});
    } //colision en la izquierda
    else if((x1+r1/2 >= x2-r2/2) && (d <= r1 + r2)){
      pareja[0].colDetected(new int[] {1, 0});
      pareja[1].colDetected(new int[] {1, 0});
    } //colision en la derecha
    else if((y1-r1/2 <= y2+r2/2) && (d <= r1 + r2)){
      pareja[0].colDetected(new int[] {0, 1});
      pareja[1].colDetected(new int[] {0, 1});
    } //colision en la arriba
    else if((y1+r1/2 >= y2-r2/2) && (d <= r1 + r2)){
      pareja[0].colDetected(new int[] {0, 1});
      pareja[1].colDetected(new int[] {0, 1});
    } //colision en la abajo
    
    /*if((tc < 1 && tc > 0) && (abs(x1-x2) <= r1+r2+30)){
      pareja[0].colDetected(new int[] {0, 1});
      pareja[1].colDetected(new int[] {0, 1});
      continue;
    }
    
    if((tc2 < 1 && tc2 > 0) && (abs(x1-x2) <= r1+r2+30)){
      pareja[0].colDetected(new int[] {0, 1});
      pareja[1].colDetected(new int[] {0, 1});
      continue;
    }
    
    if((tc3 <= 1 && tc3 >= 0) && (abs(y1-y2) <= r1+r2+30)){
      pareja[0].colDetected(new int[] {1, 0});
      pareja[1].colDetected(new int[] {1, 0});
      continue;
    }
    
    if((tc4 <= 1 && tc4 >= 0) && (abs(y1-y2) <= r1+r2+30)){
      pareja[0].colDetected(new int[] {1, 0});
      pareja[1].colDetected(new int[] {1, 0});
      continue;
    }*/
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
    
    left = new float[] {pos[0], (pos[1] + h/2)};
    right = new float[] {pos[0] + w, (pos[1] + w/2)};
    up = new float[] {(pos[0] + w/2), pos[1]};
    down = new float[] {(pos[0] + w/2), (pos[1] + h/2)};
  }
  
  void Update(float[] _pos){
    pos = _pos;
    
    left = new float[] {pos[0] - w/2, pos[1]};
    right = new float[] {pos[0] + w/2, pos[1]};
    up = new float[] {pos[0], pos[1]-h/2};
    down = new float[] {pos[0], pos[1] + h/2};
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

class CircleCol implements Col{
  float r;
  
  float[] pos = new float[2];
  
  float[] left = new float[2];
  float[] right = new float[2];
  float[] up = new float[2];
  float[] down = new float[2];
  
  CircleCol(float _r, float[] _pos){
    pos = _pos;
    r = _r;
    
    left = new float[] {pos[0] - r, pos[1]};
    right = new float[] {pos[0] + r, pos[1]};
    up = new float[] {pos[0], pos[1] - r};
    down = new float[] {pos[0], pos[1] + r};
  }
  
  void Update(float[] _pos){
    pos = _pos;
    
    left = new float[] {pos[0] - r, pos[1]};
    right = new float[] {pos[0] + r, pos[1]};
    up = new float[] {pos[0], pos[1] - r};
    down = new float[] {pos[0], pos[1] + r};
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
