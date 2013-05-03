// t-slot helper modules
//
// (c) 2013 Felipe C. da S. Sanches <fsanches@metamaquina.com.br>
// Licensed under the terms of the GNU General Public License
// version 3 (or later).

include <Metamaquina2.h>;

module t_slot_holes(width, thickness, joint_size=5){
  translate([0, width/2])
  circle(r=m3_diameter/2, $fn=20);

  translate([0, width/4])
  square([thickness, joint_size], center=true);

  translate([0, 3*width/4])
  square([thickness, joint_size], center=true);
}

module t_slot_cuts(width, diameter, length){
  translate([0, width/2])
  rotate([0, 0, 90])
  t_slot_shape(diameter, length);
}

module t_slot_shape(diameter, length){
	translate([-diameter/2, 0])
	square([diameter, length]);

	translate([-diameter, length-(3/2)*diameter])
	square([2*diameter, diameter]);
}

module t_slot_joints(width, thickness, joint_size=5){
  translate([0, width/4])
  square([thickness, joint_size], center=true);

  translate([0, 3*width/4])
  square([thickness, joint_size], center=true);
}

module t_slot_bolt_washer_nut(diameter, length){
washer_height = 0.5;
  //bolt head
  translate([0, 0, washer_height])
  difference(){
    cylinder(r=diameter, h=0.75 * diameter, $fn=20);
    translate([0,0,0.25*diameter])
    cylinder(r=diameter*0.7, h=diameter, $fn=6);
  }

  //washer
  cylinder(r=diameter*1.4, h=washer_height, $fn=20);

  //bolt body
  translate([0, 0, -length + washer_height])
  cylinder(r=diameter/2, h=length, $fn=20);

  //nut
  translate([0, 0, -length+diameter])
  cylinder(r=diameter, h=diameter/2, $fn=6);
}

