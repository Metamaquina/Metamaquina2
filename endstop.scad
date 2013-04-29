// (c) 2013 Felipe C. da S. Sanches <fsanches@metamaquina.com.br>
// Licensed under the terms of the GNU General Public License
// version 3 (or later).

include <Metamaquina2.h>;
include <endstop.h>;
use <utils.scad>;
use <rounded_square.scad>;

m3_diameter=3; //TODO: move-me to a header file

module z_max_mount_holes(){
  //these are the holes for mounting the endstop subassembly
  for (i=[-1,1])
    translate([-endstop_holder_width/2+i*microswitch_holes_distance/2,16-endstop_holder_height/2])
    M3_hole();

  translate([-100,7]){
      //this is to keep the endstop wiring in place:
      zip_tie_holes();

      // Since all of the 3d printer wiring will be prepared
      // in an early assembly stage this hole should be
      // large enough to let the ZMAX microswitch pass through:
      translate([-10,0]){
        hull()
        zip_tie_holes(r=4);

        //Here is a transparent rendering of a microswitch
        // for us to make sure it can pass through the hole:
        %translate([-2.5,-7, -2])
         rotate([90,0])
         rotate([0,90])
         mechanical_switch();
      }
    }
}

module z_min_mount_holes(){    
  for (i=[-1,1])
    translate([endstop_holder_width/2+i*microswitch_holes_distance/2,-endstop_holder_height/2])
    hull(){
        M3_hole();
        translate([0,-16])
        M3_hole();
    }

  translate([-15,7]){
    rounded_edge_cut(width=3, height=15.7, r=3/2);

    translate([0,-20])
    rotate(90)
    zip_tie_holes();
  }
}

module simples_mechanical_endstop(){
  thickness = 5;//TODO

  if (render_rubber)
  color(rubber_color)
  cube([endstop_holder_width, endstop_holder_height, thickness]);

  color(metal_color){
    translate([2, endstop_holder_height+3])
    rotate(10)
    cube([endstop_holder_width-2, 1, thickness]);

    translate([2, endstop_holder_height])
    cube([1, 4, thickness]);
  }
}

thickness = 6;
module z_max_endstop(){
  rotate(180){
    endstop_spacer_sheet1();

    translate([0,0,thickness])
    endstop_spacer_sheet2();

    translate([0,0,2*thickness])
    mechanical_switch();
  }
}

module z_min_endstop(){
  endstop_spacer_sheet1();

  translate([0,0,thickness])
  endstop_spacer_sheet2();

  translate([0,0,2*thickness])
  mechanical_switch();
}

wire_coordinate = [endstop_holder_width*0.4,endstop_holder_height*0.1];

module oblongo(L=10,d=3){
  hull(){
    circle(r=d/2, $fn=20);
    translate([L,0])
    circle(r=d/2, $fn=20);  
  }
}

module endstop_spacer_sheet1(){
  color(sheet_color)
  linear_extrude(height=thickness)
  endstop_spacer_face1();
}

module endstop_spacer_face1(){
  r = 3;
  translate([0,-endstop_holder_height])
  difference(){
    translate([-2,-endstop_holder_height])
    rounded_square([endstop_holder_width+4,3*endstop_holder_height], corners=[r,r,r,r], $fn=30);

    translate(wire_coordinate)
    oblongo(endstop_holder_width);

    for (i=[-1,1])
      translate([endstop_holder_width/2+i*microswitch_holes_distance/2, endstop_holder_height+2])
      circle(r=m25_diameter, $fn=20);

    for (i=[-1,1])
      translate([endstop_holder_width/2+i*microswitch_holes_distance/2, -endstop_holder_height/2])
      circle(r=m3_diameter/2, $fn=20);
  }
}

module endstop_spacer_sheet2(){
  color(sheet_color)
  linear_extrude(height=thickness)
  endstop_spacer_face2();
}

module endstop_spacer_face2(){
  r = 3;
  translate([0,-endstop_holder_height])
  difference(){
    translate([-2,-endstop_holder_height])
    rounded_square([endstop_holder_width+4,3*endstop_holder_height], corners=[r,r,r,r], $fn=30);

    translate(wire_coordinate)
    rotate(90)
    oblongo(endstop_holder_width);

    for (i=[-1,1])
      translate([endstop_holder_width/2+i*microswitch_holes_distance/2, endstop_holder_height+2])
      circle(r=m25_diameter/2, $fn=20);

    for (i=[-1,1])
      translate([endstop_holder_width/2+i*microswitch_holes_distance/2, -endstop_holder_height/2])
      circle(r=m3_diameter/2, $fn=20);
  }
}

module mechanical_switch(){
  thickness = 5;//TODO
  metal_thickness = 1;

  if (render_rubber)
  color(rubber_color)
  linear_extrude(height=thickness){
    difference(){
      square([endstop_holder_width, endstop_holder_height]);

      for (i=[-1,1])
        translate([endstop_holder_width/2 + i*microswitch_holes_distance/2,2])
        circle(r=m25_diameter/2, $fn=20);
    }
  }

  if (render_metal)
  color(metal_color)
  translate([2, endstop_holder_height+3, 1]){
    linear_extrude(height=thickness-2){
      hull(){
        circle(r=metal_thickness/2, $fn=20);
        translate([0, -3])
        circle(r=metal_thickness/2, $fn=20);
      }

      hull(){
        circle(r=metal_thickness/2, $fn=20);
        rotate(10)
        translate([endstop_holder_width-3,0])
        circle(r=metal_thickness/2, $fn=20);
      }
    }
  }
}

module optical_endstop(){
  //TODO: implement-me!
}

z_max_endstop();
