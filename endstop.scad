// (c) 2013 Felipe C. da S. Sanches <fsanches@metamaquina.com.br>
// Licensed under the terms of the GNU General Public License
// version 3 (or later).

include <Metamaquina-config.scad>;
use <rounded_square.scad>;

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
