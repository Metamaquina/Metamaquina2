// (c) 2013 Felipe C. da S. Sanches <fsanches@metamaquina.com.br>
// Licensed under the terms of the GNU General Public License
// version 3 (or later).

include <Metamaquina2.h>;
include <BillOfMaterials.h>;
include <endstop.h>;
use <utils.scad>;
use <rounded_square.scad>;

m3_diameter=3; //TODO: move-me to a header file

module z_max_mount_holes(){
  //these are the holes for mounting the endstop subassembly
  for (i=[-1,1])
    translate([-microswitch_width/2+i*microswitch_holes_distance/2,16-microswitch_height/2])
    M3_hole();

  translate([-100,7]){
      //this is to keep the endstop wiring in place:
      zip_tie_holes(d=8);

      translate([78,0])
      zip_tie_holes(d=8);

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
         mechanical_switch(bom=false);
      }
    }
}

module z_min_mount_holes(){    
  for (i=[-1,1])
    translate([microswitch_width/2+i*microswitch_holes_distance/2,-microswitch_height/2])
    hull(){
        M3_hole();
        translate([0,-16])
        M3_hole();
    }

  translate([-15.5,7]){
    rounded_edge_cut(width=3, height=15.7, r=3/2, plain_left=true);

    translate([5,-15])
    zip_tie_holes(d=8);
  }
}

module y_max_endstop_mount_holes(){
  translate([30, -12])
  y_endstop_mount_holes();
}

module y_min_endstop_mount_holes(){
  translate([-30, +12])
  mirror([0,1])
  y_endstop_mount_holes();
}

module y_endstop_mount_holes(){
  //M3 mount holes
  for (i=[-1,1])
    translate([i*microswitch_holes_distance/2,-24])
    M3_hole();

  //edge cut for inserting the endstop wire
  translate([-1.5,-30.01])
  rotate(180)
  rounded_edge_cut(width=3, height=13, r=3/2);

  //and ziptie holes to keep it in place
  translate([-12,-20])
  zip_tie_holes(d=6);

  //hole to give room for bolt tips and M25 nuts:
  translate([0,-10])
  rotate(90)
  zip_tie_holes(d=microswitch_holes_distance, r=3);

  //these serve as reference for us
  // to see where will be the tips of the M2.5 bolts
  %for (i=[-1,1])
    translate([i*microswitch_holes_distance/2,-10])
    M25_hole();
}

module simples_mechanical_endstop(){
  thickness = 5;//TODO

  if (render_rubber)
  color(rubber_color)
  cube([microswitch_width, microswitch_height, thickness]);

  color(metal_color){
    translate([2, microswitch_height+3])
    rotate(10)
    cube([microswitch_width-2, 1, thickness]);

    translate([2, microswitch_height])
    cube([1, 4, thickness]);
  }
}

thickness = 6;
module z_max_endstop(){
  rotate(180){
    color(sheet_color)
    linear_extrude(height=thickness)
    endstop_spacer_face1();

    translate([0,0,thickness])
    color(sheet_color)
    linear_extrude(height=thickness)
    endstop_spacer_face2();

    translate([0,0,2*thickness])
    mechanical_switch();
  }
}

module ymin_endstop_subassembly(){
  color(sheet_color)
  linear_extrude(height=thickness)
  ymin_endstop_spacer_face();

  translate([0,0,thickness])
  mechanical_switch();
}

module ymax_endstop_subassembly(){
  color(sheet_color)
  linear_extrude(height=thickness)
  ymax_endstop_spacer_face();

  translate([0,0,thickness])
  mechanical_switch();
}

module YMIN_endstop_spacer_sheet(){
  color(sheet_color)
  linear_extrude(height=thickness)
  endstop_spacer_face2();
}

module z_min_endstop(){
  color(sheet_color)
  translate([15,0]){
    linear_extrude(height=thickness)
    zmin_endstop_spacer_face1();

    translate([0,0,thickness])
    linear_extrude(height=thickness)
    zmin_endstop_spacer_face2();
  }

  translate([0,0,2*thickness])
  mechanical_switch();
}

wire_coordinate = [microswitch_width*0.4,microswitch_height*0.1];

module oblongo(L=10,d=3){
  hull(){
    circle(r=d/2, $fn=20);
    translate([L,0])
    circle(r=d/2, $fn=20);  
  }
}

module endstop_spacer_face1(){
  r = 3;
  translate([0,-microswitch_height])
  difference(){
    translate([-2,-microswitch_height])
    rounded_square([microswitch_width+4,3*microswitch_height], corners=[r,r,r,r], $fn=30);

    translate(wire_coordinate)
    oblongo(microswitch_width);

    for (i=[-1,1])
      translate([microswitch_width/2+i*microswitch_holes_distance/2, microswitch_height+2])
      circle(r=m25_diameter, $fn=20);

    for (i=[-1,1])
      translate([microswitch_width/2+i*microswitch_holes_distance/2, -microswitch_height/2])
      circle(r=m3_diameter/2, $fn=20);
  }
}

module ymin_endstop_spacer_face(){
  difference(){
    endstop_spacer_face2();
    import("labels.dxf", layer="ymin");
  }
}

module ymax_endstop_spacer_face(){
  difference(){
    endstop_spacer_face2();
    import("labels.dxf", layer="ymax");
  }
}

module zmin_endstop_spacer_face1(){
  difference(){
    mirror([1,0])
    endstop_spacer_face1();
    import("labels.dxf", layer="zmin");
  }
}

module zmin_endstop_spacer_face2(){
  difference(){
    mirror([1,0])
    endstop_spacer_face2();
    import("labels.dxf", layer="zmin");
  }
}

module zmax_endstop_spacer_face1(){
  difference(){
    endstop_spacer_face1();
    import("labels.dxf", layer="zmax");
  }
}

module zmax_endstop_spacer_face2(){
  difference(){
    endstop_spacer_face2();
    import("labels.dxf", layer="zmax");
  }
}

module endstop_spacer_face2(){
  r = 3;
  translate([0,-microswitch_height])
  difference(){
    translate([-2,-microswitch_height])
    rounded_square([microswitch_width+4,3*microswitch_height], corners=[r,r,r,r], $fn=30);

    translate(wire_coordinate)
    rotate(90)
    oblongo(microswitch_width);

    for (i=[-1,1])
      translate([microswitch_width/2+i*microswitch_holes_distance/2, microswitch_height+2])
      circle(r=m25_diameter/2, $fn=20);

    for (i=[-1,1])
      translate([microswitch_width/2+i*microswitch_holes_distance/2, -microswitch_height/2])
      circle(r=m3_diameter/2, $fn=20);
  }
}

module mechanical_switch(bom=true){
  if (bom)
    BillOfMaterials("Microswitch KW11-3Z-5-3T - 18MM");

  metal_thickness = 1;

  if (render_rubber)
  color(rubber_color)
  linear_extrude(height=microswitch_thickness){
    difference(){
      square([microswitch_width, microswitch_height]);

      for (i=[-1,1])
        translate([microswitch_width/2 + i*microswitch_holes_distance/2,2])
        circle(r=m25_diameter/2, $fn=20);
    }
  }

  if (render_metal)
  color(metal_color)
  translate([2, microswitch_height+3, 1]){
    linear_extrude(height=microswitch_thickness-2){
      hull(){
        circle(r=metal_thickness/2, $fn=20);
        translate([0, -3])
        circle(r=metal_thickness/2, $fn=20);
      }

      hull(){
        circle(r=metal_thickness/2, $fn=20);
        rotate(10)
        translate([microswitch_width-3,0])
        circle(r=metal_thickness/2, $fn=20);
      }
    }
  }
}

module optical_endstop(){
  //TODO: implement-me!
}

z_max_endstop();
