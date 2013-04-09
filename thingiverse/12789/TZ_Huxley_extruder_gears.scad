/* An extruder gear set for the TechZone Huxley,
 *  featuring Herringbone teeth.
 * You will have to recalibrate your E_STEPS_PER_MM in
 *  your firmware (ratio changing from original techzone
 *  lasercut gears).
 * This use 2 modules from the MCAD library that you can
 *  get from https://github.com/elmom/MCAD.
 * 
 * Part - the motor gear mount hub with set screw hole -
 *  derived from http://www.thingiverse.com/thing:3104
 *  (thanks GilesBathgate) which is under GPL CC license.
 *
 * Copyright (C) 2011  Guy 'DeuxVis' P.
 * Copyright (C) 2013  Rafael H. de L. Moretti
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.

 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 * -- 
 *     DeuxVis - device@ymail.com */

use <MCAD/involute_gears.scad>
gear_thickness = 10;

/* Herringbone gear module, adapted from MCAD/involute_gears */
module herringbone_gear( teeth=12, shaft=5, gear_thickness=10 ) {
  twist=200;
  pressure_angle=30;

  gear(
    number_of_teeth=teeth,
    circular_pitch=320,
		pressure_angle=pressure_angle,
		clearance = 0.2,
		gear_thickness = gear_thickness/2,
		rim_thickness = gear_thickness/2,
		rim_width = 1,
		hub_thickness = gear_thickness/2,
		hub_diameter=1,
		bore_diameter=shaft,
		circles=0,
		twist=twist/teeth
  );

	mirror( [0,0,1] )
	  gear(
      number_of_teeth=teeth,
		  circular_pitch=320,
		  pressure_angle=pressure_angle,
		  clearance = 0.2,
		  gear_thickness = gear_thickness/2,
		  rim_thickness = gear_thickness/2,
		  rim_width = 1,
		  hub_thickness = gear_thickness/2,
		  hub_diameter=1,
		  bore_diameter=shaft,
		  circles=0,
		  twist=twist/teeth
    );
}

module sector_hole(){
	gear_thickness=4;
	render()
	rotate([0, 0, -4])
	intersection(){
		difference(){
			cylinder(r=26,h=gear_thickness+2);
			cylinder(r=12,h=gear_thickness+2);
		}
		cube([100, 100, gear_thickness+2]);
		rotate([0, 0, 90-25]) cube([100, 100, gear_thickness+2]);
	}
}

module extruder_gear(teeth=37, circles=12, shaft=8.6){
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

module motor_gear(teeth=11, shaft_diameter=5){
  render()
  translate([0,0,5])
  rotate([180,0])
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

extruder_gear();

translate( [60, 0, 0] )
translate([0,0,10])
rotate([180,0])
motor_gear();
