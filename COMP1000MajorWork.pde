
//player variables
int headX;
int headY;
int headSize;
int playerCOMX;
int playerCOMY;
int bodyX;
int bodyY;
int fatness;
int tallness;
int armLeftX;
int armLeftY;
int thickness;
int armLength;
int armRightX;
int armRightY;

int [][] peds = new int [6][3];
float [][] coke = new float [3][3];
boolean collision=true;
boolean controlscollision=false; //<>// //<>//
//wally's walk variables
int counter=0;
int roadBlockY; 
float [][] tree1 = new float [3][5];
float [][] tree2 = new float [3][5];


void setup () { //<>//
  size(400,600);
  playerCOMX = width/2;
  playerCOMY = height*7/8;
  frameRate=60;
  for (int i=0; i<peds.length; i++) {
    peds[i][1]=int (random(width/5,width*4/5));
    peds[i][2]=int(random(1,30))-50;
    peds[i][0]=int(random(2,6));
  }
  for (int i=0; i<coke.length; i++) {
    coke[i][1]=random(width/5,width*4/5);
    coke[i][2]=random(1,30)-50;
    coke[i][0]=5;
  }
 for(int i=0;i<tree1.length;i++){
    tree1[i][1]=random(10,width/5+20);
    tree1[i][2]=height/3*i;
    tree1[i][0]=random(1,2);
    tree1[i][3]=random(1,4);
    tree1[i][4]=random(10,20);
    drawTree(tree1[i][1],tree1[i][2],tree1[i][0],int(tree1[i][3]),tree1[i][4]);
  }
  for(int i=0;i<tree2.length;i++){
    tree2[i][1]=random(width*4/5+10,width-20);
    tree2[i][2]=height/3*i;
    tree2[i][0]=random(1,2);
    tree2[i][3]=random(1,4);
    tree2[i][4]=random(10,20);
    drawTree(tree2[i][1],tree2[i][2],tree2[i][0],int(tree2[i][3]),tree2[i][4]);
  }
  fill(255);
}

void draw () {
  rectMode(CENTER);
  //wally's walk
   
   for(int i=0;i<peds.length;i++){
     if(dist(playerCOMX,playerCOMY,peds[i][1],peds[i][2])>=40){

       wallywest();
     } else {
       counter=0;
     }
   }
    counter--;
  rectMode(CORNER);
  fill(0,150,0);
  rect(0,0,width/5,height);
  rect(width*4/5,0,width,height);
  fill(0,150,0);
  
  //coke
  fill(150,0,0);
  
  for(int k=0;k<coke.length;k++){
    if(dist(playerCOMX,playerCOMY,coke[k][1],coke[k][2])<=40){
     coke[k][2]=random(1,20)-50;
     coke[k][1]=random(width/5, width*4/5);
     coke[k][0]=10;
    }
  }
  for(int i=0;i<coke.length;i++){
    cokebody(coke[i][1],coke[i][2]);
  }
  cokemover();
  if(controlscollision==false){
   for(int i=0;i<coke.length;i++){
    coke[i][2]++;
    } 
  }
  
  
  //pedestrian
  for(int i=0;i<peds.length;i++){
    pedestrian(peds[i][1],peds[i][2]);
  }
  pedestrianmover();
  for(int j=0;j<peds.length;j++){
    peds[j][2]+=peds[j][0];
  }
  for(int i=0;i<peds.length;i++){
     if(dist(playerCOMX,playerCOMY,peds[i][1],peds[i][2])<=40){
       for(int j=0;j<peds.length;j++){
         peds[j][0]=0;
       }
     }
  } 

  //player/NPC design
  rectMode(CENTER);
  strokeWeight(3);
  fill(255);
  rectMode(CORNER);
  
  rectMode(CENTER);
  //player
  //head
  fill(255);
  headX=playerCOMX;
  headY=playerCOMY-30;
  headSize=20; 
  circle(headX,headY,headSize);
  //body 
  bodyX=playerCOMX;
  bodyY=playerCOMY;
  fatness=20;
  tallness=35;
  rect(bodyX,bodyY,fatness,tallness); //<>//
  //arms
  armLeftX=playerCOMX-15;
  armLeftY=playerCOMY;
  thickness=10; //<>//
  armLength=25;
  rect(armLeftX,armLeftY,thickness,armLength);
  armRightX=playerCOMX+15;
  armRightY=playerCOMY;
  thickness=10; //<>//
  armLength=25;
  rect(armRightX,armRightY,thickness,armLength); //<>//
  
  if(controlscollision==true){
    gameOverScreen();
  }
  fill(255);
  for(int i=0;i<peds.length;i++){
     if(dist(playerCOMX,playerCOMY,peds[i][1],peds[i][2])<40){
        controlscollision=true;
     }
  }
  for(int i=0;i<tree1.length;i++){
      drawTree(tree1[i][1],tree1[i][2],tree1[i][0],int(tree1[i][3]),tree1[i][4]);
      if(controlscollision==false){
        tree1[i][2]++;
       }
      
    }
  
  
   
  
  for(int i=0;i<tree1.length;i++){
    if(tree1[i][2]>=height+30){
      tree1[i][1]=random(0,width/5+20);
      tree1[i][0]=random(1,2);
      tree1[i][3]=random(1,4);
      tree1[i][4]=random(10,20);
      tree1[i][2]=0;
      drawTree(tree1[i][1],tree1[i][2],tree1[i][0],int(tree1[i][3]),tree1[i][4]);
    }
  }
  
  
  for(int i=0;i<tree2.length;i++){
      drawTree(tree2[i][1],tree2[i][2],tree2[i][0],int(tree2[i][3]),tree2[i][4]);
      if(controlscollision==false){
        tree2[i][2]++;
       }
      
    }
   
  
  for(int i=0;i<tree2.length;i++){
    if(tree2[i][2]>=height+30){
      tree2[i][1]=random(width*4/5,width-20);
      tree2[i][0]=random(1,2);
      tree2[i][3]=random(1,4);
      tree2[i][4]=random(10,20);
      tree2[i][2]=0;
      drawTree(tree2[i][1],tree2[i][2],tree2[i][0],int(tree2[i][3]),tree2[i][4]);
    }
  }
  fill(255);
}
void keyPressed () {
  if(controlscollision==false) {
    if (key==119 && playerCOMY>0) {
     playerCOMY=playerCOMY-10; 
    } else if (key==97 && playerCOMX>width/5) {
     playerCOMX=playerCOMX-10; 
    } else if (key==115 && playerCOMY<height) {
     playerCOMY=playerCOMY+10; 
    } else if (key==100 && playerCOMX<width*4/5) {
     playerCOMX=playerCOMX+10; 
    } else {}
  } else {
    return;
    } 
  }

void wallywest(){
  rectMode(CORNER);
    int roadStart;
    int roadEnd;
    int roadWidth;
    int roadBlockWidth;
    int roadBlockX;
    int roadBlockYcounted = height-counter;
    roadStart=width/5;
   roadEnd=width*4/5;
   roadWidth=roadEnd-roadStart;
   roadBlockWidth=roadWidth/5;
   roadBlockX=roadStart;
      for(int roadBlockY=height;roadBlockY>0;roadBlockY-=height/roadBlockWidth){
        for(int i=0;i<5;i++){
          square(roadBlockX,roadBlockYcounted,roadBlockWidth);
          roadBlockX+=roadBlockWidth;
      }
        roadBlockX=roadStart;
        roadBlockYcounted-=roadBlockWidth;
    }
}

void pedestrianmover() {
  for (int i=0; i<peds.length; i++) {
    if (peds[i][2]>=height+20) {
      peds[i][2]=0;
      peds[i][1]=int (random(width/5, width*4/5));
      peds[i][0]=int(random(2,6));
    }
  }
}

void pedestrian(int x, int y) {
  rectMode(CENTER);
  fill(200,0,0);
  int pedCOMX=x;
  int pedCOMY=y;
  int pedHeadPoint1X;
  int pedHeadPoint2X;
  int pedHeadPoint3X;
  int pedHeadPoint1Y;
  int pedHeadPoint2Y;
  int pedHeadPoint3Y;
  int pedArmLeftX;
  int pedArmLeftY;
  int pedArmRightX;
  int pedArmRightY;
  int pedBodyX;
  int pedBodyY;
  int fatness;
  int tallness;
  int thickness;
  int armLength;
  pedHeadPoint1X=pedCOMX;
  pedHeadPoint2X=pedCOMX-15;
  pedHeadPoint3X=pedCOMX+15;
  pedHeadPoint1Y=pedCOMY-40;
  pedHeadPoint2Y=pedCOMY-20;
  pedHeadPoint3Y=pedCOMY-20;
  triangle(pedHeadPoint1X, pedHeadPoint1Y, pedHeadPoint2X, pedHeadPoint2Y, pedHeadPoint3X, pedHeadPoint3Y);
  //body
  pedBodyX=pedCOMX;
  pedBodyY=pedCOMY;
  fatness=20;
  tallness=35;
  rect(pedBodyX, pedBodyY, fatness, tallness);
  //arms
  pedArmLeftX=pedCOMX-15;
  pedArmLeftY=pedCOMY;
  thickness=10;
  armLength=25;
  rect(pedArmLeftX, pedArmLeftY, thickness, armLength);
  pedArmRightX=pedCOMX+15;
  pedArmRightY=pedCOMY;
  thickness=10;
  armLength=25;
  rect(pedArmRightX, pedArmRightY, thickness, armLength);
}

void cokemover() {
  for (int i=0; i<coke.length; i++) {
    if (coke[i][2]>=height+30) {
      coke[i][2]=random(1,20)-50;
      coke[i][1]=random(width/5, width*4/5);
      coke[i][0]=10;
    }
  }
}

void cokebody(float x, float y) {
  float cokeCOMX=x;
  float cokeCOMY=y;
  ellipse(cokeCOMX,cokeCOMY,20,40);
  fill(255,0,0);
}

void gameOverScreen () {
  fill(155);
  textSize(40);
  textAlign(CENTER);
  text("GET GOOD",width/2,height/2);
}

void drawTree(float x, float y, float scale, int bulbs, float radius){
  float treeCOMX=x;
  float treeCOMY=y;
  rectMode(CENTER);
  fill(#7B3F00);
  rect(treeCOMX,treeCOMY,10*scale,20*scale);
  fill(#7FFFD4);
  circle(treeCOMX,treeCOMY-30,3*radius);
  if (bulbs==2){
    circle(treeCOMX,treeCOMY-30,2*radius);
  } else if (bulbs>=3){
    circle(treeCOMX,treeCOMY-30,1*radius);
  } else {
  return;
  }
}
