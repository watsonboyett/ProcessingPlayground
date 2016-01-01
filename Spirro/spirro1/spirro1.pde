
float rad1 = 240, rad2 = 80, rad3 = 0;
float[] cntr = {
  0,0
};
float ang1 = 0, ang2 = 0, ang3 = 0;
float inc1 = PI/180, inc2 = PI/20, inc3 = PI/3;
float prvx, prvy;


float lnA = 0;
color lnC = 0;
void setup()
{
  size(800,800);
  background(0);

  cntr[0] = width/2;
  cntr[1] = height/2;
  prvx = cntr[0];
  prvy = cntr[1];
}


void draw()
{
  float piv1x, piv1y, piv2x, piv2y, piv3x, piv3y, x, y;
  float da = 1, dr = 1;

  if(mousePressed) 
  {
    da = (float(mouseX)/width)*0.2 + 1.0;
    dr = (float(mouseY)/height)*0.2 + 1.0;
  }

  ang1 = ang1 + inc1 + noise(ang1)/100;
  if(ang1>=2*PI)
    ang1 = ang1-2*PI;

  ang2 = (ang2 + inc2 + noise(ang2)/100) * da;
  if(ang2>=2*PI)
    ang2 = ang2-2*PI;

  ang3 = ang3 + inc3 + noise(ang3)/100;
  if(ang3>=2*PI)
    ang3 = ang3-2*PI;

  piv1x = rad1*cos(ang1*da);
  piv1y = rad1*sin(ang1*da);
  piv2x = (rad2*dr)*cos(ang2);
  piv2y = (rad2*dr)*sin(ang2);
  piv3x = rad3*cos(ang3);
  piv3y = rad3*sin(ang3);

  x = cntr[0] + piv1x + piv2x + piv3x;
  y = cntr[1] + piv1y + piv2y + piv3y;

  stroke(lnC,lnA);
  line(prvx,prvy,x,y);
  lnA = 255;
  color pntC = color(noise(y*noise(x))*255,noise(x*noise(y))*255,noise(noise(x)*noise(y))*255);
  lnC = blendColor(lnC,pntC,BLEND);


  prvx = x; 
  prvy = y;
}

