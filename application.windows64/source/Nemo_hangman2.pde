//String [] wordBank; // list ofpossible secret words
String [][] drawLetter; // holds the letters of the secret word and t/f if already guessed
// Maybe use parallel arrays?

String word;  // secret word

String incorrect = "";  // BAD GUESSES. "SET"
String checkCorrect = "";

final int RUNNING = 0;
final int ENDSCREEN = 1;
int gameState = RUNNING;  // 0 = running, 1 = endscreen
int numFish = 6;
PImage[] fish = new PImage[numFish];  // document it....
PImage Darla;
PImage tank;
PImage dentist;
Fish [] fList = new Fish[numFish];
Animation endDisplay;

void setup()
{
  size(650, 600);
  frameRate(60);

  String [] wordBank = loadStrings("desserts.txt");
  word = wordBank[(int)random(wordBank.length)];
  drawLetter = new String[word.length()][2];
  for (int i = 0; i < word.length(); i++)
  {
    drawLetter[i][0] = word.charAt(i)+"";
     print(drawLetter[i][0]);
    drawLetter[i][1] = "F";
    checkCorrect = checkCorrect + "T";
    if (drawLetter[i][0].equals(" "))
      drawLetter[i][1] = "T";
  }
  fish[0] = loadImage("Nemo.png");
  fish[0].resize(80, 80);
  fList[0] = new Fish(fish[0]);

  fish[1] = loadImage("Dory.png");
  fish[1].resize(80, 80);
  fList[1] = new Fish(fish[1]);
  fish[2] = loadImage("Bloat.png");
  fish[2].resize(80, 80);
  fList[2] = new Fish(fish[2]);
  fish[3] = loadImage("Peach.png");
  fish[3].resize(80, 80);
  fList[3] = new Fish(fish[3]);
  fish[4] = loadImage("Jacques.png");
  fish[4].resize(80, 80);
  fList[4] = new Fish(fish[4]);
  fish[5] = loadImage("Sheldon.png");
  fish[5].resize(80, 80);
  fList[5] = new Fish(fish[5]);
  Darla = loadImage("Darla.jpg");
  Darla.resize(650, 400);
  tank = loadImage("tank.png");
  tank.resize(350, 350);
  dentist = loadImage("dentist.jpg");
  dentist.resize(650, 600);
  endDisplay = new Animation("now_what", 18);
}

void draw()
{
  //scale(2);
  if (gameState == RUNNING) {
    background(dentist);
    drawBlank();
    wordBank();
    drawLetter();
    drawFish();
  }
  drawEnd();
}

void keyPressed()
{
  boolean keyIsGood = false;
  String letter = key+"";
  letter = letter.toUpperCase();
  for (int i = 0; i < word.length(); i++)
  {
    if (letter.equals(drawLetter[i][0]))
    {
      //correct = correct + letter;
      drawLetter[i][1] = "T";
      keyIsGood = true;
    }
  }
  if (!keyIsGood)
  {
    if (!(incorrect.contains(letter)))
    {
      incorrect = incorrect + letter + " ";
      numFish = numFish - 1;
    }
  }
}

void drawBlank()
{
  for (int i = 0; i < drawLetter.length; i++)
  {
    if (!drawLetter[i][0].equals(" "))
    {
      strokeWeight(5);
      line(((650-(30*drawLetter.length))/2)+30*i, 150, ((680-(30*drawLetter.length))/2)+30*i, 150);
    }
  }
}

void drawLetter()
{
  fill(0);
  textSize(25);
  for (int i = 0; i < drawLetter.length; i++)
  {
    //if (correct.contains(drawLetter[i][0]))
    if (drawLetter[i][1].equals("T"))
    {
      text(drawLetter[i][0], ((650-(30*drawLetter.length))/2)+30*i, 145);
    }
  }
  text(incorrect, 20, 565);
}

void drawFish()
{
  if (numFish <= 0)
  {
    background(255);
    image(Darla, 0, 0);
    text(word, 100, 500);
  }
  image(tank, 300, 285);
  //scale(.5);
  for (int x = 0; x < numFish; x++) {
    fList[x].drawFish();
    fList[x].moveFish();
  }
  //scale(2);
  for (int i = 6; i > numFish; i=i-1) {
    if (i > 3)
      image(fish[i-1], 360+(i-4)*80, 500);
    if (i <= 3 && i > 0)
      image(fish[i-1], 360+(i-1)*80, 420);
  }
}

void wordBank()
{
  strokeWeight(0);
  fill(#64D7E0);
  rect(10, 535, 300, 50);
}

String checkEnd() 
{
  String check = "";
  for (int i = 0; i < drawLetter.length; i++)
  {
    check = check + drawLetter[i][1];
  }
  return check;
}

boolean playerWon()
{
  for (int i = 0; i < word.length(); i++) {
    if (drawLetter[i][1].equals("F"))
      return false;
  }
  return true;
}



void drawEnd()
{
  if (playerWon()) {  //checkEnd().equals(checkCorrect)) {
    //frameRate(16);
    fill(255);
    rect(0, 400, 650, 600);
    fill(0);
    text(word, 100, 500);
    endDisplay.display(0, 0);
    fill(255);
   // text("REPLAY?", 450
   // rect(400, 470, 150, 100);
    gameState = ENDSCREEN;
  }
}

class Fish {
  float bX, bY; // position
  float bVX, bVY; // velocities
  PImage img;

  Fish(PImage p)
  {
    bX = random(width);
    bY = random(height-50);
    bVX = random(4)-2;
    bVY = random(4)-2;
    img = p;
  }

  void moveFish()
  {
    bX = bX + bVX;
    bY = bY + bVY;
    if (bX < 0)
    {
      bVX = -bVX;
      bX = 0;
    }
    if (bX > width-80)
    {
      bVX = -bVX;
      bX = width-80;
    }
    if (bY < 0)
    {
      bVY = -bVY;
      bY = 0;
    }
    if (bY > height-80)
    {
      bVY = -bVY;
      bY = height-80;
    }
  }

  void drawFish()
  {
    image(img, bX, bY);
  }
} // end class Bouncer