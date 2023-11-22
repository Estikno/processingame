String[] levels = { "1.txt","2.txt", "3.txt", "4.txt", "5.txt"};
int actualLevel = 0;
ArrayList<ArrayList<float[]>> levelsInfo = new ArrayList<ArrayList<float[]>>();
boolean levelGenerated = false;
boolean hasWon = false;

void loadAllLevels(){
  for(int i=0;i<levels.length;i++){
    String[] levelRaw = loadStrings(levels[i]);
    ArrayList<float[]> nowLevel = new ArrayList<float[]>(); 
    
    for(int a = 0; a < levelRaw.length; a++){
      if(a == 0){
        float x = float(levelRaw[a].split(",")[0]);
        float y = float(levelRaw[a].split(",")[1]);
        
        nowLevel.add(new float[] {x, y});
        
        continue;
      }
      
      float x = int(levelRaw[a].split(",")[0]);
      float y = int(levelRaw[a].split(",")[1]);
      float w = int(levelRaw[a].split(",")[2]);
      float h = int(levelRaw[a].split(",")[3]);
      
      nowLevel.add(new float[] {x, y, w, h});
    }
    
    levelsInfo.add(nowLevel);
  }
}

void generateLevel(int level){
  objects = new ArrayList<Object>();
  ArrayList<float[]> actualLevel = new ArrayList<float[]>(levelsInfo.get(level));
  
  if(ball != null) ball = null;
  
  for(int i = 0; i < actualLevel.size(); i++){
    
    if(i==0){ //personaje
      fill(255, 0, 0);
      circle(actualLevel.get(i)[0], actualLevel.get(i)[1], 20);
      
      initialBall[0] = actualLevel.get(i)[0];
      initialBall[1] = actualLevel.get(i)[1];
      
      continue;
    }
    
    if(i==1){ //meta
      new Rectangle(new float[] {actualLevel.get(i)[0], actualLevel.get(i)[1]}, actualLevel.get(i)[2], actualLevel.get(i)[3], true);
      continue;
    }
    
    //rect(actualLevel.get(i)[0], actualLevel.get(i)[1], actualLevel.get(i)[2], actualLevel.get(i)[3]);
    new Rectangle(new float[] {actualLevel.get(i)[0], actualLevel.get(i)[1]}, actualLevel.get(i)[2], actualLevel.get(i)[3], false);
  }
  
  canInteract = true;
}

void nextLevel(){
  if(actualLevel + 1 >= levels.length){
    victoryScreen();
    return;
  }
  
  actualLevel++;
  canInteract = true;
  levelGenerated = false;
}

void victoryScreen(){
  hasWon = true;
}
