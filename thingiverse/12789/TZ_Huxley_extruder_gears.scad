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

/* Herringbone gear module, adapted from MCAD/involute_gears */
module herringbone_gear( teeth=12, circles=0, shaft=5 ) {
  twist=200;
  height=10;
  pressure_angle=30;

  gear(
    number_of_teeth=teeth,
    circular_pitch=320,
		pressure_angle=pressure_angle,
		clearance = 0.2,
		gear_thickness = height/2,
		rim_thickness = height/2,
		rim_width = 1,
		hub_thickness = height/2,
		hub_diameter=1,
		bore_diameter=shaft,
		circles=circles,
		twist=twist/teeth
  );

	mirror( [0,0,1] )
	  gear(
      number_of_teeth=teeth,
		  circular_pitch=320,
		  pressure_angle=pressure_angle,
		  clearance = 0.2,
		  gear_thickness = height/2,
		  rim_thickness = height/2,
		  rim_width = 1,
		  hub_thickness = height/2,
		  hub_diameter=1,
		  bore_diameter=shaft,
		  circles=circles,
		  twist=twist/teeth
    );
}

module extruder_gear(teeth=67, circles=8, shaft=8.2){
  render()
  union() {
    //gear
    difference() {
      herringbone_gear( teeth=teeth, circles=0, shaft=shaft, $fn=120 );

      translate([0,0,1])
      cylinder(r1=25, r2=30, h=5);

      for (i=[1:circles])
      rotate(i*360/circles)
      translate([17.5,0,-5.1])
      cylinder(r1=4, r2=6, h=6.2);
    }
    //M8 hobbed bolt head fit washer
    translate([0,0,-5])
    difference() {
      translate( [0, 0, 5] ) cylinder( r1=11, r2=8, h=6 );
      translate( [0, 0, 4.5] ) cylinder( r=6.6, h=7, $fn=6 );
    }
  }
}

module motor_gear(teeth=13, shaft_diameter=5){
 union() difference() {	 
  union() {

    //gear
    herringbone_gear( teeth=teeth, $fn=80 );

    translate( [0, 0, 13] )
    mirror( [0, 0, 1] )
    difference() {
      //base
      rotate_extrude($fn=120) {
        square( [9, 9] );
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
//translate( [-28, 0, 0] )
//motor_gear();

