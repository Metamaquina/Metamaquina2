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

extruder_wiring_radius = 6;
YEndstopHolder_distance = 66;

//utils
//use <utils.scad>;
//use <mm2logo.scad>;
use <rounded_square.scad>;
use <tslot.scad>;

//subassemblies
include <endstop.h>;
include <heated_bed.h>;
use <lasercut_extruder.scad>;
use <RAMBo.scad>;
use <jhead.scad>;

//parts
include <NEMA.h>;
include <coupling.h>;
include <washers.h>;
include <bolts.h>;
include <nuts.h>;
include <spacer.h>;
include <lm8uu_bearing.h>;
include <jhead.h>;
include <PowerSupply.h>;
use <608zz_bearing.scad>;
use <domed_cap_nuts.scad>;
use <belt-clamp.scad>;
use <cable_clips.scad>;

//3d printed parts
include <ZLink.h>;
use <bar-clamp.scad>;

//include <Metamaquina2.scad>

rods_radius_clearance = 0.04; //extra room for the X and Z rods

//For the actual build volume we avoid using the marginal
//region around the heated bed

HeatedBed_X = BuildVolume_X + 15; // 215 mm
HeatedBed_Y = BuildVolume_Y + 20; // 220 mm

hack_couplings = 5; // for astethical purposes, the z-couplings are animated rotating <hack_couplings> times slower than the correct mechanical behaviour

time = $t;
function carx_demo(time) = sin(360*time*7)*BuildVolume_X/2;
function cary_demo(time) = cos(360*time*7)*BuildVolume_Y/2;
//function carz_demo(time) = (0.5+0.5*sin(360*time))*0.3*BuildVolume_Y/2 + 0.7*BuildVolume_Y/2;
function carz_demo(time) = time*BuildVolume_Z;
function coupling_demo(time) = (360*carz_demo(time)/1.25)/hack_couplings;

/* Positioning of the extruder assembly */
XCarPosition = -100; //carx_demo(time);
YCarPosition = 0; //cary_demo(time);
ZCarPosition = 150; //carz_demo(time);

//-------------------------

//machine configs:

/* whether or not to add holes for a PowerSupply manufactured by Hiqua and sold 
by Nodaji in Brazil */
HIQUA_POWERSUPPLY=true;

/* dimensions of the machine feet */
feetwidth = 50;
feetheight = 12;

/*Here are a bunch of constants that determine the overall positioning 
and dimensions of the several acrylic/plywood panels:*/

BuildPlatform_SidePanels_distance = 40;
SidePanels_distance = HeatedBed_X + 2*BuildPlatform_SidePanels_distance;

RightPanel_baseheight = 92;
RightPanel_basewidth = 2*(HeatedBed_Y)+10;

//Z_rods_distance = 388; //PrusaAir2
Z_rods_distance = SidePanels_distance + 2*(z_rod_z_bar_distance + NEMA17_width/2 + 5);

//TODO: machine_width = ?;
machine_height = BuildVolume_Z + 207.2; //why?

XZStage_offset = 20;
XZStage_position = RightPanel_basewidth/2 + XZStage_offset;
z_max_endstop_x = XZStage_position - 41;
z_max_endstop_y = machine_height - 19;

z_min_endstop_x = z_max_endstop_x - 28;
z_min_endstop_y = 109;

baseh = 35;
ArcPanel_rear_advance = 105;
horiz_bars_length = SidePanels_distance + 2*(m8_nut_height + m8_washer_thickness);
base_bars_height = 17;
base_bars_Zdistance = 50;

bar_cut_length=13;
Y_rod_length = RightPanel_basewidth - 2*(bar_cut_length + m8_diameter/2) + 24;
Y_rod_height = base_bars_Zdistance + base_bars_height + 10.2;//TODO
BottomPanel_width=60;
Z_rod_sidepanel_distance = (Z_rods_distance - SidePanels_distance)/2 + thickness;

heatedbed_spring_length = 13; //TODO: 
heatedbed_spring_compressed_length = 7.4; //TODO: 
compressed_spring=1;

YPlatform_height = Y_rod_height + lm8uu_diameter/2;
pcb_height = YPlatform_height + thickness + 
heatedbed_spring_compressed_length*compressed_spring + heatedbed_spring_length*(1-compressed_spring);

BuildPlatform_height = pcb_height + heated_bed_pcb_thickness + heated_bed_glass_thickness;

//machine_x_dim is the actual width of the whole machine
machine_x_dim = Z_rods_distance+2*(lm8uu_diameter/2+thickness);

XEnd_extra_width = 30;
XEnd_box_size = lm8uu_diameter/2 + z_rod_z_bar_distance + ZLink_rod_height;

//height of the bottom panel acrylic/plywood sheet:
BottomPanel_zoffset = feetheight + NEMA17_length + 2;

Z_rod_length = machine_height - BottomPanel_zoffset + thickness;
Z_bar_length = thickness + machine_height - BottomPanel_zoffset - motor_shaft_length;

margin=4;
tslot_extra=thickness+margin; //todo
XPlatform_width = X_rods_distance + X_rods_diameter + 2*margin + 2* tslot_extra;
XEnd_width = XPlatform_width+XEnd_extra_width;
num_extruders = 1;
extra_extruder_length = 50; //TODO
XCarriage_padding = 6;
XCarriage_nozzle_hole_radius = 20;
XCarriage_width = XPlatform_width + 22;
//XCarriage_width = XPlatform_width;
//XCarriage_width = XEnd_width;
XCarriage_length = 82 + (num_extruders-1) * extra_extruder_length;
XCarriage_lm8uu_distance = XCarriage_length - 30;

nozzle_hole_width = 50;
nozzle_hole_length = machine_x_dim - 2*XEnd_box_size - nozzle_hole_width - 2*thickness - 2*20;

belt_offset = 26;
belt_width=5;
belt_clamp_height = 9;
PulleyRadius = 6;
IdlerRadius = 11;
XMotor_height = 31;
XIdler_height = XMotor_height + PulleyRadius - IdlerRadius;
X_rod_length = machine_x_dim - 2*thickness;
X_rod_height = XMotor_height + PulleyRadius - lm8uu_diameter/2 - 2*thickness;

XCarriage_height = thickness + X_rod_height + lm8uu_diameter/2;

nozzle_tip_distance = jhead_length-jhead_instalation_depth - thickness - XCarriage_height;
echo(str("nozzle_tip_distance:", nozzle_tip_distance));
 
RightPanel_backwidth = 55;
RightPanel_backheight = machine_height - RightPanel_baseheight;

rear_backtop_advance = XZStage_position - (XPlatform_width/2 + XEnd_extra_width + 10) - RightPanel_backwidth;

RightPanel_topheight = 30;
RightPanel_topwidth = XZStage_position + 30 - rear_backtop_advance;

ArcPanel_width = SidePanels_distance - 2 * thickness;
ArcPanel_height = 140; //TODO: make it depend on the machine height

//code modifyed below

SidePanel_TSLOT_SHAPES = [ 
//parameters => [x, y, angle]
  [rear_backtop_advance+RightPanel_topwidth-25-5, machine_height+thickness, 180],
  [rear_backtop_advance+RightPanel_topwidth-25-5, machine_height+thickness-309.5, 0],
];

TopPanel_TSLOTS = [ 
//parameters => [x, y, width, angle]
  [Z_rods_distance/2-Z_rod_sidepanel_distance + thickness/2, 0, 0, 0],
];

BottomPanel_TSLOTS = [
//parameters => [x, y, width, angle]
  [Z_rods_distance/2-Z_rod_sidepanel_distance + thickness/2, 0, 0, 0],
];

module calibracao(){
  import("calibracao.dxf");
}

// 2d shapes for laser-cutting:

module RodEndTop_face(){
union(){
  translate([30,0,0]){
    RodEnd_face(z_rod_z_bar_distance+8);
    translate([-30,0,0])
    RodEnd_face(0, third_hole=false);
    }
  }
}

module RodEndBottom_face(){
union(){
  translate([0,0,0]){
    RodEnd_face(0, third_hole=false);
    translate([-30,0,0])
    RodEnd_face(0, third_hole=false);
    }
  }
}

//!MachineRightPanel_face();
module MachineRightPanel_face(){
  difference(){
    union(){
     MachineSidePanel_plainface();

      //tslots for top panel
     translate([270,57,0])
     rotate([0,0,90])
     TSlot_joints();

     //tslots for bottom panel
     translate([270,56.9+303.3,0])
     rotate([0,0,90])
     TSlot_joints();
    }

    union(){
      tslot_shapes_from_list(SidePanel_TSLOT_SHAPES);

      translate([245,57+40,0])
      circle(r = 2.9*2.54/2); //M5

      translate([245,56.9+303.3-40,0])
      circle(r = 2.9*2.54/2);
    }
  }
}

//!MachineSidePanel_plainface();
module MachineSidePanel_plainface(){
  r1=0.1;
  r2=60;
  H=150;
  k=19;

  difference(){
    //back
    translate([rear_backtop_advance+k+90-1, RightPanel_baseheight-35])
    square([60, RightPanel_backheight+35]);

    translate([rear_backtop_advance+k+114, RightPanel_baseheight+72])
    rotate([180,0,90])
    scale(0.5) calibracao();
  }
}

module TopPanel_holes(){ 
  translate([Z_rods_distance/2,0]){
    //holes for Zrod and Zbar
    circle(r = m8_diameter/2 + rods_radius_clearance);

    translate([30,0])
    circle(r = m8_diameter/2 + rods_radius_clearance);

    translate([8, 0])
    M3_hole();

    translate([-z_rod_z_bar_distance - 8, -8])
    M3_hole();

    translate([-z_rod_z_bar_distance - 8, 8])
    M3_hole();

    translate([-z_rod_z_bar_distance - 8+68, -8])
    M3_hole();

    translate([-z_rod_z_bar_distance - 8+68, 8])
    M3_hole();

    translate([-59, -25,0])
	  //TSlot_holes(width=XEnd_box_size);
	  TSlot_holes(width=50);

    translate([-z_rod_z_bar_distance,0]){
      //This hole's diameter is considerably larger than the threaded rod diameter
      // in order to allow slightly bent rods to freely move. Otherwise, we would potentially have more whobble as a result of a tightly fixed rod.
      circle(r=(m8_diameter+4)/2);
    }
  }
}

//!MachineTopPanel_face();
module MachineTopPanel_face(){
  sidewidth=78;
  difference(){
      translate([machine_x_dim/2 - sidewidth,-30])
      rounded_square([sidewidth+45, 60], corners=[0, 30, 0, 30]);                             

    TopPanel_holes(); 
  }
}

module BottomPanel_holes(){
    //holes for Z rods
    translate([Z_rods_distance/2,0]){
      circle(r=m8_diameter/2 + rods_radius_clearance);

      translate([30,0])
      circle(r = m8_diameter/2 + rods_radius_clearance);

      translate([30, -8]) M3_hole();
      translate([30, 8]) M3_hole();

      translate([0, -8]) M3_hole();
      translate([0, 8]) M3_hole();
    }

    //holes for ZMotors
    translate([Z_rods_distance/2 - z_rod_z_bar_distance, 0])
    NEMA17_holes(r=27/2); //This should be large enough to let the coupling pass through the hole

rotate([0,0,0])
  translate([Z_rods_distance/2 - Z_rod_sidepanel_distance + thickness/2, -25,0])
	  //TSlot_holes(width=XEnd_box_size);
	  TSlot_holes(width=50);
}

//!MachineBottomPanel_face();
module MachineBottomPanel_face(){
  render(){
    difference(){
      translate([(machine_x_dim/2-78),-30])
      rounded_square([78+45, 60], corners=[0, 30, 0, 30]);      

      BottomPanel_holes();
    }
  }
}

// 3d preview of lasercut plates:

module RodEnd_ZTopRight_sheet(){
  BillOfMaterials(category="Lasercut wood", partname="RodEnd Z Top Right");

  translate([Z_rods_distance/2+30, -XZStage_offset, machine_height+thickness])
  rotate([0,0,180])
  RodEndTop_sheet();
}

module RodEnd_ZBottomRight_sheet(){
  BillOfMaterials(category="Lasercut wood", partname="RodEnd Z Bottom Right");
  translate([Z_rods_distance/2, -XZStage_offset, BottomPanel_zoffset - thickness])
  rotate([0,0,180])
  RodEndBottom_sheet();
}

module RodEndTop_sheet(){
  {//TODO: Add these parts to the CAD model
    BillOfMaterials("M3x25 bolt", 3);
    BillOfMaterials("M3 washer", 3);
    BillOfMaterials("M3 lock-nut", 3);
  }

  material("lasercut")
  linear_extrude(height=thickness)
  RodEndTop_face();
}

module RodEndBottom_sheet(){
  {//TODO: Add these parts to the CAD model
    BillOfMaterials("M3x20 bolt", 2);
    BillOfMaterials("M3 washer", 2);
    BillOfMaterials("M3 lock-nut", 2);
  }

  material("lasercut")
  linear_extrude(height=thickness)
  RodEndBottom_face();
}

module MachineRightPanel_sheet(){
  BillOfMaterials(category="Lasercut wood", partname="Machine Right Panel");

  translate([SidePanels_distance/2, RightPanel_basewidth/2, 0])
  rotate([0,0,-90])
  rotate([90,0,0]){
    material("lasercut")
    linear_extrude(height=thickness)
    MachineRightPanel_face();
  }
}

//!MachineTopPanel_sheet();
module MachineTopPanel_sheet(){
  BillOfMaterials(category="Lasercut wood", partname="Machine Top Panel");

  {//TODO: Add these parts to the CAD model
    BillOfMaterials("M3x25 bolt", 2);
    BillOfMaterials("M3 washer", 2);
    BillOfMaterials("M3 lock-nut", 2);
  }

  translate([0,-XZStage_offset,machine_height]){
    material("lasercut")
    linear_extrude(height=thickness)
    MachineTopPanel_face();

    tslot_parts_from_list(TopPanel_TSLOTS);
  }
}

module MachineBottomPanel_sheet(){
  BillOfMaterials(category="Lasercut wood", partname="Machine Bottom Panel");

  translate([0,-XZStage_offset,BottomPanel_zoffset]){
    material("lasercut")
    linear_extrude(height=thickness)
    MachineBottomPanel_face();

  translate([0,0,6])
  rotate([180,0,0])
    tslot_parts_from_list(BottomPanel_TSLOTS);
  }
}

module Z_couplings(){
  translate([machine_x_dim/2 - thickness - lm8uu_diameter/2 - z_rod_z_bar_distance, -XZStage_offset, BottomPanel_zoffset + motor_shaft_length - coupling_shaft_depth])
  coupling();
}

module ZRods(){
  BillOfMaterials(str("M8x",Z_rod_length,"mm Smooth Rod"), 2);

  material("metal"){
    translate([machine_x_dim/2 - thickness - lm8uu_diameter/2, -XZStage_offset,  BottomPanel_zoffset])
    cylinder(r=8/2, h=Z_rod_length);

    translate([machine_x_dim/2 - thickness - lm8uu_diameter/2+30, -XZStage_offset,  BottomPanel_zoffset])
    cylinder(r=8/2, h=Z_rod_length);
  }
}

module ZBars(){
  BillOfMaterials(str("M8x",Z_bar_length,"mm Threaded Rod"), 2);

  material("threaded metal"){
    translate([machine_x_dim/2 - thickness - lm8uu_diameter/2 - z_rod_z_bar_distance, -XZStage_offset, BottomPanel_zoffset + motor_shaft_length])
    cylinder(r=m8_diameter/2, h=Z_bar_length);
  }
}

module LaserCutPanels(){
  MachineTopPanel_sheet();
  MachineRightPanel_sheet();
  MachineBottomPanel_sheet();
  RodEnd_ZTopRight_sheet();
  RodEnd_ZBottomRight_sheet();
}

module ZMotors(){
  translate([Z_rods_distance/2 - z_rod_z_bar_distance, -XZStage_offset, BottomPanel_zoffset])
  rotate([180,0,0]) rotate(90) NEMA17_subassembly();
}

module ZAxis(){
  ZMotors();
  ZRods();
  ZBars();
  Z_couplings();
}

//!LaserCutPanels();
module CalibrationZBars(){
  LaserCutPanels();
  ZAxis();
}

CalibrationZBars();
