String filename = "";



float  [] average = new float [100];

int [] count = new int [100];

void setup(){
  size(1500, 1500);
  background(255);
  int A = 350; //350,700
  int W = 21; //21
  int I = 10000; //0,42,10000
  int S = 1; //0,1
  int C = 5; //0,2,5
  for(int participant = 1; participant < 14; participant++){
    if(participant != 5){
    for(int i = 0; i < 168; i++){
      for(int j = 0; j < 6; j++){
        drawVelocity(participant, i, j, A, W, I, S, C);
      }
    }
    }
  }
  
  float max = 0;
  int maxi = 0;
  
  for(int i = 0; i < 100; i++){
    average[i] = average[i]/count[i];
    if(average[i] > max){
      max = average[i];
      maxi = i;
    }
  }
  
  for(int i = 0; i < 100; i++){
    println(average[i] + "," + count[i]);
  }
  
  println("max = " + str(max));
  println("maxi = " + str(maxi));
  
  float lastAverage = 0;
  
  for(int i = 0; i < 100; i++){
    stroke(0,0,255);
    strokeWeight(5);
    line(i*15, 1500-lastAverage*50, (i+1)*15, 1500-average[i]*50);
    lastAverage = average[i];
  }
  
  save("A" +A+"_W"+W+ "_I"+ I + "_S"+ S + "_C" + C +".png");
  
}

void drawVelocity(int participant, int set, int task, int A, int W, int I, int S, int C){
  filename = str(participant)+ "/" +str(participant) + "_" + str(set) + "_" + str(task) + ".txt";
  String [] lines = loadStrings(filename);
  float lastVelocity = 0;
  float psum = 0.0;
  
  String [] firstList = split(lines[0], ",");
  if(int(firstList[1]) != A || int(firstList[2]) != W || int(firstList[3]) != I || int(firstList[4]) != S || int(firstList[5]) != C){
    return;
  }
  String [] endList = split(lines[lines.length-1], ",");
  
  if(int(endList[11]) == 1 || int(endList[14]) == 1){
    return;
  }
  
  int mt = int(endList[6])-int(firstList[6]);
  float ppms = 100.0/mt;  
  
  for(int k = 1; k < lines.length - 1; k++){
    String [] lastList = split(lines[k-1], ",");
    String [] list = split(lines[k], ",");
    
    float distance = sqrt(pow(float(list[9]) - float(lastList[9]),2) + pow(float(list[10]) - float(lastList[10]),2));
    int ms = int(list[6])-int(lastList[6]);
    
    float v = distance/ms;
    
    float thisP = ppms * ms;
    
    average[int(psum+thisP)] = average[int(psum+thisP)] + v;
    count[int(psum+thisP)]++;
    
    stroke(255,0,0);
    line(psum*15, 1500-lastVelocity*50, psum*15+thisP*15, 1500-v*50);
    
    psum += thisP;
    lastVelocity = v;
    
  }
}
