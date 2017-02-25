/*
Grid experiments, version 0.1
 Mr. Corica, 9/14/2016
 Displays grid (like a gameboard) with a marker on it.
 Aditi Kocherlakota, 9/15/16
 It's now a game called "Math Department Dash"! Try to beat Mr. Sawula to the processing icon.
 Use these keys:
 a- left
 s- down
 w- up
 d- right
 */

// grid dimensions

int numBlocksX = 10;// 10 x 10
int numBlocksY = 10;

int blockSize = 40;

// location of marker
int xLoc = 5;
int yLoc = 3;

int score = 0;



PImage img;
PImage sawula;
PImage processingicon;
float xEnemy = 0;
float enemySpeed = 0.029;
float yEnemySpeed = 1;
float yEnemy = 0;
void setup() {
  size(400, 400);
  img = loadImage("Coricaforgame.PNG");
  sawula = loadImage("SawulaforGrid_ProcessingAssignment.png");
  processingicon = loadImage("Processing_forGridAssignment.png");
}




//===========================================================


void draw() {
  background(200);
  drawGrid();

  // Draw marker
  fill(90, 250, 100);
  noStroke();
  ellipseMode(CENTER);
  //ellipse(20+xLoc*40, 20+yLoc*40, blockSize-2, blockSize-2);
  //image(img, 20+xLoc*40, 20+yLoc*40);

  img.resize(40, 40);

  image(img, xLoc*40, yLoc*40, img.width, img.height);

  text(score, 40, 80);
  textSize(100);
  fill(40);

  if (xLoc>9)
    xLoc--;
  if (yLoc>9)
    yLoc--;
  if (xLoc<0)
    xLoc++;
  if (yLoc<0)
    yLoc++;

  fill(255, 0, 0);   // Green
  noStroke();
  //ellipseMode(CENTER);
  xEnemy= xEnemy + enemySpeed;
  // ellipse(blockSize/2+int(xEnemy)*blockSize, blockSize/2+2*blockSize, blockSize-2, blockSize-2);
  image(processingicon, 7*blockSize, 4*blockSize, img.width, img.height);

  fill(0, 0, 0);  //Black 
  noStroke();
  //ellipseMode(CENTER);
  yEnemy = yEnemy + enemySpeed;
  //ellipse(blockSize/2+7*blockSize, blockSize/2+int(yEnemy)*blockSize, blockSize-2, blockSize-2);
  image(sawula, 7*blockSize, int(yEnemy)*blockSize, img.width, img.height);
  {
    if ( xLoc*40 ==7*blockSize && yLoc*40 == 4*blockSize)
    {
      score+=20;
      
    }
    
 
    

   if (score >=1) 
    {
      score = 20;
    }
    
   
   /* if (score<=-1) 
    {
      score = -30;
    }
    
    */
   
    

    if (blockSize/2+7*blockSize == blockSize/2+7*blockSize && blockSize/2+4*blockSize == blockSize/2+int(yEnemy)*blockSize)

    {
      score-=20;
    }
  }
}



void keyPressed()
{

  if (key == 'd') {

    xLoc++;
  }
  if (key == 'w') {
    yLoc--;
  }
  if (key == 'a') {
    xLoc--;
  }
  if (key == 's') {
    yLoc++;
  }
}





//============================================================

// Draws a rectangular grid on the screen
void drawGrid()
{
  noFill(); // Only the outline of each rectangle
  stroke(0); // black outline
  rectMode(CENTER);
  for (int x = 0; x < numBlocksX; x++)
  {
    for (int y = 0; y < numBlocksY; y++)
    {
      rect(20+x*40, 20+y*40, blockSize, blockSize);
    }
  }
}