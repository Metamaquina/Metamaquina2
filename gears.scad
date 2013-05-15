// These gears are derived from:
//  "An extruder gear set for the TechZone Huxley,
//  featuring Herringbone teeth."
//
// This use 2 modules from the MCAD library that you can
//  get from https://github.com/elmom/MCAD.
// 
// Part - the motor gear mount hub with set screw hole -
//  derived from http://www.thingiverse.com/thing:3104
//  (thanks GilesBathgate) which is under GPL CC license.
//
// (c) 2011 Guy 'DeuxVis' P. <device@ymail.com>
// (c) 2013 Metamáquina <http://www.metamaquina.com.br/>
//
// Authors:
// * Giles Bathgate
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

use <MCAD/involute_gears.scad>

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

