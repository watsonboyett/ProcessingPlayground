class PenroseLSystem extends LSystem {

  int steps = 0;
  float somestep = 0.1;
  String ruleW;
  String ruleX;
  String ruleY;
  String ruleZ;

  PenroseLSystem() {
    axiom = "[X]++[X]++[X]++[X]++[X]";
    ruleW = "YF++ZF4-XF[-YF4-WF]++";
    ruleX = "+YF--ZF[3-WF--XF]+";
    ruleY = "-WF++XF[+++YF++ZF]-";
    ruleZ = "--YF++++WF[+ZF++++XF]--XF";
    startLength = 460.0;
    theta = radians(36);  
    reset();
  }

  void useRule(String r_) {
    rule = r_;
  }

  void useAxiom(String a_) {
    axiom = a_;
  }

  void useLength(float l_) {
    startLength = l_;
  }

  void useTheta(float t_) {
    theta = radians(t_);
  }

  void reset() {
    production = axiom;
    drawLength = startLength;
    generations = 0;
  }

  int getAge() {
    return generations;
  }

  boolean render() {
    translate(width/2, height/2);
    int pushes = 0;
    int repeats = 1;
    boolean isdone = false;
    float r = 0;
    
    // show steps?
    if (false) {
      steps += 24;
    } else {
      steps = production.length();
    }
    
    if (steps >= production.length()) {
      steps = production.length();
      isdone = true;
    }

    for (int i = 0; i < steps; i++) {
      char step = production.charAt(i);
      r = 0;
      if (step == 'F') {
        stroke(255, 120);
        strokeWeight(2);
        for (int j = 0; j < repeats; j++) {
          r = 1-(noise(j)-0.5)*0.01;
          line(0, 0, 0, -drawLength*r);
          noFill();
          translate(0, -drawLength);
        }
        repeats = 1;
      } 
      else if (step == '+') {
        for (int j = 0; j < repeats; j++) {
          r = (noise(j)-0.5)*0.0001;
          rotate(theta + r);
        }
        repeats = 1;
      } 
      else if (step == '-') {
        for (int j =0; j < repeats; j++) {
          r = (noise(j)-0.5)*0.0001;
          rotate(-theta + r);
        }
        repeats = 1;
      } 
      else if (step == '[') {
        pushes++;            
        pushMatrix();
      } 
      else if (step == ']') {
        popMatrix();
        pushes--;
      } 
      else if ( (step >= 48) && (step <= 57) ) {
        repeats = (int)step - 48;
      }
    }

    // Unpush if we need too
    while (pushes > 0) {
      popMatrix();
      pushes--;
    }
    
    return isdone;
  }

  String iterate(String prod_, String rule_) {
    String newProduction = "";
    for (int i = 0; i < prod_.length(); i++) {
      char step = production.charAt(i);
      if (step == 'W') {
        newProduction = newProduction + ruleW;
      } 
      else if (step == 'X') {
        newProduction = newProduction + ruleX;
      }
      else if (step == 'Y') {
        newProduction = newProduction + ruleY;
      }  
      else if (step == 'Z') {
        newProduction = newProduction + ruleZ;
      } 
      else {
        if (step != 'F') {
          newProduction = newProduction + step;
        }
      }
    }

    drawLength = drawLength * 0.72;
    generations++;
    return newProduction;
  }
}

