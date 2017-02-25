class Animation {
  PImage[] endings;
  int imageCount;
  int frame = -1;
  int numDisplaysPerFrame = 4;
  int count = 0;

  Animation(String imagePrefix, int count) {
    imageCount = count;
    endings = new PImage[imageCount*2];

    for (int i = 0; i < imageCount; i++) {
      // Use nf() to number format 'i' into four digits
      String filename = imagePrefix + nf(i+1, 4) + ".gif";
      endings[i] = loadImage(filename);
      endings[i].resize(650, 400);
      endings[(imageCount*2)-(i+1)] = loadImage(filename);
      endings[(imageCount*2)-(i+1)].resize(650,400);
      
    }
  }

  void display(float xpos, float ypos) {
    if (count % numDisplaysPerFrame == 0)
      frame = (frame+1) % (imageCount*2);
    image(endings[frame], xpos, ypos);
    count++;
  }
}