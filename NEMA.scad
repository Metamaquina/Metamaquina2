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
include <NEMA.h>;
include <bolts.h>;
include <washers.h>;
use <rounded_square.scad>;
include <render.h>;

module NEMA17(){
  BillOfMaterials("NEMA17 stepper motor", ref="SM1.8A1740CHSE");

  material("rubber"){
    translate([-NEMA17_width/2, -NEMA17_height/2, -0.1])
    intersection(){
      cube([NEMA17_width, NEMA17_height, NEMA17_length]);
      translate ([NEMA17_width/2, NEMA17_height/2]) cylinder(r=0.87*NEMA17_width*sqrt(2)/2, h=100);
    }
  }

  material("metal"){
    translate([0, 0, -motor_shaft_length])
    cylinder(r=motor_shaft_diameter/2, h=motor_shaft_length);

    translate([0,0,-3])
    cylinder(r1=6, r2=8, h=2);      

    translate([0,0,-0.2]){
      difference(){
        linear_extrude(height=NEMA17_length/5)
        rounded_square([NEMA17_width+2, NEMA17_height+2], center=true, corners=  [5,5,5,5]);

        translate([0,0,-0.2])
        linear_extrude(height=1)
        NEMA17_holes(central_hole=false);
      }

      //connector detail
      translate([-15.6/2,NEMA17_width/2 + 1, NEMA17_length - 4])
      cube([15.6, 4.6, 4]);
    }

    translate([0,0,NEMA17_length - NEMA17_length/5])
    linear_extrude(height=NEMA17_length/5)
    rounded_square([NEMA17_width+2, NEMA17_height+2], center=true, corners=[5,5,5,5]);
  }

  translate([0,0, NEMA17_length - 12.5])
  connector();
}

module connector(){
  //This is very hacky and someone should clean it up

  translate([-15/2,NEMA17_width/2 + 1, 4]){
    material("nylon")
    difference(){
        cube([15, 6, 4]);
        translate([1,1,0.5]) cube([13, 6, 3]);
        translate([3.5,4,-1]) cube([8, 10, 3]);
    }

    material("metal")
    for (i=[0:3]){
      translate([4+i*2.3,6, 2])
      rotate([90,0])
     cylinder(r=0.5, h=5);
    }
  }
}

module NEMA17_holes(l=15.5, r=12, central_hole=true){
  if (central_hole)
    circle(r=r);

  for (i=[-l,l]){
    for (j=[-l,l]){
      translate([i, j])
      circle(r=m3_diameter/2, $fn=20);
    }
  }
}

module NEMA17_subassembly(l=15.5, r=12, th=thickness){
  NEMA17();

  for (i=[-l,l]){
    for (j=[-l,l]){
      translate([i, j, -th - m3_washer_thickness]){
        M3_washer();

        rotate([180,0])
        M3x10();
      }
    }
  }
}

NEMA17_subassembly();
