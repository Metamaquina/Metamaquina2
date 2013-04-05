// (c) 2013 Felipe C. da S. Sanches <fsanches@metamaquina.com.br>,
// (c) 2013 Rafael H. de L. Moretti <moretti@metamaquina.com.br>
// Licensed under the terms of the GNU General Public License
// version 3 (or later).

module M8_nut(){
  nut(r = 4, R = 7, H = 6);
}

module new_M8_nut(){
  nut(r = 6.75, R = 14.76, H = 6.35);
}

module M8_locknut(){
  locknut(r = 6.75, R = 14.76, H1 = 6.4, H = 7.94);
}

module M8_cap_nut(){
  cap_nut(r = 6.75, R = 14.76, H1 = 6.35, H = 14.87);
}

module M4_nut(){
  nut(r = 3.20, R = 7.875, H = 3.15);
}

module M3_nut(){
  nut(r = 2.25, R = 6.235, H = 2.23);
}

module M3_locknut(){
  locknut(r = 2.25, R = 6.235, H1 = 2.23, H = 3.95);
}

module M25_nut(){
  nut(r = 1.68, R = 5.68, H = 1.81);
}

function hypotenuse(a, b) = sqrt(a*a + b*b);
epsilon = 0.05;

// Commented lines are not working for all sizes
module nut(r, R, H){
  difference(){
    //hexagon
    intersection(){
      cylinder(r=2*R/sqrt(3), h=H, $fn=6);
      //sphere(r=hypotenuse(R, H), $fn=60);
      //translate([0,0,H])
      //sphere(r=hypotenuse(R, H), $fn=60);
    }

    //hole
    translate([0,0,-epsilon])
    cylinder(r=r, h=H+2*epsilon);
  }
}

// H: total height
module locknut(r, R, H1, H){
  difference() {
  union(){
    nut(r, R, H1);
    
    intersection(){
      translate([0,0,H1]) cylinder(r=R, h=H-H1, $fn=60);
      translate([0,0,H1]) sphere(r=R, $fn=60);
    }
  }
  translate([0,0,-epsilon]) cylinder(r=0.9*R, h=H+2*epsilon, $fn=60);
  }
}

// H: total height
module cap_nut(r, R, H1, H) {
  union(){
    nut(r, R, H1);
    intersection(){
      translate([0,0,H1]) cylinder(r=R, h=H-H1, $fn=60);
      translate([0,0,(H-H1)/2]) sphere(r=R, $fn=60);
    }
  }
}

M8_locknut();
translate([0,30,0]) M8_cap_nut();
