String[] levels = {"1.txt", "2.txt", "3.txt", "4.txt", "5.txt"};
int actualLevel = 0;
ArrayList<ArrayList<float[]>> levelsInfo = new ArrayList<ArrayList<float[]>>();

void loadAllLevels(){
  for(int i=0;i<5;i++){
    String[] levelRaw = loadStrings(levels[i]);
    ArrayList<float[]> nowLevel = new ArrayList<float[]>(); 
    
    for(int a = 0; a < levelRaw.length; a++){
      if(a == 0){
        float x = float(levelRaw[a].split(",")[0]);
        float y = float(levelRaw[a].split(",")[1]);
        
        nowLevel.add(new float[] {x, y});
      }
      
      float x = float(levelRaw[a].split(",")[0]);
      float y = float(levelRaw[a].split(",")[1]);
      float w = float(levelRaw[a].split(",")[2]);
      float h = float(levelRaw[a].split(",")[3]);
      
      nowLevel.add(new float[] {x, y, w, h});
    }
    
    levelsInfo.add(nowLevel);
  }
}

void generateLevel(int level){
  ArrayList<float[]> actualLevel = new ArrayList<float[]>(levelsInfo.get(level));
  
  for(int i = 0; i < actualLevel.size(); i++){
    fill(0, 0, 255);
    
    if(i==0){
      fill(255, 0, 0);
      circle(actualLevel.get(i)[0], actualLevel.get(i)[1], 30);
    }
    
    if(i==1){
      fill(0, 255, 0);
    }
    
    rect(actualLevel.get(i)[0], actualLevel.get(i)[1], actualLevel.get(i)[2], actualLevel.get(i)[3]);
  }
}
