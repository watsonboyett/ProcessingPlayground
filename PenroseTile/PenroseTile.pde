/** 
 * Penrose Tile L-System 
 * by Geraldine Sarmiento.
 *  
 * This code was based on Patrick Dwyer's L-System class. 
 */

PenroseLSystem ds;

float p_w = 8, p_h = 10.5;
int dpi = 300;

void setup() {
  size(int(p_w*dpi), int(p_h*dpi));
  ds = new PenroseLSystem();
  ds.simulate(5);
}

void draw() {
  background(100);
  if (ds.render()) {
    save("penrose.tif");
    save("penrose.jpg");
    noLoop();
    println("done");
  }
}

