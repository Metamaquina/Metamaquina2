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
include <PowerSupply.h>;
include <bolts.h>;
include <washers.h>;
include <render.h>;
include <rounded_square.scad>;
include <tslot.scad>;

box_height = 70; //TODO
detail = false;
mount_positions = [[5, 6],
                  [6, PowerSupply_height - 22],
                  [PowerSupply_width - 5, 5],
                  [PowerSupply_width - 12, PowerSupply_height - 21]
];

module PowerSupply_mount_holes(){
  wiring_radius = 8;

  for (p = mount_positions){
    translate(p)
    circle(r=5/2);
  }

  translate([thickness/2 + metal_sheet_thickness,-(box_height-thickness)/2 - bottom_offset])
  TSlot_holes(width=(box_height-thickness)/2);

  translate([PowerSupply_width-thickness/2,-(box_height-thickness)/2 - bottom_offset])
  TSlot_holes(width=(box_height-thickness)/2);

  translate([thickness + metal_sheet_thickness,-box_height + bottom_offset + thickness/2])
  rotate(-90)
  TSlot_holes(width=2*(PowerSupply_width - metal_sheet_thickness - 2*thickness)/3);

  translate([thickness + metal_sheet_thickness + (PowerSupply_width - metal_sheet_thickness - 2*thickness)/3,-box_height + bottom_offset + thickness/2])
  rotate(-90)
  TSlot_holes(width=2*(PowerSupply_width - metal_sheet_thickness - 2*thickness)/3);

  translate([PowerSupply_width/2,-box_height+bottom_offset + wiring_radius + thickness + 2])
    //hole for power supply wiring
    circle(r=wiring_radius);
}

module oldHiquaPowerSupply(){
  BillOfMaterials("Power Supply");

  {//TODO: Add this to the CAD model
    BillOfMaterials("Power Supply cable");
  }

  material("metal")
  cube([PowerSupply_thickness, PowerSupply_width, PowerSupply_height]);
}

metal_sheet_thickness = 1;
bottom_offset = 11;
top_offset = 5;
pcb_thickness = 2;
pcb_height = 9 - pcb_thickness;
pcb_bottom_advance = 2;

module circle_pattern(r, spacing_x, spacing_y, x,y){
  $fn=6;
  for (i=[1:x]){
    for (j=[1:y]){
      translate([(i+(1/2)*(j%2)) * spacing_x, j * spacing_y])
      circle(r=r);
    }
  }
}

module HiquaPowerSupply(){
  BillOfMaterials("Power Supply", ref="T-200-12");

  material("metal"){
    cube([PowerSupply_width, PowerSupply_height, metal_sheet_thickness]);

    translate([PowerSupply_width - metal_sheet_thickness, 0])
    cube([metal_sheet_thickness, PowerSupply_height, PowerSupply_thickness]);

    translate([0,bottom_offset])
    difference(){
      cube([PowerSupply_width, PowerSupply_height - bottom_offset - top_offset, PowerSupply_thickness]);

      translate([metal_sheet_thickness, metal_sheet_thickness])
      cube([PowerSupply_width - 2*metal_sheet_thickness, PowerSupply_height - bottom_offset - top_offset - 2*metal_sheet_thickness, PowerSupply_thickness - metal_sheet_thickness]);

      if (detail){
        translate([-23.5, 7, PowerSupply_thickness - 1.5*metal_sheet_thickness]){
          linear_extrude(height=2*metal_sheet_thickness)
          circle_pattern(r=4.6/2, spacing_x=6, spacing_y = 5, x=21,y=34);
        }
      }
    }
  }

  material("pcb"){
    translate([metal_sheet_thickness, -pcb_bottom_advance, pcb_height])
    cube([PowerSupply_width - 2*metal_sheet_thickness, PowerSupply_height - top_offset, pcb_thickness]);
  }
}

module HiquaPowerSupply_subassembly(th=thickness){
  HiquaPowerSupply();
  PowerSupplyBox();

  for (p = mount_positions){
    translate([PowerSupply_width - p[0], p[1]]){
      translate([0, 0, -th - m3_washer_thickness]){
        M3_washer();

        rotate([180,0])
        M3x10();
      }
    }
  }
}

HiquaPowerSupply_subassembly();

module PowerSupplyBox_side_face(){
  difference(){
    square([PowerSupply_width-metal_sheet_thickness - 2*thickness, box_height]);

    translate([-thickness, box_height/2])
    rotate(-90)
    t_slot_shape(3,16);

    translate([PowerSupply_width-thickness-metal_sheet_thickness, box_height/2])
    rotate(90)
    t_slot_shape(3,16);

    translate([0,thickness/2])
      rotate(-90)
      TSlot_holes(2*(PowerSupply_width - metal_sheet_thickness - 2*thickness)/3);

    translate([(PowerSupply_width - metal_sheet_thickness - 2*thickness)/3,thickness/2])
      rotate(-90)
      TSlot_holes(2*(PowerSupply_width - metal_sheet_thickness - 2*thickness)/3);
  }

  translate([-thickness/2, 0])
  t_slot_joints(width=box_height, thickness=thickness);

  translate([PowerSupply_width-metal_sheet_thickness - (1+1/2)*thickness, 0])
  t_slot_joints(width=box_height, thickness=thickness);
}

//!test_PowerSupplyBox_bottom_face_symmetry();
module test_PowerSupplyBox_bottom_face_symmetry(){
  //This must result in an empty geometry

  difference(){
    PowerSupplyBox_bottom_face();

    translate([PowerSupply_width - metal_sheet_thickness - 2*thickness+0, 0])
mirror([1,0])  PowerSupplyBox_bottom_face();
  }
}

module PowerSupplyBox_bottom_face(){
  difference(){
    square([PowerSupply_width-2*thickness-metal_sheet_thickness, PowerSupply_thickness-thickness]);


    translate([(PowerSupply_width - metal_sheet_thickness - 2*thickness)/3,PowerSupply_thickness])
    rotate(180)
    t_slot_shape(3,16);


    translate([2*(PowerSupply_width - metal_sheet_thickness - 2*thickness)/3,PowerSupply_thickness])
    rotate(180)
    t_slot_shape(3,16);

    translate([(PowerSupply_width - metal_sheet_thickness - 2*thickness)/3,-thickness])
    t_slot_shape(3,16);


    translate([2*(PowerSupply_width - metal_sheet_thickness - 2*thickness)/3,-thickness])
    t_slot_shape(3,16);
  }

  translate([0, PowerSupply_thickness - thickness/2])
  rotate(-90)
  t_slot_joints(2*(PowerSupply_width - metal_sheet_thickness - 2*thickness)/3, thickness=thickness);

  translate([(PowerSupply_width - metal_sheet_thickness - 2*thickness)/3, PowerSupply_thickness - thickness/2])
  rotate(-90)
  t_slot_joints(2*(PowerSupply_width - metal_sheet_thickness - 2*thickness)/3, thickness=thickness);

  translate([0, -thickness/2])
  rotate(-90)
  t_slot_joints(2*(PowerSupply_width - metal_sheet_thickness - 2*thickness)/3, thickness=thickness);

  translate([(PowerSupply_width - metal_sheet_thickness - 2*thickness)/3, - thickness/2])
  rotate(-90)
  t_slot_joints(2*(PowerSupply_width - metal_sheet_thickness - 2*thickness)/3, thickness=thickness);
}

module PowerSupplyBox_front_face(){
  difference(){
    PowerSupplyBox_front_plain_face();

    translate(ONOFF_Switch_position)
    ONOFF_Switch_mount_hole();
  }
}

module PowerSupplyBox_front_plain_face(){
  pcb_clearance = 1;//clearance to deal with slight variations in the dimensions of each unit providade by the power supply manufacturer

  difference(){
    square([PowerSupply_thickness, box_height]);
    translate([0,box_height-(bottom_offset+pcb_bottom_advance+pcb_clearance)])
    rounded_square([9+2+pcb_clearance,bottom_offset+pcb_bottom_advance+pcb_clearance], corners=[0,2,0,0]);

    translate([-thickness,(box_height-thickness)/2])
    rotate(-90)
    t_slot_shape(3,16);

    translate([PowerSupply_thickness - thickness/2,0])
    TSlot_holes(width=box_height);
  }

  translate([- thickness/2,(box_height-thickness)/4])
  t_slot_joints((box_height-thickness)/2, thickness=thickness);
}

module PowerSupplyBox_back_face(){
  difference(){
    PowerSupplyBox_front_plain_face();

    translate([PowerSupply_thickness-thickness-PSU_Female_border_height/2 - 3, (box_height - bottom_offset)/2]){
      rotate(-90)
      PowerSupply_FemaleConnector_mount_holes();
    }
  }
}

module PowerSupplyBox_side_sheet(){
  BillOfMaterials(category="Lasercut wood", partname="Power Supply Box side sheet");

  material("lasercut")
  linear_extrude(height=thickness)
  PowerSupplyBox_side_face();
}

module PowerSupplyBox_bottom_sheet(){
  BillOfMaterials(category="Lasercut wood", partname="Power Supply Box bottom sheet");

  material("lasercut")
  linear_extrude(height=thickness)
  PowerSupplyBox_bottom_face();
}

module PowerSupplyBox_front_sheet(){
  BillOfMaterials(category="Lasercut wood", partname="Power Supply Box front sheet");

  material("lasercut")
  linear_extrude(height=thickness)
  PowerSupplyBox_front_face();

  ONOFF_Switch();
}

module PowerSupplyBox_back_sheet(){
  BillOfMaterials(category="Lasercut wood", partname="Power Supply Box back sheet");

  material("lasercut")
  linear_extrude(height=thickness)
  PowerSupplyBox_back_face();

  translate([PowerSupply_thickness-thickness-PSU_Female_border_height/2, (box_height - bottom_offset)/2])
  rotate(90)
  rotate([180,0,0])
  PowerSupply_FemaleConnector();
}


module PowerSupplyBox(){
  translate([thickness,-box_height+bottom_offset,PowerSupply_thickness - thickness])
  PowerSupplyBox_side_sheet();

  translate([thickness,-box_height+bottom_offset+thickness,0])
  rotate([90,0,0])
  PowerSupplyBox_bottom_sheet();

  translate([thickness,-box_height+bottom_offset])
  rotate([0,-90,0])
  PowerSupplyBox_front_sheet();

  translate([PowerSupply_width - metal_sheet_thickness,-box_height+bottom_offset,0])
  rotate([0,-90,0])
  PowerSupplyBox_back_sheet();
}

module ONOFF_Switch(){
  BillOfMaterials("ON/OFF DPST Switch", ref="KCD1_104N");
  //TODO: Implement-me
}

ONOFF_Switch_position = [PowerSupply_thickness/2,(box_height-thickness)/2];
ONOFF_Switch_mount_width = 13;
ONOFF_Switch_mount_height = 19;
module ONOFF_Switch_mount_hole(){
  translate([-ONOFF_Switch_mount_width/2,-ONOFF_Switch_mount_height/2])
  square([ONOFF_Switch_mount_width, ONOFF_Switch_mount_height]);
}

PSU_Female_border_height=22;
female_connector_bolts_distance = 40;
module PowerSupply_FemaleConnector(){
  BillOfMaterials("Power supply female connector", ref="AS02");

  border_height=PSU_Female_border_height;
  border_width=30.2;
  border_thickness = 4.84;
  wings_thickness = 3.5;
  depth = 13.1;

  material("ABS"){
    difference(){
      union(){
        translate([0,0,-depth])
        linear_extrude(height=depth)
        PowerSupply_FemaleConnector_large_hole();

        linear_extrude(height=border_thickness)
        translate([-border_width/2,-border_height/2])
        rounded_square([border_width, border_height], corners=[2,2,2,2]);

        linear_extrude(height=wings_thickness)
        hull(){
          translate([-border_width/2,-border_height/2])
          rounded_square([border_width, border_height], corners=[2,2,2,2]);

          for (i=[-1,1])
            translate([i*female_connector_bolts_distance/2, 0])
            circle(r=6);
        }
      }

      translate([0,0,border_thickness+0.1-depth])
      linear_extrude(height=depth)
      power_supply_generic_connector_shape(
        width=24.6,
        height=16.4,
        bevel=4.2,
        r1=1,
        r2=2);

      for (i=[-1,1]){
        translate([i*female_connector_bolts_distance/2,0,-0.1])
        cylinder(r=m3_diameter/2, h=10);

        translate([i*female_connector_bolts_distance/2,0,2])
        cylinder(r1=m3_diameter/2, r2=m3_diameter, h=3.9 - 2 + 0.1);
      }
    }
  }
}

module PowerSupply_FemaleConnector_large_hole(clearance=0.25){
  power_supply_generic_connector_shape(
    width=27+clearance,
    height=18.9+clearance,
    bevel=3,
    r1=1,
    r2=2);
}

module PowerSupply_FemaleConnector_mount_holes(){
  PowerSupply_FemaleConnector_large_hole();

  for (i=[-1,1]){
    translate([i*female_connector_bolts_distance/2, 0])
    circle(r=m3_diameter/2);
  }
}

module power_supply_generic_connector_shape(width, height, bevel, r1, r2){
  hull(){
    translate([-width/2,-height/2])
    rounded_square([width, height-bevel], corners=[r2,r2,r1,r1]);

    translate([-width/2 + bevel,-height/2])
    rounded_square([width-2*bevel, height], corners=[r1,r1,r1,r1]);
  }
}
