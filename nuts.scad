// (c) 2013 Felipe C. da S. Sanches <fsanches@metamaquina.com.br>,
// (c) 2013 Rafael H. de L. Moretti <moretti@metamaquina.com.br>
// Licensed under the terms of the GNU General Public License
// version 3 (or later).

include <BillOfMaterials.h>;
include <nuts.h>;
include <colors.h>;

module M25_nut(){
  BillOfMaterials("M2.5 nut");
  nut(m25_nut_r, R = m25_nut_R, H = m25_nut_height);
}

module M3_nut(){
  BillOfMaterials("M3 nut");
  nut(r = m3_nut_r, R = m3_nut_R, H = m3_nut_height);
}

module M3_locknut(){
  BillOfMaterials("M3 lock-nut");
  locknut(r = 2.25, R = 6.235, H1 = 2.23, H = 3.95);
}

module M4_nut(){
  BillOfMaterials("M4 nut");
  nut(r = m4_nut_r, R = m4_nut_R, H = m4_nut_height);
}

module M8_nut(id=""){
  BillOfMaterials(str("M8 nut ", id));
  nut(r = m8_nut_r, R = m8_nut_R, H = m8_nut_height);
}

//TODO: verify this
module new_M8_nut(){
  nut(r = 6.75, R = 14.76, H = 6.35);
}

//TODO: verify this
module M8_locknut(){
  BillOfMaterials("M8 lock-nut");
  locknut(r = 6.75, R = 14.76, H1 = 6.4, H = 7.94);
}

module M8_cap_nut(){
  BillOfMaterials("M8 cap-nut");
  cap_nut(r = m8_capnut_r, R = m8_capnut_R, H1 = m8_capnut_H1, H = m8_capnut_height);
}

function hypotenuse(a, b) = sqrt(a*a + b*b);
epsilon = 0.05;

// Commented lines are not working for all sizes
module nut(r, R, H){
  color(metal_color)
  difference(){
    //hexagon
    intersection(){
      cylinder(r=R*2/sqrt(3), h=H, $fn=6);
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
