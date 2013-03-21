// Reimplementation of Brook Drum's lasercut extruder
//
// (c) 2013 Felipe C. da S. Sanches <fsanches@metamaquina.com.br>
// Licensed under the terms of the GNU General Public License
// version 3 (or later).

use <NEMA.scad>;
use <rounded_square.scad>;
use <thingiverse/12789/TZ_Huxley_extruder_gears.scad>;
use <tslot.scad>;
include <Metamaquina-config.scad>;

mount_holes_distance = 40; //TODO: XRods_distance + 7
idler_axis_position = [-12,21];
idler_bearing_position = idler_axis_position + [0.4,15.6];
motor_position = [45.5,35];
motor_angle = -24;
hobbed_bolt_position = [3,36.5];
thickness = 6;
HandleWidth = 5*thickness;
HandleHeight = 30;
default_sheet_color = [0.9, 0.7, 0.45, 0.9];

module bolt_head(r, h){
  difference(){
    cylinder(r=r, h=h, $fn=60);
    translate([0,0,h/2]){
      cylinder(r=0.6*r, h=h, $fn=6);
    }
  }
}

module bolt(dia, length){
  color("silver"){
    bolt_head(r=dia, h=dia);
    translate([0,0,-length]){
      cylinder(r=dia/2, h=length, $fn=60);
    }
  }
}

module handle_face(r=5, width=HandleWidth, height=HandleHeight){
  difference(){
    translate([-width/2,0])
    rounded_square([width, height], corners=[0,0,r,r]);

    for (i=[-1,1]){
      translate([i*(width/2+2), 2*height/3]) circle(r=6);
      hull(){
        translate([i*HandleWidth/6,10]) circle(r=4/2, $fn=20);
        translate([i*HandleWidth/6,4]) circle(r=4/2, $fn=20);
      }
    }
  }
}

module handle_sheet(c=default_sheet_color){
  color(c){
    linear_extrude(height=thickness){
      handle_face();
    }
  }
}

module M3_hole(){
  circle(r=m3_diameter/2, $fn=20);
}

module M4_hole(){
  circle(r=m4_diameter/2, $fn=20);
}

//!idler_side_face();
module idler_side_face(){
  R=23;
  rotate(90)
  union(){
    difference(){
      hull(){
        rounded_square([2*R,R], corners=[0,R,R,0]);
        circle(r=6);
      }

      M3_hole();

      rotate(-90)
      translate(idler_bearing_position - idler_axis_position)
      circle(r=7.3/2);

      //cur for the idler_back_face
      translate([R,R-thickness])
      square([R,thickness]);

      translate([R*(1+1/2),R])
      rotate(-180)
      t_slot_shape(3, 12);
    }
    translate([R,R-thickness/2])
    rotate(-90)
    TSlot_joints(width=R);
  }
}
//!idler_side_face();
module idler_back_face(){
  R=23;
  difference(){
    translate([-5*thickness/2,0])
    rounded_square([5*thickness,R+5], corners=[0,0,5,5]);

    for (i=[-1,1])
      translate([i*HandleWidth/6,R])
      hull(){
        M4_hole();
        translate([0,-5]) M4_hole();      
      }

    for (i=[-1,1])
      translate([i*2*thickness,0])
      TSlot_holes(width=R);
  }
}

module idler_back_sheet(){
  color("grey")
  linear_extrude(height=thickness)
  idler_back_face();
}

module idler_side_sheet(){
  linear_extrude(height=thickness)
  idler_side_face();
}


module handlelock(){
  r=3;
  translate([1,52]){
    hull(){
      rounded_square([11,15], corners=[r,r,r,r], $fn=30);
      translate([10,-11]) circle(r=1, $fn=40);
    }
  }
}

module slice1_face(){
  extruder_slice(bearing_slot=true, idler_axis=false, handle_lock=true);
}

module slice2_face(){
  extruder_slice(idler_axis=true);
}

module slice3_face(){
  extruder_slice(idler_axis=true, filament_channel=true, mount_holes=true);
}

m3_diameter = 3;
module slice4_face(){
  extruder_slice(motor_holder=true, idler_axis=true);
}

module slice5_face(){
  extruder_slice(bearing_slot=true, idler_axis=false, handle_lock=true);
}

module extruder_slice(motor_holder=false, bearing_slot=false, filament_channel=false, mount_holes=false, idler_axis=false, bottom_screw_holes=false, handle_lock=false, nozzle_holder=false){
  base_thickness = 10;
  H=58;
  epsilon = 0.21;
  NEMA_side = 48;
  NEMA_holes_distance = 15.5;
  k=3;
  nozzle_hole_width = 14;
  608zz_diameter = 22;
  idler_axis_width = 7;

  difference(){
    union(){
      //base
      translate([0,base_thickness/2]){
        hull(){
          for (i=[-1,1]){
            translate([i*32,0])
            circle(r=base_thickness/2, $fn=40);
          }
        }
      }

      if (motor_holder){
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
                circle(r=18);
                
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
          circle(r=8/2, $fn=20);
          if (bearing_slot)
            circle(r=608zz_diameter/2, $fn=20);
        }

        translate(hobbed_bolt_position - [14,0])
        circle(r=23/2, $fn=20);
      }

      if (idler_axis){
        translate([-23/2 - 1.5*r, 0])
        rounded_square([1.5*r, hobbed_bolt_position[1] - 23/2], corners=[0,0,r,0]);
      }
    }

  if (mount_holes){
    for (i=[-1,1])
      translate([i*mount_holes_distance/2, 0])
      square([m4_diameter, base_thickness]);
  }

  //////////////////

  if (nozzle_holder){
    //cuts for attaching the nozzle holder
    translate([-nozzle_hole_width/2,0])
    square([nozzle_hole_width,10]);

    for (i=[-1,1])
    translate([i*nozzle_hole_width/2,5])
    circle(r=m3_diameter/2, $fn=20);
  }

  ///////////////
    if (motor_holder){
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
                    circle(r=m3_diameter/2, $fn=30);
                }
              }
            }
          }
        }
      }
    }
  ///////////////
    //holes for m3x30 screws to pack all 5 slices together
    for (i=[-1,1])
      translate([i*32, base_thickness/2])
      circle(r=m3_diameter/2, $fn=20);
  }
}

module slice1(){
  color("red")
  linear_extrude(height=thickness)
  slice1_face();
}

module slice2(){
  color("blue")
  translate([0,0,1*thickness])
  linear_extrude(height=thickness)
  slice2_face();
}

module slice3(){
  color("red")
  translate([0,0,2*thickness])
  linear_extrude(height=thickness)
  slice3_face();
}

module slice4(){
  color("green")
  translate([0,0,3*thickness])
  linear_extrude(height=thickness)
  slice4_face();
}

module slice5(){
  color("red")
  translate([0,0,4*thickness])
  linear_extrude(height=thickness)
  slice5_face();
}

//!testing();
module testing(){
//  slice4_face();

  rotate(90)
  translate([-37,2.5*thickness])
  rotate([90,0]){
    //sheet("slice4", 3*thickness);
    //sheet("slice5", 3.9*thickness);
  }

  rotate(90)
  translate([0,2.5*thickness])
  rotate([90,0]){
    slice5();
    slice4();
  }

  rotate(90)
  translate([motor_position[0], -thickness/2, motor_position[1]])
  rotate([-90,0])
  rotate(motor_angle)
  {
    NEMA17();
  }
}

module sheet(name, height=0, c=default_sheet_color){
  color(c)
  translate([0,0,height])
  linear_extrude(height=thickness)
  import("extruder-printrbot-layers.dxf", layer=name);
}

module handle(){
  nut_height = 3;
  handle_bolt_length = 50;

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
  h=5;

  //bolt body
  translate([0,0,-length])
  cylinder(r=7.3/2, h=length, $fn=30);

  //bolt head
  translate([0,0,-length-h])
  cylinder(r=7.3, h=h, $fn=6);
}

module idler(){
  R=23;

  color("grey")
  rotate([90,0])
    translate([0,0,5*thickness])
    translate(idler_bearing_position)
    idler_bolt_subassembly();

  rotate([90,0]){
    translate(idler_axis_position){
      idler_side_sheet();

//      translate([-24,-21,-10])
//      sheet("idler",thickness);

      translate([0,0,4*thickness])
      idler_side_sheet();
    
      translate([-R+thickness, R, 5*thickness/2])
      rotate([0,-90,0])
      idler_back_sheet();
    }
  }
}

module extruder_block(){
  rotate([90,0]){

    translate([37,0]){
      //sheet("slice1");
      //sheet("slice2", thickness);
      //sheet("slice3", 2*thickness);
      //sheet("slice4", 3*thickness);
      //sheet("slice5", 4*thickness);
    }

    slice1();
    slice2();
    slice3();
    slice4();
    slice5();
  }
}

//JHead MKIV nozzle
module nozzle(length=50){
  color([0.2,0.2,0.2]){
    translate([0,0,5])
    cylinder(r=8,h=5);

    cylinder(r=6,h=5);

    translate([0,0,-length+10])
    cylinder(r=8,h=length-10);
  }
}

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

    nozzle();

    translate([hobbed_bolt_position[0], -5*thickness/2 - 2*washer_thickness, hobbed_bolt_position[1]])
    rotate([90,0])
    extruder_gear(teeth=37);

    translate([motor_position[0], -thickness/2, motor_position[1]])
    rotate([-90,0])
    rotate(motor_angle)
    {
      NEMA17();

      translate([0,0,-2*thickness - 2*washer_thickness])
      color("grey")
      rotate([180,0])
      motor_gear(teeth=11);
    }
  }
}

lasercut_extruder();

