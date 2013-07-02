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

extruders_distance=9;

  J_head_body();

  translate([-0.15625*25.4,-0.250*25.4,-50])
  //translate([1*extruders_distance,0,0])
  v4nozzle();


 // #v4nozzle();
}

module J_head_body(){
  BillOfMaterials("JHead machined body", ref="MM2_PEEK");

  {
    //TODO: Add this part to the CAD model
    BillOfMaterials("PTFE liner", ref="MM2_PTFE_liner");
  }

h1=50;
r1=10.4/2;

h2=1;
r2=13/2;

h3=13.6;
r3=16/2;

h4=1;
r4=16/2;

h5=1;
r5=16/2;

h6=1;
r6=16/2;

h7=1;
r7=16/2;

h8=10.4;
r8=16/2;

h9=4.64;
r9=(5/8)*inch/2;


  material("peek"){
    difference(){
      union(){
        translate([0,0,-50+4.76+4.64]){
        cylinder(h=h1,r=r1);

        cylinder(h=h2,r=r2);

        translate([0,0,1])
        cylinder(h=h3,r=r3);

        translate([0,0,1+13.6+2.5])
        cylinder(h=h4,r=r4);

        translate([0,0,1+13.6+2.5+1+2.5])
        cylinder(h=h5,r=r5);

        translate([0,0,1+13.6+2.5+1+2.5+1+2.5])
        cylinder(h=h6,r=r6);

        translate([0,0,1+13.6+2.5+1+2.5+1+2.5+1+2.5])
        cylinder(h=h7,r=r7);

        translate([0,0,1+13.6+2.5+1+2.5+1+2.5+1+2.5+1+2.5])
        cylinder(h=h8,r=r8);

        translate([0,0,50-4.64])
        cylinder(h=h9,r=r9);
        }
      }

      union()
<<<<<<< .merge_file_K4LOfE
      translate([13+10/2,0,-50+4.76+4.64-10/2+6])
      cube(size=[10,100,10], center=true );

      translate([-13-10/2,0,-50+4.76+4.64-10/2+6])
      cube(size=[10,100,10], center=true );
=======
      translate([13/2+10/2,0,-50+4.76+4.64-10/2+6])
      cube(size=[10,10,10], center=true );

      translate([-13/2-10/2,0,-50+4.76+4.64-10/2+6])
      cube(size=[10,10,10], center=true );
>>>>>>> .merge_file_sSWurE
    }
  }
}

J_head_assembly();
