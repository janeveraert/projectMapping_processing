import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
AudioInput in;

PImage bg;
int w;
int h;
ArrayList<Area> quads = new ArrayList<Area>();

int startMouseX;
int startMouseY;

boolean edit = false;
boolean mmode = false;
boolean buildMode = true;
int selected = 0;
int corner = 0;
boolean makingNew = false;

boolean sketchFullScreen() {
  return true;
}
void setup() {
  size(800, 600, P3D);
  frameRate(12);
  minim = new Minim(this);
  in = minim.getLineIn();
}
void draw() {
  background(0);
  /*
  fill(255, 0, 0);
  rect(0, 0, width/2, height/2);
  fill(255, 255, 0);
  rect(width/2, 0, width/2, height/2);
  fill(0, 255, 0);
  rect(0, height/2, width/2, height/2);
  fill(0, 0, 255);
  rect(width/2, height/2, width/2, height/2);
  */
  stroke(255);
  for(int i = 0; i<in.bufferSize()-10; i+=10){
    float total = 0;
    for(int j = 0; j<10; j++){
        total+=in.mix.get(i+j)*10;
    }
    stroke(map(total, 0, 10, 150, 255));
    strokeWeight(10);
    line(int(map(i, 0, in.bufferSize(), 0, 800)), height, int(map(i, 0, in.bufferSize(), 0, 800)), height/2 + total*35);  
  }
  
  
  for (int i = 0; i<quads.size (); i++) {
    PImage img = get(int(quads.get(i).x), int(quads.get(i).y), int(quads.get(i).w), int(quads.get(i).h));
    quads.get(i).proj = img;
  }
  
  if(!buildMode)
  background(0);
  
  noStroke();
  if(mmode && edit){
    quads.get(selected).pr[corner].x = mouseX;
    quads.get(selected).pr[corner].y = mouseY;
  }
  for (int i = 0; i<quads.size (); i++) {
    if (edit && i == selected) {
      quads.get(i).drawShape();
    } else {
      quads.get(i).draw();
    }
  }
}

void keyPressed() {
  if (key == 'a') {
    edit = !edit;
  }
  if (key == 'e') {
    mmode = !mmode;
  }
  if (key == 'z' && edit) {
    quads.get(selected).pr[corner].y--;
  }
  if (key == 's' && edit) {
    quads.get(selected).pr[corner].y++;
  }
  if (key == 'q' && edit) {
    quads.get(selected).pr[corner].x--;
  }
  if (key == 'd' && edit) {
    quads.get(selected).pr[corner].x++;
  }
  
  if (key == 'b') {
    buildMode = !buildMode;
  }
  
  if (key == 'p' && edit) {
    
      quads.remove(quads.size()-1);
  }
  if (keyCode == UP) {
    selected++;
    if (selected > quads.size())
      selected = 0;
  }
  if (keyCode == DOWN) {
    selected--;
    if (selected < 0)
      selected = quads.size();
  }
  
  if (keyCode == RIGHT) {
    corner++;
    if (corner > 3)
      corner = 0;
  }
  if (keyCode == LEFT) {
    corner--;
    if (corner < 0)
      corner = 3;
  }
}
void mousePressed(){
  if(!mmode){
    makingNew = true;
    startMouseX = mouseX;
    startMouseY = mouseY;
  }
  mmode = false;
    
}
void mouseReleased(){
  if(makingNew){
    Area a = new Area(startMouseX, startMouseY, new PVector(startMouseX, startMouseY), new PVector(mouseX, startMouseY), new PVector(mouseX, mouseY), new PVector(startMouseX, mouseY), abs(mouseX-startMouseX), abs(mouseY-startMouseY));
    quads.add(a);
    selected = quads.size()-1;
    makingNew = false;
  }
}

