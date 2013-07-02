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
include <endstop.h>;
use <utils.scad>;
use <rounded_square.scad>;
include <render.h>;

m3_diameter=3; //TODO: move-me to a header file

module z_max_mount_holes(){
  //these are the holes for mounting the endstop subassembly
  for (i=[-1,1])
    translate([-microswitch_width/2+i*microswitch_holes_distance/2,19-microswitch_height/2])
    M3_hole();

  translate([-100,7]){
      //this is to keep the endstop wiring in place:
      zip_tie_holes(d=8);

      translate([74,0])
      zip_tie_holes(d=8);

      // Since all of the 3d printer wiring will be prepared
      // in an early assembly stage this hole should be
      // large enough to let the ZMAX microswitch pass through:
      translate([-7,-4]){

        translate([-microswitch_thickness/2 - 1,-microswitch_width/2 - 1])
        rounded_square([microswitch_thickness+2, microswitch_width+2], corners=[2,2,2,2]);

        //Here is a transparent rendering of a microswitch
        // for us to make sure it can pass through the hole:
        %translate([-2.5,-10, -2])
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

  translate([-15.5+3,7]){
    rounded_edge_cut(width=3, height=15.7, r=3/2, plain_left=true);

    translate([6,-15])
    zip_tie_holes(d=8);
  }
}

module y_max_endstop_mount_holes(){
  translate([32.5, -12])
  y_endstop_mount_holes();
}

module y_min_endstop_mount_holes(){
  translate([-32.5, +12])
  mirror([0,1])
  y_endstop_mount_holes();
}

module y_endstop_mount_holes(){
  //M3 mount holes
  for (i=[-1,1])
    translate([i*microswitch_holes_distance/2,-24])
    M3_hole();

  //edge cut for inserting the endstop wire
  translate([0,-30.01])
  rotate(180)
  rounded_edge_cut(width=3, height=13, r=3/2);

  //and ziptie holes to keep it in place
  translate([-12,-20])
  zip_tie_holes(d=6);

  //hole to give room for bolt tips and M25 nuts:
  translate([0,-6])
  rotate(90)
  zip_tie_holes(d=microswitch_holes_distance, r=3);

  //these serve as reference for us
  // to see where will be the tips of the M2.5 bolts
  %for (i=[-1,1])
    translate([i*microswitch_holes_distance/2,-6])
    M25_hole();
}

module simples_mechanical_endstop(){
  thickness = 5;//TODO

  if (render_rubber)
  material("rubber")
  cube([microswitch_width, microswitch_height, thickness]);

  material("metal"){
    translate([2, microswitch_height+3])
    rotate(10)
    cube([microswitch_width-2, 1, thickness]);

    translate([2, microswitch_height])
    cube([1, 4, thickness]);
  }
}

thickness = 6;

module ymin_endstop_subassembly(){
  {//TODO: Add these parts to the CAD model
    BillOfMaterials("M3x16 bolt", 2, ref="H_M3x16");
    BillOfMaterials("M3 washer", 2, ref="AL_M3");
    BillOfMaterials("M3 lock-nut", 2, ref="P_M3_ny");

    BillOfMaterials("M2.5x16 bolt, cylindric head", 2, ref="H_M2.5x16_cl");
    BillOfMaterials("M2.5 washer", 2, ref="AL_M2.5");
    BillOfMaterials("M2.5 nut", 2, ref="P_M2.5");
  }

  ymin_endstop_spacer_sheet();
  translate([0,0,thickness])
  ymin_endstop_spacer_sheet();

  translate([0,0,2*thickness])
  mechanical_switch();
}

module ymax_endstop_subassembly(){
  {//TODO: Add these parts to the CAD model
    BillOfMaterials("M3x16 bolt", 2, ref="H_M3x16");
    BillOfMaterials("M3 washer", 2, ref="AL_M3");
    BillOfMaterials("M3 lock-nut", 2, ref="P_M3_ny");

    BillOfMaterials("M2.5x16 bolt, cylindric head", 2, ref="H_M2.5x16_cl");
    BillOfMaterials("M2.5 washer", 2, ref="AL_M2.5");
    BillOfMaterials("M2.5 nut", 2, ref="P_M2.5");
  }

  ymax_endstop_spacer_sheet();

  translate([0,0,thickness])
  ymax_endstop_spacer_sheet();

  translate([0,0,2*thickness])
  mechanical_switch();
}

module YMIN_endstop_spacer_sheet(){
  material("lasercut")
  linear_extrude(height=thickness)
  endstop_spacer_face2();
}

module z_min_endstop(){
  {//TODO: Add these parts to the CAD model
    BillOfMaterials("M3x25 bolt", 2, ref="H_M3x25");
    BillOfMaterials("M3 washer", 2, ref="AL_M3");
    BillOfMaterials("M3 lock-nut", 2, ref="P_M3_ny");

    BillOfMaterials("M2.5x16 bolt, cylindric head", 2, ref="H_M2.5x16_cl");
    BillOfMaterials("M2.5 washer", 2, ref="AL_M2.5");
    BillOfMaterials("M2.5 nut", 2, ref="P_M2.5");
  }

  translate([20,0]){
    zmin_endstop_spacer_sheet1();

    translate([0,0,acrylic_thickness])
    zmin_endstop_spacer_sheet2();
  }

  translate([0,0,2*acrylic_thickness])
  mechanical_switch();
}

module z_max_endstop(){
  {//TODO: Add these parts to the CAD model
    BillOfMaterials("M3x25 bolt", 2, ref="H_M3x25");
    BillOfMaterials("M3 washer", 2, ref="AL_M3");
    BillOfMaterials("M3 lock-nut", 2, ref="P_M3_ny");

    BillOfMaterials("M2.5x16 bolt, cylindric head", 2, ref="H_M2.5x16_cl");
    BillOfMaterials("M2.5 washer", 2, ref="AL_M2.5");
    BillOfMaterials("M2.5 nut", 2, ref="P_M2.5");
  }

  translate([0,-2.5])
  rotate(180){
    zmax_endstop_spacer_sheet1();

    translate([0,0,acrylic_thickness])
    zmax_endstop_spacer_sheet2();

    translate([0,0,2*acrylic_thickness])
    mechanical_switch();
  }
}

wire_coordinate = [microswitch_width*0.5,microswitch_height*0.1];

module oblongo(L=10,d=3){
  hull(){
    circle(r=d/2, $fn=20);
    translate([L,0])
    circle(r=d/2, $fn=20);  
  }
}

module endstop_spacer_face1(nut_gap=true){
  r = 3;
  translate([0,-microswitch_height])
  difference(){
    translate([-2,-microswitch_height])
    rounded_square([microswitch_width+4,endstop_spacer_height], corners=[r,r,r,r]);

    translate(wire_coordinate)
    oblongo(microswitch_width);

    for (i=[-1,1])
      translate([microswitch_width/2+i*microswitch_holes_distance/2, microswitch_height+2])
      if (nut_gap)
        circle(r=m25_diameter);
      else
        circle(r=m25_diameter/2);

    for (i=[-1,1])
      translate([microswitch_width/2+i*microswitch_holes_distance/2, -microswitch_height/2])
      circle(r=m3_diameter/2);
  }
}

module endstop_spacer_face2(nut_gap=false){
  r = 3;
  translate([0,-microswitch_height])
  difference(){
    translate([-2,-microswitch_height])
    rounded_square([microswitch_width+4,endstop_spacer_height], corners=[r,r,r,r]);

    translate(wire_coordinate)
    rotate(90)
    oblongo(microswitch_width);

    for (i=[-1,1])
      translate([microswitch_width/2+i*microswitch_holes_distance/2, microswitch_height+2])
      if (nut_gap)
        circle(r=m25_diameter);
      else
        circle(r=m25_diameter/2);

    for (i=[-1,1])
      translate([microswitch_width/2+i*microswitch_holes_distance/2, -microswitch_height/2])
      circle(r=m3_diameter/2);
  }
}

module ymin_endstop_spacer_face(){
  difference(){
    endstop_spacer_face1(nut_gap=false);

    translate([5,-14])
    rotate(90)
    import("labels.dxf", layer="ymin");
  }
}

module ymax_endstop_spacer_face(){
  difference(){
    endstop_spacer_face1(nut_gap=false);

    translate([5,-14])
    rotate(90)
    import("labels.dxf", layer="ymax");
  }
}

module zmin_endstop_spacer_face1(){
  difference(){
    mirror([1,0])
    endstop_spacer_face1();

    translate([0,-14])
    rotate(90)
    import("labels.dxf", layer="zmin");
  }
}

module zmin_endstop_spacer_face2(){
  difference(){
    mirror([1,0])
    endstop_spacer_face2();

    translate([0,-14])
    rotate(90)
    import("labels.dxf", layer="zmin");
  }
}

module zmax_endstop_spacer_face1(){
  difference(){
    endstop_spacer_face1();

    translate([5,-14])
    rotate(90)
    import("labels.dxf", layer="zmax");
  }
}

module zmax_endstop_spacer_face2(){
  difference(){
    endstop_spacer_face2();

    translate([5,-14])
    rotate(90)
    import("labels.dxf", layer="zmax");
  }
}

module mechanical_switch(bom=true){
  if (bom)
    BillOfMaterials("Microswitch KW11-3Z-5-3T - 18MM", ref="KW11-3Z-5-3T");

  metal_thickness = 1;

  material("rubber")
  linear_extrude(height=microswitch_thickness){
    difference(){
      square([microswitch_width, microswitch_height]);

      for (i=[-1,1])
        translate([microswitch_width/2 + i*microswitch_holes_distance/2,2])
        circle(r=m25_diameter/2, $fn=20);
    }
  }

  material("metal")
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

module ymin_endstop_spacer_sheet(){
  BillOfMaterials(category="Lasercut wood", partname="YMIN Spacer");

  material("lasercut")
  linear_extrude(height=thickness)
  ymin_endstop_spacer_face();
}

module ymax_endstop_spacer_sheet(){
  BillOfMaterials(category="Lasercut wood", partname="YMAX Spacer");

  material("lasercut")
  linear_extrude(height=thickness)
  ymax_endstop_spacer_face();
}

module zmax_endstop_spacer_sheet1(){
  BillOfMaterials(category="Lasercut wood", partname="ZMAX Spacer #1");

  material("acrylic")
  linear_extrude(height=acrylic_thickness)
  zmax_endstop_spacer_face1();
}

module zmax_endstop_spacer_sheet2(){
  BillOfMaterials(category="Lasercut wood", partname="ZMAX Spacer #2");

  material("acrylic")
  linear_extrude(height=acrylic_thickness)
  zmax_endstop_spacer_face2();
}

module zmin_endstop_spacer_sheet1(){
  BillOfMaterials(category="Lasercut wood", partname="ZMIN Spacer #1");

  material("acrylic")
  linear_extrude(height=acrylic_thickness)
  zmin_endstop_spacer_face1();
}

module zmin_endstop_spacer_sheet2(){
  BillOfMaterials(category="Lasercut wood", partname="ZMIN Spacer #2");

  material("acrylic")
  linear_extrude(height=acrylic_thickness)
  zmin_endstop_spacer_face2();
}

z_max_endstop();
