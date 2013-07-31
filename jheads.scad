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
include <jhead.h>;
include <render.h>;
use <nozzle.scad>;

module J_head_assembly(){
  J_head_body();

  translate([-0.15625*25.4,-0.250*25.4,-50])
  v4nozzle();
}

module J_head_body(){
  BillOfMaterials("JHead machined body");

  {
    //TODO: Add this part to the CAD model
    BillOfMaterials("PTFE liner");
  }

  material("peek"){
    difference(){
      union(){
        translate([0,0,-50+4.76+4.64]){
        cylinder(h=50,r=10.4/2);

        cylinder(h=1,r=(13/2));

        translate([0,0,1])
        cylinder(h=13.6,r=(16/2));

        translate([0,0,1+13.6+2.5])
        cylinder(h=1,r=(16/2));

        translate([0,0,1+13.6+2.5+1+2.5])
        cylinder(h=1,r=(16/2));

        translate([0,0,1+13.6+2.5+1+2.5+1+2.5])
        cylinder(h=1,r=(16/2));

        translate([0,0,1+13.6+2.5+1+2.5+1+2.5+1+2.5])
        cylinder(h=1,r=(16/2));

        translate([0,0,1+13.6+2.5+1+2.5+1+2.5+1+2.5+1+2.5])
        cylinder(h=10.4,r=(16/2));

        translate([0,0,50-4.64])
        cylinder(h=4.64,r=(5/8)*inch/2);
        }
      }

extra_extruder_length=50
extruder_dist=9
      translate([-extra_extruder_length/2+extruder_dist,0])
      //#circle(r=XCarriage_nozzle_hole_radius);
      #circle(r=13/2); //sara

      union()
      translate([13/2+10/2,0,-50+4.76+4.64-10/2+6])
      cube(size=[10,10,10], center=true );

      translate([-13/2-10/2,0,-50+4.76+4.64-10/2+6])
      cube(size=[10,10,10], center=true );
    }
  }
}

J_head_assembly();
