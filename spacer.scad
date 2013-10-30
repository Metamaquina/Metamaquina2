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

include <spacer.h>;
include <Metamaquina2.h>;
include <BillOfMaterials.h>;

m3_diameter = 3;

spacers_clearance = 0.1; // extra room for the spacers hole diameter

module double_M3_lasercut_spacer(){
  M3_spacer();

  translate([0,0,thickness])
  M3_spacer();
}

module M3_spacer(){
  BillOfMaterials(category = "Lasercut wood", "M3 Lasercut spacer");

  material("lasercut")
  linear_extrude(height=thickness)
  M3_spacer_face();
}

module M3_spacer_face(){
  difference(){
    circle(r=m3_spacer_radius, $fn=30);
    circle(r=(m3_diameter + spacers_clearance)/2, $fn=30);
  }
}

module set_of_M3_spacers(w=4, h=4){
  for (x=[1:w]){
    for (y=[1:h]){
      translate([x*3.2*m3_diameter, y*3.2*m3_diameter])
      M3_spacer_face();
    }
  }
}

module M4_spacer(){
  BillOfMaterials(category = "Lasercut wood", "M4 Lasercut spacer");

  material("lasercut")
  linear_extrude(height=thickness)
  M4_spacer_face();
}

module M4_spacer_face(){
  difference(){
    circle(r=m4_diameter*1.5, $fn=30);
    circle(r=(m4_diameter + spacers_clearance)/2, $fn=30);
  }
}

module set_of_M4_spacers(w=4, h=4){
  for (x=[1:w]){
    for (y=[1:h]){
      translate([x*3.2*m4_diameter, y*3.2*m4_diameter])
      M4_spacer_face();
    }
  }
}

module hexspacer_38mm(){
  BillOfMaterials(str("Female-female 38mm Hexspacer (CBTS135A)"), ref="CBTS135A");

  generic_hexspacer(length=38);
}

module hexspacer_32mm(){
  BillOfMaterials(str("Female-female 32mm Hexspacer (CBTS130A)"), ref="CBTS130A");

  generic_hexspacer(length=32);
}

module generic_hexspacer(D=8, d=m3_diameter, h=hexspacer_length){
  material("metal")
  linear_extrude(height=h)
  difference(){
    circle(r=D/2, $fn=6);
    circle(r=d/2, $fn=20);
  }
}

module generic_nylonspacer(D=8, d=m4_diameter, h=nylonspacer_length){
  material("nylon")
  linear_extrude(height=h)
  difference(){
    circle(r=D/2, $fn=20);
    circle(r=d/2, $fn=20);
  }
}

