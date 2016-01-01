
boolean drawOn = false;
float x, y, px=0, py=0;
float[] cntr = {
  0,0
};
float bgc = 255;
float lnA = 0;
color lnC = 0;
float lnW = 1;
void setup()
{
  size(800,800);
  background(bgc);
  stroke(lnA,lnC);

  cntr[0] = width/2;
  cntr[1] = height/2;
}

float R=380, k=0.7, l=0.2, t=0;
void draw()
{
  println(frameRate);
  
  if(t >= 2*PI*10)
  {
    k = random(0.05,0.95);
    l = random(0.05,0.95);
    R = random(180,520);
    t = 0;

    lnA = 0;
    lnW = random(1,5);
  }

  if (drawOn)
  {
    t = t + 0.05*(k*l*0.2+1);
    x = cntr[0] + R*((1-k)*cos(t) + l*k*cos((1-k)/k*t));
    y = cntr[1] + R*((1-k)*sin(t) - l*k*sin((1-k)/k*t));
    x = x + noise(x);
    y = y + noise(y);

    stroke(lnC,lnA);
    strokeWeight(lnW);
    line(px,py,x,y);
    color tmpC = color(noise(x)*random(0,255)+128,noise(y)*random(0,255)+128,noise(x-y)*noise(y-x)*random(0,255)+128);
    lnC = blendColor(lnC,tmpC,BLEND);
    lnA = random(50,250);

    px = x;
    py = y;
  }
}

void mouseClicked() {
  if (mouseButton == LEFT)
  {
    drawOn = !drawOn;
    save("spirro2.tif");
  }

  if (mouseButton == RIGHT)
  {
    k = float(mouseX)/width;
    l = float(mouseY)/height;
    R = 600*(k);
    lnA = 0;
    //t = 0;    
    //background(bgc);
    //drawOn = false;
  }
}

