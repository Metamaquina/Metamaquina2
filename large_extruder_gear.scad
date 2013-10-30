// (c) 2011  Guy 'DeuxVis' P. <device@ymail.com>
// (c) 2013 Metamáquina <http://www.metamaquina.com.br/>
//
// Authors:
// * Guy 'DeuxVis' P. <device@ymail.com>
// * Felipe C. da S. Sanches <fsanches@metamaquina.com.br>
// * Rafael H. de L. Moretti <rafael.moretti@gmail.com>
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

use <gears.scad>;
include <gears-params.scad>;
include <BillOfMaterials.h>;
include <render.h>;

module extruder_gear(teeth=37, circles=12, shaft=8.6){
  BillOfMaterials(category="3D Printed", partname="Large Extruder Gear", ref="MM2_LEG");

  body_thickness = 4;
  hub_thickness = 8;

  material("ABS")
  difference(){
    union() {
      //hub
      translate([0,0,-0.01])
      cylinder( r1=15, r2=9, h=hub_thickness );

      difference(){
        //gear
        translate([0,0,gear_thickness/2])
        herringbone_gear( gear_thickness=gear_thickness, teeth=teeth, shaft=shaft, $fn=40 );

        //central cut to make the gear thin
        translate([0,0,body_thickness])
        cylinder(r1=26, r2=29, h=gear_thickness - body_thickness + 0.01);
      }

    }

    for (i=[0:circles-1])
      rotate(i*360/circles)
      translate([0,0,-0.1])
      if (i%2==0){
        sector_hole();
      }
      else{
	rotate(2)
        translate([12,0,-0.01])
        scale(0.6)
        linear_extrude(height=20) import("MM_hole.dxf", layer="eme");
      }

    //M8 hobbed bolt head fit washer
    translate( [0, 0, 2.5 -0.01] )
    cylinder( r=12.9/sqrt(3), h=10, $fn=6 );

    translate( [0, 0, -0.1] )
    cylinder( r=shaft/2, h=10, $fn=20 );
  }
}

extruder_gear();
