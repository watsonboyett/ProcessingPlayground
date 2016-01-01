
float p_w = 8, p_h = 10.5;   // plotting dimensions (in inches) 
int p_dpi = 300;   // plotting resolution (dots per inch)
  
float x_center = 0;   // side length when recursion stops
float y_center = 0;   // side length when recursion stops
float len_stop = 5;   // side length when recursion stops

// setup workspace
void setup()
{
  size(int(p_w*p_dpi), int(p_h*p_dpi));
  noLoop();
}

// draw (once)
void draw()
{
  background(100);
  translate(width/2, height/2);

  noFill();
  rectMode(CENTER);
  
  // set the start length and begin the recursion
  float len_start = width*(3.0/4.0);
  draw_squares(x_center, y_center, len_start, len_stop);

  // save raw/preview images
  save("SquareFractal.tif");
  save("SquareFractal.jpg");
}

// draws a single square
void draw_square( float x, float y, float len)
{
  // determine line thickness of current square 
  float thick = len/(6*log(len));

  // add a little bit of noise
  float xr = noise(x) - 0.5;
  float yr = noise(y) - 0.5;

  // draw square
  stroke(250);
  strokeWeight(thick);
  rect(x, y, len-thick+xr, len-thick+yr);
}

// recursive function to draw succesively smaller squares
void draw_squares( float x, float y, float len, float when_end)
{
  float offset = len/4;
  if (len >= when_end)
  {
    draw_square(x, y, len);
    
    len = len/2;
    draw_squares(x+offset, y+3*offset, len, when_end);
    draw_squares(x+3*offset, y-offset, len, when_end);
    draw_squares(x-offset, y-3*offset, len, when_end);
    draw_squares(x-3*offset, y+offset, len, when_end);
  } 
  else {
    return;
  }
}

