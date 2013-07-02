// Reimplementation of Josef Průša's belt clamp
// Adapted for eighter laser cutting or 3d printing.
//
// (c) 2013 Metamáquina <http://www.metamaquina.com.br/>
//
// Author:
// * Felipe C. da S. Sanches <fsanches@metamaquina.com.br>
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

include <Metamaquina2.h>;
include <BillOfMaterials.h>;
include <bolts.h>;
include <washers.h>;
include <render.h>;

module belt_clamp_holder(){
  r = 5;
  s = 28 - 2*r;
  hull(){
    for (p=[[s,0], [s,s], [0,0]]){
      translate(p)
      circle(r=r, $fn=20);
    }
  }
}

//2d shape (good for the lasercutter)
module beltclamp_curves(width, r, for_x_carriage=false, for_y_platform=false){
  d = width/2-r;

  difference(){
    hull(){
      for (x=[-d,d]){
        translate([x, 0])
        circle(r=5, $fn=20);
      }

      if(for_x_carriage){
        for (x=[-d,0.7*d]){
          translate([x, 4])
          circle(r=5, $fn=20);
        }
      }

      if (for_y_platform){
        for (x=[-d,d]){
          translate([x, 0])
          circle(r=8, $fn=20);
        }
      }

    }

    //These are holes for M3 bolts, but we want
    // some clearance so they'll have 3.3mm diameter.
    for (x=[-d,d]){
      translate([x, 0])
      circle(r=3.3/2, $fn=20);
    }
  }
}

// This seems to be designed for T5.
//TODO: Adapt this for 2mm GT2? (add a belt_pitch parameter?)
module teeth_for_belt(belt_width=6){
  for (y=[-2:2])
    translate([0,y*2.5])
    square([belt_width+2, 1.8], center = true);
}

module beltclamp(width=28, height=6, r=5, teeth_depth=0.5){
  BillOfMaterials(category="3D printed", partname="Belt Clamp");

  material("ABS"){
    render()
    difference(){
      linear_extrude(height=height)
      beltclamp_curves(width, r);

      translate([0, 0, height-teeth_depth]){
        linear_extrude(height = teeth_depth+1)
        teeth_for_belt();
      }
    }
  }
}

module x_carriage_beltclamp(width=28, height=6, r=5){
  BillOfMaterials(category="Lasercut wood", partname="X Carriage Belt Clamp");

  material("lasercut")
  linear_extrude(height=height)
  beltclamp_curves(width, r, for_x_carriage=true);

  for (i=[-1,1])
  rotate([180,0])
  translate([i*9,0]){
    M3_washer();
    translate([0,0,m3_washer_thickness]){
      M3x20();
    }
  }
}

module y_platform_beltclamp(width=28, height=6, r=5){
  BillOfMaterials(category="Lasercut wood", partname="Y Platform Belt Clamp");

  material("lasercut")
  linear_extrude(height=height)
  beltclamp_curves(width, r, for_y_platform=true);
}

beltclamp(); //for 3d printing

translate ([0,20])
x_carriage_beltclamp(); //lasercut model

translate ([0,40])
y_platform_beltclamp(); //lasercut model
