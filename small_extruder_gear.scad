// Copyright
// (c) 2011  Guy 'DeuxVis' P. <device@ymail.com>
// (c) 2013  Felipe C. da S. Sanches <fsanches@metamaquina.com.br>
// (c) 2013  Rafael H. de L. Moretti <rafael.moretti@gmail.com>
// 
// Licensed under the terms of the GNU General Public License
// version 3 (or later).

use <gears.scad>;
include <BillOfMaterials.h>;

module motor_gear(teeth=11, shaft_diameter=5){
  BillOfMaterials(category="3D Printed", partname="Small Extruder Gear");

  {//TODO: Add this part to the CAD model
    BillOfMaterials("M3x8 grubscrew - TODO");
  }

  render()
  translate([0,0,5])
  difference() {
    union() {
      //gear
      herringbone_gear( teeth=teeth, $fn=50 );

      translate( [0, 0, 13] )
      mirror( [0, 0, 1] )
      difference() {
        //base
        rotate_extrude($fn=120) {
          square( [9, 8] );
          square( [10, 7] );
          translate( [9, 7] ) circle( 1, $fn=50 );
        }

        //captive nut and grub holes
        translate( [0, 20, 4] ) rotate( [90, 0, 0] ) union() {
          //enterance
          translate( [0, -3, 14.5] ) cube( [5.4, 6, 2.4], center=true );
          //nut
          translate( [0, 0, 13.3] ) rotate( [0, 0, 30] ) cylinder( r=3.12, h=2.4, $fn=6 );
          //grub hole
          translate( [0, 0, 9] ) cylinder( r=1.5, h=10, $fn=20 );
        }
      }
    }

    //shaft hole
    translate( [0, 0, -6] )
    cylinder( r=shaft_diameter/2, h=20, $fn=20 );
  }
}

motor_gear();
