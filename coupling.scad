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

include <coupling.h>;
include <render.h>;
include <BillOfMaterials.h>;

module coupling(shaft_diameter=5, rod_diameter=8){
  BillOfMaterials("Coupling for the Z axis", ref="JT2-20");

  material("metal")
  difference(){
    cylinder(r=coupling_diameter/2, h=coupling_length, $fn=60);

    translate([0,0,-epsilon])
      cylinder(r=shaft_diameter/2, h=coupling_shaft_depth+2*epsilon, $fn=20);

    translate([0,0,coupling_length - coupling_rod_depth - epsilon])
      cylinder(r=rod_diameter/2, h=coupling_rod_depth+2*epsilon, $fn=20);

    translate([-coupling_diameter/2 + 2,-1, -epsilon])
      cube([coupling_diameter, 2, 10*coupling_length+2*epsilon]);

    // Bolt hole 1
    translate([bolt_offsetx,-bolt_size/2,bolt1_offsetz+bolt_diameter/2])
    rotate(a=[0,90,90])
      cylinder(r=bolt_diameter/2, h=bolt_size+2*epsilon, $fn=20);

    // Bolt hole 2
    translate([bolt_offsetx,-bolt_size/2,coupling_length-bolt2_offsetz-bolt_diameter/2])
    rotate(a=[0,90,90])
      cylinder(r=bolt_diameter/2, h=bolt_size+2*epsilon, $fn=20);

  }
}

coupling();

