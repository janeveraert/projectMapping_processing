class Area{
 PVector[] pos = new PVector[4];
 
 
 PVector[] pr = new PVector[4];
 PImage proj;
 
 int x;
 int y;
 
 int w;
 int h;
 
 Area(int xp, int yp, PVector p1, PVector p2, PVector p3, PVector p4, int wi, int he){
  x = xp;
  y = yp; 
  pr[0] = p1;
  pr[1] = p2;
  pr[2] = p3;
  pr[3] = p4;
  w = wi;
  h = he;
 } 
 void draw(){
   beginShape();
   texture(proj);
   textureMode(NORMAL);

   vertex(pr[0].x, pr[0].y, 0, 0);
   vertex(pr[1].x, pr[1].y, 1, 0);
   vertex(pr[2].x, pr[2].y, 1, 1);
   vertex(pr[3].x, pr[3].y, 0, 1);
   endShape();
   
 }
 void drawShape(){
   fill(255, 0, 0);
   beginShape();
   vertex(pr[0].x, pr[0].y);
   vertex(pr[1].x, pr[1].y);
   vertex(pr[2].x, pr[2].y);
   vertex(pr[3].x, pr[3].y);
   endShape();
 }
  
}
