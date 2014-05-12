import processing.video.*; 
Capture cam; 

int w=640;
int h=480;

float cx = w/2;
float cy = h/2;

class Diagonal {
  int x, y;
  int sx, sy;
  int th;
  color c = color(255, 204, 0);

  Diagonal(int x, int y, int sx, int sy, int th) {
    this.x = x;
    this.y = y;
    this.sx = sx;
    this.sy = sy;
    this.th = th;
  }

  void update() {
    stroke(c);
    strokeWeight(th);

    line(x, y, cx-10+random(20), cy-10+random(20));
    x = x + sx;
    y = y + sy;

    if (((x > w) || (x<0)) || ((y > h) || (y<0))) {
      x = mouseX;
      y = mouseY;
      float rf = random(1);
      int r;
      if (rf > 0.5) { 
        r = 1;
      } 
      else {
        r = -1;
      }
      sy = 1+int(random(30)) * r;
      sx = 1+int(random(30)) * r;
      
      c = color(random(155), random(144), random(155));
      th = 1+ri(10);
    }
  }
}

int num = 100;
Diagonal[] ds = new Diagonal[num];

int ri(int v) {
  return int(random(v));
}

void setup() {
  background(0);
  stroke(0);
  size(w, h);


  for (int i=0;i<num;i++) {
    ds[i] = new Diagonal(ri(w), ri(h), 1+ri(2), 1+ri(1), 2);
  }
  
  cam = new Capture(this);
  cam.start();
}

void draw()
{
  background(0);
  image(cam, 0, 0); 
  
  for (int i=0;i<num;i++) {
    ds[i].update();
  }
  //d1.update();
}

void captureEvent(Capture c) {
  c.read();
}
