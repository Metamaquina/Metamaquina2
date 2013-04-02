// (c) 2013 Felipe C. da S. Sanches <fsanches@metamaquina.com.br>
// Licensed under the terms of the GNU General Public License
// version 3 (or later).

include <Metamaquina-config.scad>;

module simples_mechanical_endstop(){
  thickness = 5;//TODO
  width = 15;//TODO
  height = 8;//TODO

  color(dark_grey)
  cube([width, height, thickness]);

  color(metal_color){
    translate([2, height+3])
    rotate(10)
    cube([width-2, 1, thickness]);

    translate([2, height])
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

use <rounded_square.scad>;
width = 15;//TODO
height = 8;//TODO


wire_coordinate = [width*0.35,height*0.5];

module oblongo(L=10,d=3){
  hull(){
    circle(r=d/2, $fn=20);
    translate([L,0])
    circle(r=d/2, $fn=20);  
  }
}

module endstop_spacer_sheet1(){
  r = 3;
  color(sheet_color)
  linear_extrude(height=thickness){
    translate([0,-height])
    difference(){
      translate([-2,-height])
      rounded_square([width+4,3*height], corners=[r,r,r,r], $fn=30);

      translate(wire_coordinate)
      oblongo(width);

      for (i=[-1,1])
        translate([width/2+i*microswitch_holes_distance/2,height+2])
        circle(r=m25_diameter, $fn=20);

      for (i=[-1,1])
        translate([width/2+i*microswitch_holes_distance/2,-height/2])
        circle(r=m3_diameter/2, $fn=20);

    }
  }
}

module endstop_spacer_sheet2(){
  r = 3;
  color(sheet_color)
  linear_extrude(height=thickness){
    translate([0,-height])
    difference(){
      translate([-2,-height])
      rounded_square([width+4,3*height], corners=[r,r,r,r], $fn=30);

      translate(wire_coordinate)
      rotate(90)
      oblongo(width);

      for (i=[-1,1])
        translate([width/2+i*microswitch_holes_distance/2,height+2])
        circle(r=m25_diameter/2, $fn=20);

      for (i=[-1,1])
        translate([width/2+i*microswitch_holes_distance/2,-height/2])
        circle(r=m3_diameter/2, $fn=20);

    }
  }
}

module mechanical_switch(){
  thickness = 5;//TODO
  metal_thickness = 1;

  color(dark_grey)
  linear_extrude(height=thickness){
    difference(){
      square([width, height]);

      for (i=[-1,1])
        translate([width/2 + i*microswitch_holes_distance/2,2])
        circle(r=m25_diameter/2, $fn=20);
    }
  }

  color(metal_color)
  translate([2, height+3, 1]){
    linear_extrude(height=thickness-2){
      hull(){
        circle(r=metal_thickness/2, $fn=20);
        translate([0, -3])
        circle(r=metal_thickness/2, $fn=20);
      }

      hull(){
        circle(r=metal_thickness/2, $fn=20);
        rotate(10)
        translate([width-3,0])
        circle(r=metal_thickness/2, $fn=20);
      }
    }
  }
}

module optical_endstop(){
  //TODO: implement-me!
}

z_max_endstop();
