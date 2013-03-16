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

m3_diameter = 3;
module slice4_face(){
  NEMA_holes_distance = 15.5;
  k=3;
  nozzle_hole_width = 14;

  difference(){
    slice4_plainface();

    //cuts for attaching the nozzle holder
    translate([-nozzle_hole_width/2,0])
    square([nozzle_hole_width,10]);

    for (i=[-1,1])
    translate([i*nozzle_hole_width/2,5])
    circle(r=m3_diameter/2, $fn=20);

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
}

module slice5_face(){
  m3_washer_diameter = 5;
  NEMA_holes_distance = 15.5;
  k=3;

  difference(){
    slice4_plainface();

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
                  circle(r=m3_washer_diameter/2, $fn=30);
              }
            }
          }
        }
      }
    }
  }
}

module slice4_plainface(){
  r=5;
  H=58;
  epsilon = 0.21;
  NEMA_side = 48;

  translate([0,r]){
    hull(){
      for (i=[-1,1]){
        translate([i*32,0])
        circle(r=r, $fn=40);
      }
    }
  }

  hull(){
    translate([15,0])
    square([epsilon, H]);

    translate(motor_position)
    rotate(-motor_angle)
    translate([-NEMA_side/2,-NEMA_side/2])
    rounded_square([NEMA_side,NEMA_side], corners=[r,r,r,r]);
  }

  difference(){
    union(){
      translate([-23/2,0])
      square([15+23/2,hobbed_bolt_position[1]]);

      translate([-4,hobbed_bolt_position[1]])
      square([15+4,H-hobbed_bolt_position[1]]);
    }

    translate(hobbed_bolt_position)
    circle(r=8/2, $fn=20);

    translate(hobbed_bolt_position - [14,0])
    circle(r=23/2, $fn=20);
  }

  translate([-23/2 - 1.5*r, 0])
  rounded_square([1.5*r, hobbed_bolt_position[1] - 23/2], corners=[0,0,r,0]);

}

module slice4(){
  color("red")
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
    sheet("slice4", 3*thickness);
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

    translate([37,0]){
      slice4();
      //slice5();
    }    
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

