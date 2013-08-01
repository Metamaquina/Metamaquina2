// t-slot helper modules
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

include <Metamaquina2.h>;
include <BillOfMaterials.h>;
include <washers.h>;
include <bolts.h>;
include <nuts.h>;

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
  {
    //TODO: Add these nuts, washers and bolts to the CAD model
    BillOfMaterials(str("M",diameter,"x",length," bolt"), ref=str("H_M",diameter,"x",length));
    BillOfMaterials(str("M",diameter," nut"), ref=str("P_M",diameter));
    BillOfMaterials(str("M",diameter," washer"), ref=str("AL_M",diameter));
  }

	translate([-diameter/2, 0])
	square([diameter, length]);

	translate([-diameter, length-2*diameter])
	square([2*diameter, 1.5*diameter]);
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

module tslot_shapes_from_list(list, length=16){
  for (tslot=list){
    assign(x=tslot[0],
           y=tslot[1],
           angle=tslot[2])
    translate([x,y])
    rotate(angle)
    t_slot_shape(3,length);
  }
}

module tslot_holes_from_list(list){
  for (tslot=list){
    assign(x=tslot[0],
           y=tslot[1],
           width=tslot[2],
           angle=tslot[3])
    if(width>0)
      translate([x, y])
      rotate(angle)
      TSlot_holes(width=width);
    else
      translate([x, y])
      circle(r=m3_diameter/2);
  }
}

//how is this different from t_slot_bolt_washer_nut() ?
module tslot_parts_from_list(list, length=16){
  for (tslot=list){
    assign(x=tslot[0],
           y=tslot[1],
           width=tslot[2],
           angle=tslot[3])
    translate([x, y])
    rotate(angle)
    translate([0, width/2]){
      translate([0, 0, thickness]){
        M3_washer();

        translate([0,0,m3_washer_thickness])
        bolt(3,length);
      }

      translate([0,0,12-length]) //TODO: fix math
      rotate([180,0,0])
      M3_locknut();
    }
  }
}
