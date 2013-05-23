// An extremely detailed version of a 608zz bearing.
// This is not used in the 3d printer model.
// It is just a personal exercise on openscad 3d modeling.
//
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

use <rounded_square.scad>;
include <render.h>;

//include <render.h>;
$fa=0.01;
$fs=0.3;

608zz_inner_diameter = 8;
608zz_ball_diameter = 3.95;
608zz_num_balls = 7;
608zz_edge_fillet = 0.6;
608zz_small_fillet = 0.2;
608zz_race_thickness = 1.92;
608zz_race_radius = 608zz_inner_diameter/2 + 7/2;
608zz_cage_clearance = 0.0395;
608zz_cage_thickness = 0.3;
608zz_cage_internal_radius = 608zz_race_radius - 1.3;

module detailed_608zz_bearing_2d(){
    f = 608zz_edge_fillet;
    sf = 608zz_small_fillet;

    translate([608zz_race_radius,0]){
        difference(){
            union(){
                translate([7/2-608zz_race_thickness,-7/2])
                rounded_square([608zz_race_thickness, 7], corners=[sf,f,sf,f]);

                translate([-7/2,-7/2])
                rounded_square([608zz_race_thickness, 7], corners=[f,sf,f,sf]);
            }

            square([3,8], center=true);

            circle(r=2);

            for (i=[0,1])
                mirror([0,i])
                bearing_internal_cut();
        }
    }
}

module bearing_internal_cut(){
    translate([3/2, -7/2]){
        square([0.47, 0.6+0.6+0.2]);

        translate([0.47, 0.6])
        square([0.3, 0.6]);
    }
}

module detailed_608zz_bearing_body(){
    material("metal")
    rotate_extrude() detailed_608zz_bearing_2d();
}

time = 1/2 + (1/2) * cos(360*$t);
module detailed_608zz_bearing() {
    rotate([90,0]){
        detailed_608zz_bearing_body();

        translate([0,0,10*time])
        detailed_608zz_ball_cage1();

        translate([0,0,15*time])
        detailed_608zz_balls();

        translate([0,0,20*time])
        detailed_608zz_ball_cage2();
    }
}

module detailed_608zz_balls(){
    material("metal")
    for (i=[1:608zz_num_balls])
        rotate(i*360/608zz_num_balls)
            translate([608zz_race_radius, 0])
            sphere(r=608zz_ball_diameter/2);
}

module detailed_608zz_ball_cage1(){
    mirror([0,0,1])
    detailed_608zz_ball_cage();
}

module detailed_608zz_ball_cage2(){
    detailed_608zz_ball_cage();
}

module detailed_608zz_ball_cage(){
    translate([0,0,608zz_cage_clearance])
    material("metal")
    render(){

        linear_extrude(height=608zz_cage_thickness)
        difference(){
            circle(r=608zz_race_radius);
            circle(r=608zz_cage_internal_radius);

            for (i=[1:608zz_num_balls]){
                rotate(i*360/608zz_num_balls){
                    translate([608zz_race_radius, 0])
                    circle(r=608zz_ball_diameter/2 + 608zz_cage_clearance);
                }
            }
        }

        intersection(){
            difference(){
                sphere(r=608zz_race_radius);
                
                sphere(r=608zz_cage_internal_radius);

                translate([0,0,-(608zz_ball_diameter/2 + 608zz_cage_clearance + 608zz_cage_thickness)])
                cylinder(r=608zz_race_radius+1, h=608zz_ball_diameter/2 + 608zz_cage_clearance + 608zz_cage_thickness);
            }

            for (i=[1:608zz_num_balls]){
                rotate(i*360/608zz_num_balls){
                    translate([608zz_race_radius, 0])
                    difference(){
                        sphere(r=608zz_ball_diameter/2 + 608zz_cage_clearance + 608zz_cage_thickness);
                        sphere(r=608zz_ball_diameter/2 + 608zz_cage_clearance);
                    }
                }
            }
        }

    }
}

detailed_608zz_bearing();

