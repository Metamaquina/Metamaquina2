// Copyright
// (c) 2011  Guy 'DeuxVis' P. <device@ymail.com>
// (c) 2013  Felipe C. da S. Sanches <fsanches@metamaquina.com.br>
// (c) 2013  Rafael H. de L. Moretti <rafael.moretti@gmail.com>
// 
// Licensed under the terms of the GNU General Public License
// version 3 (or later).

use <gears.scad>;
include <gears-params.scad>;
include <BillOfMaterials.h>;

module extruder_gear(teeth=37, circles=12, shaft=8.6){
  BillOfMaterials(category="3D Printed", partname="Large Extruder Gear");

  body_thickness = 4;
  hub_thickness = 8;

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
