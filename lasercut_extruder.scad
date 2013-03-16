// Reimplementation of Brook Drum's lasercut extruder
//
// (c) 2013 Felipe C. da S. Sanches <fsanches@metamaquina.com.br>
// Lincensed under the terms of the GNU General Public License
// version 3 (or later).

use <NEMA.scad>;
use <rounded_square.scad>;
use <thingiverse/12789/TZ_Huxley_extruder_gears.scad>;

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

module sheet(name, height=0, c=default_sheet_color){
  color(c)
  translate([0,0,height])
  linear_extrude(height=thickness)
  import("extruder-printrbot-layers.dxf", layer=name);
}

module handle(){
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

module idler(){
  rotate([90,0]){
    sheet("idler");
    sheet("idler",4*thickness);
    translate([9.5,35,-2.5]){
      rotate([0,-90,0]){
        sheet("idler2",thickness);
      }
    }
  }
}

module extruder_block(){
  rotate([90,0]){
    sheet("slice1");
    sheet("slice2", thickness);
    sheet("slice3", 2*thickness);
    sheet("slice4", 3*thickness);
    sheet("slice5", 4*thickness);
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

module lasercut_extruder(){
  rotate(90)
  union(){
    translate([-37,2.5*thickness]){
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

    translate([hobbed_bolt_position[0], -5*thickness/2 -8, hobbed_bolt_position[1]])
    rotate([90,0])
    extruder_gear(teeth=37);

    translate([motor_position[0], -thickness/2, motor_position[1]])
    rotate([-90,0])
    rotate(motor_angle)
    {
      NEMA17();

      translate([0,0,-20])
      color("grey")
      motor_gear(teeth=11);
    }
  }
}

lasercut_extruder();

