import gab.opencv.*;
import processing.video.*;

OpenCV opencv;
Movie video;

void setup() {
  size(1136, 320);
  video = new Movie(this, "sample1.mov");
  opencv = new OpenCV(this, 568, 320);
  video.loop();
  video.play();
}

void draw() {
  background(0);

  if (video.width == 0 || video.height == 0)
    return;

  opencv.loadImage(video);
  opencv.calculateOpticalFlow();

  image(video, 0, 0);
  translate(video.width, 0);
  stroke(255, 0, 0);
  opencv.drawOpticalFlow();

  PVector aveFlow = opencv.getAverageFlow();
  int flowScale = 50;

  stroke(255);
  strokeWeight(2);
  line(video.width/2, video.height/2, video.width/2 + aveFlow.x*flowScale, video.height/2 + aveFlow.y*flowScale);
}

void movieEvent(Movie m) {
  m.read();
}
