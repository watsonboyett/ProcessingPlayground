// set default height/width/res
float p_w = 8, p_h = 10.5;
int dpi = 300;

// set border/box params
int p_border = 10;
int b_off = 2;
float b_thick = 2.3;

// set number of primes to sift
int N = 10000;
boolean[] prime;
int[] pdist;

// setup the workspace
void setup() {
  int sx = int(p_w*dpi) + 2*p_border;
  int sy = int(p_h*dpi) + 2*p_border;
  size(sx, sy);
  background(0);
  noLoop();

  calc_primes();
}

// sieve of eratosthenes
void calc_primes() {
  // initialize sieve
  prime = new boolean[N];
  for (int i=2; i<N; i++) {
    prime[i] = true;
  }
  pdist = new int[N];
  int d = 0;
  
  // sift for primes
  for (int i=2; i<N; i++) {
    if (prime[i]) {
      //println(i);
      // store distance between last prime and current
      pdist[i] = d;
      d = 0;
      // kill multiples of current prime
      for (int j=i*i; j<N; j=j+i) {
        if (j<0) { 
          break;
        }
        prime[j] = false;
      }
    }
    d = d + 1;
  }
}

void draw() {
  // calc element dimensions
  int nCols = 100;
  int nRows = N / nCols;
  float wx = (width - 2*p_border) / nCols;
  float wy = (height - 2*p_border) / nRows;

  int pd_min = min(pdist);
  int pd_max = max(pdist);
  // draw primes
  for (int i=0; i<N; i++) {
    if (prime[i]) {
      // calculate element position
      float px = (i % nCols);
      px = map(px, 0, nCols, 0, width - 2*p_border) + p_border;
      float py = (i / nCols); 
      py = map(py, 0, nRows, 0, height - 2*p_border) + p_border;

      // set element color (based on distance between primes)
      float pa = map(pdist[i], pd_max, pd_min, 25, 255);
      color pc = color(pa, pa, pa, 255);
      stroke(pc);
      strokeWeight(b_thick);
      noFill();

      rect(px+b_off, py+b_off, wx-2*b_off, wy-2*b_off);
    }
  }

  // draw border
  stroke(255);
  noFill();
  rectMode(CORNERS);
  rect(p_border-b_off, p_border-b_off, width-p_border+b_off, height-p_border+b_off);

  // save raw/preview images
  save("primes.tif");
  save("primes.jpg");
}

