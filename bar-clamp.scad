// Bar clamp
// Used for joining 8mm rods
//
// This code is derived from:
// http://www.reprap.org/wiki/Prusa_Mendel
// http://github.com/prusajr/PrusaMendel
//
// (c) 2012 Josef Průša <josefprusa@me.com>
// (c) 2013 Metamáquina <http://www.metamaquina.com.br/>
//
// Authors:
// * Josef Průša <josefprusa@me.com>
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

include <configuration.scad>
include <BillOfMaterials.h>;
include <render.h>

module barclamp(){
  BillOfMaterials(category="3D Printed", partname="Bar Clamp", ref="MM2_BC");

  outer_diameter = threaded_rod_diameter/2 + 2.4;

  material("ABS"){
    difference(){
      union(){
        translate([outer_diameter, outer_diameter, 0])
        cylinder(h =outer_diameter*2, r = outer_diameter, $fn = 100);

        translate([outer_diameter, 0, 0])
        cube([outer_diameter+1.5,outer_diameter*2,outer_diameter*2]);

        translate([18, 2*outer_diameter, outer_diameter])
        rotate([90, 0, 0])
        nut(outer_diameter*2, outer_diameter*2, false);
      }

      translate([18, outer_diameter, 9])
      cube([18,05,20], center=true);

      translate([outer_diameter, outer_diameter, -1])
      cylinder(h = 20, r = threaded_rod_diameter/2, $fn = 80);

      translate([17, 17, outer_diameter])
      rotate([90, 00, 00])
      cylinder(h = 20, r = threaded_rod_diameter/2, $fn = 80);
    }
  }
}

barclamp();
