// Parametric reimplementation of Brook Drum's lasercut extruder
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

use <NEMA.scad>;
use <608zz_bearing.scad>;
use <rounded_square.scad>;

// Gears
use <small_extruder_gear.scad>
use <large_extruder_gear.scad>

use <tslot.scad>;
include <Metamaquina2.h>;
include <BillOfMaterials.h>;
include <nuts.h>;
include <washers.h>;
include <bolts.h>;

LCExtruder_nut_gap = false;

extruder_mount_holes_distance = X_rods_distance + 14;
idler_axis_position = [-12,21];
idler_bearing_position = idler_axis_position + [0.4,15.6];
motor_position = [45.5,35];
motor_angle = 28;
idler_angle = 0;
extruder_gear_angle = 40;
hobbed_bolt_position = [3,36.5];
thickness = 6;
HandleWidth = 5*thickness;
HandleHeight = 30;
position_of_holder_for_extruder_wires=[20,52];

////////////////////
//TODO: Move this somewhere else:
module M3_hole(){
  circle(r=m3_diameter/2);
}

module M4_hole(){
  circle(r=m4_diameter/2);
}
///////////////////

module handle_face(r=5, width=HandleWidth, height=HandleHeight){
  difference(){
    translate([-width/2,0])
    rounded_square([width, height], corners=[0,0,r,r]);

    for (i=[-1,1]){
      translate([i*(width/2+2), 2*height/3]) circle(r=6);
      translate([i*HandleWidth/6,5]) circle(r=4/2);
    }

    translate([-14.7/2,12])
    import("M_circle.dxf");
  }
}

module handle_sheet(){
  BillOfMaterials(category="Lasercut wood", partname="LCExtruder Handle");

  material("lasercut")
  linear_extrude(height=thickness)
  handle_face();
}

//!idler_side_face();
module idler_side_face(smooth_rod_cut_diameter=7.8){
  R=23;

  rotate(90)
  union(){
    difference(){
      hull(){
        rounded_square([2*R,R], corners=[0,R,R,0]);

        circle(r=6);

//The following code is a quick hack to make the idler side a bit larger so that the idler's small smooth rod is better attached to the lasercut sheet and also to give more room to a larger bolt (M3x16 instead of M3x12)
        translate([2,-2.5])
        rounded_square([2*R,R], corners=[0,R,R,0]);
      }

      M3_hole();

      rotate(-90)
      translate(idler_bearing_position - idler_axis_position)
      circle(r=smooth_rod_cut_diameter/2);

      //cut for the idler_back_face
      translate([R,R-thickness])
      square([50,thickness]);

      translate([R*(1+1/2),R])
      rotate(-180)
      t_slot_shape(3, 16);
    }
    translate([R,R-thickness/2])
    rotate(-90)
    TSlot_joints(width=R);
  }
}
//!idler_side_face();
module idler_back_face(){
  R=23;
  rounding = 5;
  idler_width = 5*thickness;
  idler_height = R+2+rounding;

  difference(){
    translate([-idler_width/2,0])
    rounded_square([idler_width,idler_height], corners=[0,0,rounding,rounding]);

    for (i=[-1,1])
      translate([i*HandleWidth/6,R])
      hull(){
        M4_hole();
        translate([0,-5]) M4_hole();      
      }

    for (i=[-1,1])
      translate([i*(2*thickness),0])
      t_slot_holes(width=R, thickness=thickness);
  }
}

module idler_back_sheet(){
  BillOfMaterials(category="Lasercut wood", partname="LCExtruder Idler Back");

  material("lasercut")
  linear_extrude(height=thickness)
  idler_back_face();
}

module idler_side_sheet(){
  BillOfMaterials(category="Lasercut wood", partname="LCExtruder Idler Side");

  material("lasercut")
  linear_extrude(height=thickness)
  idler_side_face();
}

module idler_spacer_5mm_sheet(){
  BillOfMaterials(/*category="Lasercut Acrylic", */partname="LCExtruder Idler 5mm Acrylic Spacer", ref="MM2_LC_SPC5");

  material("acrylic")
  linear_extrude(height=5)
  idler_spacer_face();
}

module idler_spacer_6mm_sheet(){
  BillOfMaterials(category="Lasercut wood", partname="LCExtruder Idler 6mm Spacer");

  material("lasercut")
  linear_extrude(height=6)
  idler_spacer_face();
}

module idler_spacer_face(){
  d = 8.3;
  D = 16;
  difference(){
    circle(r=D/2);
    circle(r=d/2);
  }
}

module handlelock(){
  r=3;
  translate([1,52]){
    hull(){
      rounded_square([11,15], corners=[r,r,r,r]);
      translate([10,-11]) circle(r=1);
    }
  }
}

module slice_numbering(n){
  translate([-22,3])
  for (i=[1:n])
    translate([i, 0])
    square([0.1,1]);
}

module slice1_face(){
  difference(){
    extruder_slice(bearing_slot=true, idler_axis=false, handle_lock=true);
    slice_numbering(1);
  }
}

module slice2_face(){
  difference(){
    extruder_slice(nozzle_holder2=true, idler_axis=true, idler_nut_gap=LCExtruder_nut_gap);
    slice_numbering(2);
  }
}

module slice3_face(){
  difference(){
    extruder_slice(nozzle_holder=true, idler_axis=true, filament_channel=true, mount_holes=true);
    slice_numbering(3);

    translate([40,0])
    slice_numbering(3);
  }
}

m3_diameter = 3;
module slice4_face(){
  difference(){
    extruder_slice(nozzle_holder2=true, motor_holder=true, idler_axis=true);
    slice_numbering(4);
  }
}

module slice5_face(){
  difference(){
    extruder_slice(bearing_slot=true, idler_axis=false, handle_lock=true);
    slice_numbering(5);
  }
}

module extruder_slice(motor_holder=false, bearing_slot=false, filament_channel=false, mount_holes=false, idler_axis=false, bottom_screw_holes=false, handle_lock=false, nozzle_holder=false, nozzle_holder2=false, idler_nut_gap=false){
  base_thickness = 10;
  r=base_thickness/2;
  H=58;
  epsilon = 0.21;
  NEMA_side = 48;
  NEMA_holes_distance = 15.5;
  k=3;
  nozzle_hole_width = 16;
  nozzle_hole_width2 = 14;
  608zz_diameter = 22;
  idler_axis_width = 7;
  base_length = extruder_mount_holes_distance+12;

  difference(){
    union(){
      //base
      translate([0,base_thickness/2]){
        hull(){
          for (i=[-1,1]){
            translate([i*base_length/2,0])
            circle(r=base_thickness/2);
          }
        }
      }

      if (motor_holder){
        translate(position_of_holder_for_extruder_wires)
        rounded_square([20,30], corners=[5,5,5,5]);

        hull(){
          translate([15,0])
          square([epsilon, H]);

          translate(motor_position)
          rotate(-motor_angle)
          translate([-NEMA_side/2,-NEMA_side/2])
          rounded_square([NEMA_side,NEMA_side], corners=[5,5,5,5]);
        }
      }

      difference(){
        union(){

          if (bearing_slot){
            translate(hobbed_bolt_position){
              intersection(){
                circle(r=16);
                
                translate([0,-18])
                square([18,2*18]);
              }
            }
          }

          translate([-23/2,0]){
            if (idler_axis)
              square([idler_axis_width,hobbed_bolt_position[1]]);

            translate([idler_axis_width,0])
            square([15 - idler_axis_width + 23/2,hobbed_bolt_position[1]]);

            if (handle_lock)
              handlelock();
          }

          translate([-4,hobbed_bolt_position[1]])
          square([15+4,H-hobbed_bolt_position[1]]);
        }

        translate(hobbed_bolt_position){
          circle(r=8/2);
          if (bearing_slot)
            circle(r=608zz_diameter/2);
        }

        translate(hobbed_bolt_position - [14,0])
        circle(r=23/2);
      }

      if (idler_axis){
        translate([-9 - 1.5*r, 0])
        rounded_square([1.5*r, hobbed_bolt_position[1] - 23/2], corners=[0,0,r,0]);
      }
    }

  //cut for an M4 washer
  translate([27,base_thickness])
  square([10, 1.5]);

  //bolt holes for keeping the 5 extruder sheets together:
  translate([11, 54])
  circle(r=m3_diameter/2);

  translate([-25, base_thickness/2])
  circle(r=m3_diameter/2);

  translate([11, 20])
  circle(r=m3_diameter/2);

  translate(idler_axis_position)
  circle(r=m3_diameter/2);

  if (idler_nut_gap){
    translate(idler_axis_position - [5,4.5])
    rounded_square([9,15], corners=[4.5,4.5,4.5,4.5]);
  }

  if (mount_holes){
    for (i=[-1,1])
      translate([i*extruder_mount_holes_distance/2, base_thickness/2])
      square([m4_diameter, base_thickness], center=true);
  }

  //////////////////

  if (nozzle_holder){
    //cuts for attaching the nozzle holder
    translate([-nozzle_hole_width/2-0.3,0])
    square([nozzle_hole_width,10]);
  }

  if (nozzle_holder2){
    //cuts for attaching the nozzle holder
    translate([-nozzle_hole_width2/2-0.3,0])
    square([nozzle_hole_width2,10]);
  }

  for (i=[-1,1])
    translate([i*nozzle_hole_width2/2-0.3,5])
    circle(r=m3_diameter/2);

  if (filament_channel){
    translate([-1.9,0]){
      square([3.2,70]);
      translate([-10,40]) square([10,30]);
    }

    //I'm not sure why the original Printrbot LC extruder had these cuts:
    translate(hobbed_bolt_position) translate([4,0]) rotate(90+45) square(12.5);
  }

  ///////////////
    if (motor_holder){
      for (i=[-1,1])
        for (j=[-1,1])
          translate(position_of_holder_for_extruder_wires)
          translate([10+i*5, 20+j*5])
          circle(r=m3_diameter/2);

      translate(motor_position){
        rotate(-motor_angle){
          circle(r=12);

          for (i=[-1,1]){
            for (j=[-1,1]){
              translate([i*NEMA_holes_distance, j*NEMA_holes_distance])
              hull()
              rotate(motor_angle){
                for (x=[-k,k]){
                  translate([x,0])
                    circle(r=m3_diameter/2);
                }
              }
            }
          }
        }
      }
    }
  ///////////////
    //holes for m3x35 screws to pack all 5 slices together
    for (i=[-1,1])
      translate([i*base_length/2, base_thickness/2])
      circle(r=m3_diameter/2);
  }
}

module slice1(){
  BillOfMaterials(category="Lasercut wood", partname="LCExtruder Slice #1");

  material("lasercut")
  linear_extrude(height=thickness)
  slice1_face();
}

module slice2(){
  BillOfMaterials(category="Lasercut wood", partname="LCExtruder Slice #2");

  material("lasercut")
  translate([0,0,1*thickness])
  linear_extrude(height=thickness)
  slice2_face();
}

//!slice3();
module slice3(){
  BillOfMaterials(category="Lasercut wood", partname="LCExtruder Slice #3");

  material("lasercut")
  translate([0,0,2*thickness])
  linear_extrude(height=thickness)
  slice3_face();
}

module slice4(){
  BillOfMaterials(category="Lasercut wood", partname="LCExtruder Slice #4");

  material("lasercut")
  translate([0,0,3*thickness])
  linear_extrude(height=thickness)
  slice4_face();
}

module slice5(){
  BillOfMaterials(category="Lasercut wood", partname="LCExtruder Slice #5");

  material("lasercut")
  translate([0,0,4*thickness])
  linear_extrude(height=thickness)
  slice5_face();
}

module handle(){
  { //TODO: Add these parts to the CAD model
    BillOfMaterials("M4 lock-nut", 4, ref="P_M4_ny");
    BillOfMaterials("M4 washer", 4, ref="AL_M4");//for the lock nuts
    BillOfMaterials("Compresison Spring CM1678 (6mm x 16.5mm) - TODO:check this!", 2, ref="CM1678");
    BillOfMaterials("M4 washer", 2, ref="AL_M4");//for the springs
  }

  nut_height = 3;
  handle_bolt_length = 70;

  union(){
    handle_sheet(width=HandleWidth);
    translate([-HandleWidth/6,5,handle_bolt_length - nut_height]){
      bolt(4, handle_bolt_length);
    }
    translate([HandleWidth/6,5,handle_bolt_length - nut_height]){
      bolt(4, handle_bolt_length);
    }
  }
}

module idler_bolt_subassembly(){
  length=30;
  BillOfMaterials(str("M8x", length, "mm Smooth Rod"), ref="MM2_IDLER_ROD");

  //bolt body
  material("metal")
  translate([0,0,-length])
  cylinder(r=7.8/2, h=length);
}

module idler(){
  { //TODO: Add these parts to the CAD model

    //for the idler axis
    BillOfMaterials("M3x30 bolt", ref="H_M3x30");
  }

  R=23;
  bearing_thickness = 7;

  rotate([90,0])
    translate([0,0,5*thickness])
    translate(idler_bearing_position)
    idler_bolt_subassembly();

  rotate([90,0]){
    translate(idler_axis_position)
    rotate(-idler_angle)
    {
      idler_side_sheet();

      if (LCExtruder_nut_gap){
        // we must make sure that the nut_gap
        // is large enough for this nut to fit inside
        translate([0,0,thickness]) M3_nut();
      }

      translate(idler_bearing_position - idler_axis_position)
      // give some room to accomodate lasercut and spacer
      // thickness variations
      translate([0,0, thickness+0.5]){
        idler_spacer_5mm_sheet();

        // give some room to accomodate lasercut and spacer
        // thickness variations
        translate([0,0, thickness-1.0]){
          608zz_bearing(true);

          translate([0,0,bearing_thickness])
            idler_spacer_5mm_sheet();
        }
      }

      translate([0,0,4*thickness])
      idler_side_sheet();
    
      translate([-R+thickness, R, 5*thickness/2])
      rotate([0,-90,0])
      idler_back_sheet();
    }
  }
}

module extruder_block(){

  { //TODO: Add these parts to the CAD model
    BillOfMaterials("M3x30 bolt", 2, ref="H_M3x30"); // for attaching the jhead_body

    { // to hold the MDF sheets together
      BillOfMaterials("M3x35 bolt", 5, ref="H_M3x35");
      BillOfMaterials("M3 washer", 5*3, ref="AL_M3");
      BillOfMaterials("M3 lock-nut", 5, ref="P_M3_ny");
      //TODO: decide wheter we'll use M3x30 or M3x35 in some places here
    }
  }

  rotate([90,0]){
    slice1();
    slice2();
    slice3();
    slice4();
    slice5();
  }
}

//JHead MKIV nozzle
module nozzle(length=50){
  material("rubber"){
    difference(){
      union(){
        translate([0,0,5])
        cylinder(r=8,h=5);

        cylinder(r=6,h=5);

        translate([0,0,-length+10])
        cylinder(r=8,h=length-10);
      }
      translate([0,0,-length])
      cylinder(r=3/2,h=length+11);
    }
  }
}

module hobbed_bolt(){
  BillOfMaterials("Hobbed bolt", ref="MM2_HBLT");
  // TODO: use <hobbed_bolt.h> values to draw hobbed bolt 3D model
  material("metal")
  rotate([90,0]){
    cylinder(r=13.0/2, h=5, $fn=6);
    translate([0,0,5])
    cylinder(r=8.0/2, h=50);
  }
}
//!hobbed_bolt();

washer_thickness = 1.5;
module lasercut_extruder(){
  rotate(90)
  union(){
    translate([0,2.5*thickness]){
      extruder_block();
      idler();
    }

    translate([7,0,58]){
      rotate([0,-90,0]){
        rotate([0,0,-90]){
          handle();
        }
      }
    }

    //nozzle(); by Sara

    translate([hobbed_bolt_position[0], -5*thickness/2 - 2*washer_thickness, hobbed_bolt_position[1]])
    rotate([0,extruder_gear_angle])
    rotate([90,0])
    extruder_gear(teeth=37);

    translate([hobbed_bolt_position[0], 0, hobbed_bolt_position[1]]) {
        translate([0,-30,0]) rotate([180,0,0]) hobbed_bolt();
        // TODO: put washers in the right place
        translate([0,5*thickness/2+washer_thickness,0])
        rotate([-90,0,0])
        M8_locknut();
    }

    translate([hobbed_bolt_position[0], -3*thickness/2, hobbed_bolt_position[1]])
    rotate([90,0])
    608zz_bearing(true);

    translate([hobbed_bolt_position[0], 3*thickness/2+7, hobbed_bolt_position[1]])
    rotate([90,0])
    608zz_bearing(true);

    translate([motor_position[0], -thickness/2, motor_position[1]])
    rotate([-90,0])
    rotate(motor_angle)
    {
      %NEMA17_subassembly();

      translate([0,0,-2*thickness - 2*washer_thickness])
      rotate([180,0])
      motor_gear(teeth=11);
    }
  }
}

lasercut_extruder();
%translate([0,0,-thickness]) XCarriage_bottom_sheet();

