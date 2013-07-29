// (c) 2013 Metamáquina <http://www.metamaquina.com.br/>
//
// Authors:
// * Felipe C. da S. Sanches <fsanches@metamaquina.com.br>
// * Rafael H. de L. Moretti <moretti@metamaquina.com.br>
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.

include <BillOfMaterials.h>;
include <nuts.h>;
include <render.h>;

module M25_nut(){
  BillOfMaterials("M2.5 nut", ref="P_M2.5");
  nut(m25_nut_r, R = m25_nut_R, H = m25_nut_height);
}

module M3_nut(){
  BillOfMaterials("M3 nut", ref="P_M3");
  nut(r = m3_nut_r, R = m3_nut_R, H = m3_nut_height);
}

module M3_locknut(){
  BillOfMaterials("M3 lock-nut", ref="P_M3_ny");
  locknut(r = 2.25, R = 6.235, H1 = 2.23, H = 3.95);
}

module M4_nut(){
  BillOfMaterials("M4 nut", ref="P_M4");
  nut(r = m4_nut_r, R = m4_nut_R, H = m4_nut_height);
}

module M8_nut(){
  BillOfMaterials("M8 nut", ref="P_M8");
  nut(r = m8_nut_r, R = m8_nut_R, H = m8_nut_height);
}

//TODO: verify this
module new_M8_nut(){
  BillOfMaterials("M8 nut", ref="P_M8");
  nut(r = 6.75, R = 14.76, H = 6.35);
}

module M3_locknut(){
  BillOfMaterials("M3 lock-nut", ref="P_M3_ny");
  locknut(r = m3_nut_r, R = m3_nut_R, H1 = 2.7, H = 3.95);
}

module M8_locknut(){
  BillOfMaterials("M8 lock-nut", ref="P_M8_ny");
  locknut(r = m8_nut_r, R = m8_nut_R, H1 = 6.4, H = 7.94);
}

function hypotenuse(a, b) = sqrt(a*a + b*b);
epsilon = 0.05;

// Commented lines are not working for all sizes
module nut(r, R, H){
  material("metal")
  difference(){
    intersection(){
      cylinder(r=R*2/sqrt(3), h=H, $fn=6);
      sphere(r=hypotenuse(R, H), $fn=60);
      translate([0,0,H])
      sphere(r=hypotenuse(R, H), $fn=60);
    }

    //hole
    translate([0,0,-epsilon])
    cylinder(r=r, h=H+2*epsilon);
  }
}

// H: total height
module locknut(r, R, H1, H){
  material("metal")
  difference() {
    union(){
      nut(r, R, H1);

      intersection(){
        translate([0,0,H1]) cylinder(r=R, h=H-H1, $fn=60);
        translate([0,0,H1]) sphere(r=R, $fn=60);
      }
    }
    translate([0,0,H1-epsilon])
    cylinder(r=R-1, h=H-H1+2*epsilon, $fn=60);
  }

  material("nylon")
  translate([0,0,H1])
  linear_extrude(height=H-H1-0.7)
  difference(){
    circle(r=R-1);
    circle(r=r);
  }
}


translate([0,-20,0])
M3_locknut();

M8_locknut();

translate([0,20,0]) M8_nut();
