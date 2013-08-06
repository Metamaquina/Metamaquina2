// (c) 2013 Metamáquina <http://www.metamaquina.com.br/>
//
// Author:
// * Felipe C. da S. Sanches <fsanches@metamaquina.com.br>
// * Sara Rodriguez <sara@metamaquina.com.br>
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program. If not, see <http://www.gnu.org/licenses/>.

//utils
use <rounded_square.scad>;
use <tslot.scad>;
include <render.h>;
include <BillOfMaterials.h>;
use <mm2logo.scad>;
use <domed_cap_nuts.scad>;

//measures
thickness = 6;
margin = 10;

feet_height = 12;
feet_width = 50;
base_height = 80;

adjust = 12;

total_width = 160+2*thickness+2*margin+adjust/2;

top_cut_height = 20;
top_cut_width = 9;

radius = 15;
rad=3/2;

spool_holder_width = 160+2*margin+2*thickness;
spool_holder_height = 40;

tslot_length = 16;
tslot_diameter = 3;

hole_domed_cap_nut = 12.75;

threaded_rod_diameter = 8;
threaded_rod_length = spool_holder_width + 2*hole_domed_cap_nut;

total_height = 160/2 + 35/2 - threaded_rod_diameter/2 + top_cut_height + feet_height + top_cut_width/2;

feet_radius = 5;

//TSLOTS
sidepanel_TSLOTS = [
//parameters => [x, y, width, angle]
  [total_width/2 - thickness, 15, 50, 0],
  [-(total_width/2 - thickness), 15, 50, 0],
];

front_and_back_panels_TSLOT_SHAPES = [
//parameters => [x, y, angle]
  [tslot_diameter, tslot_length, 0],
];

module sidepanel_plainface(){
  hull()
  for (i=[-1,1]){
      translate([i*40, total_height - radius])
      circle(r=radius);

      translate([i*(total_width/2 - radius), base_height])
      circle(r=radius);

      translate([i*total_width/2, feet_height])
      circle(r=0.1);
  }

  //feet
  for (i=[-1,1]){
    translate([i*(total_width - feet_width)/2, (feet_height + feet_radius)/2])
    rounded_square([feet_width, feet_height + feet_radius], corners=[feet_radius, feet_radius, feet_radius, feet_radius], center=true);
  }
}

//side panel
module FilamentSpoolHolder_sidepanel_face(){
  difference(){
    sidepanel_plainface();

    //top cut
    union(){
      translate([0, total_height - top_cut_height/2])
      square([top_cut_width, top_cut_height], center = true);

      translate([0, total_height - top_cut_height])
      circle(r=top_cut_width/2);
    }

    //logo
    translate([-3, base_height*0.75])
    scale(5) mm_logo();

    //tslots
    for (i=[-1,1]){
        translate([i*(total_width/2 - thickness), 15])
        TSlot_holes();
    }
  }
}

//front and back panels
module FilamentSpoolHolder_front_and_back_panels_face(){
  difference(){
    union(){
      translate([0, base_height/2])
      square([spool_holder_width - 2*thickness, spool_holder_height], center = true);

      //tslots joints
      for (i=[-1,1]){
        translate([i*(spool_holder_width/2 - thickness/2), 15])
        TSlot_joints(50);
      }
    }

    for (i=[-1,1]){
      translate([i*(spool_holder_width/2 + tslot_length), base_height/2 - i*tslot_diameter])
      rotate([0,0,i*90])
      tslot_shapes_from_list(front_and_back_panels_TSLOT_SHAPES);
    }
  }
}

module FilamentSpoolHolder_threaded_rod(){
  BillOfMaterials(str("M8x", threaded_rod_length, "mm Threaded Rod"));
  material("threaded metal")
  cylinder(r=threaded_rod_diameter/2, h=threaded_rod_length);
}

module FilamentSpoolHolder_sidepanel_sheet(){
  BillOfMaterials(category="Lasercut wood", partname="Filament Spool Holder Side Panel");
  material("lasercut")
  linear_extrude(height=thickness)
  FilamentSpoolHolder_sidepanel_face();

  tslot_parts_from_list(sidepanel_TSLOTS);
}

module FilamentSpoolHolder_front_sheet(){
  BillOfMaterials(category="Lasercut wood", partname="Filament Spool Holder Front Sheet");
  material("lasercut")
  linear_extrude(height=thickness)
  FilamentSpoolHolder_front_and_back_panels_face();
}

module FilamentSpoolHolder_back_sheet(){
  BillOfMaterials(category="Lasercut wood", partname="Filament Spool Holder Back Sheet");
  material("lasercut")
  linear_extrude(height=thickness)
  FilamentSpoolHolder_front_and_back_panels_face();
}

module FilamentSpoolHolder_sidepanels(){
  rotate([0,0,90]){
    translate([0, -spool_holder_width/2 + thickness])
    rotate([90,0,0])
    FilamentSpoolHolder_sidepanel_sheet();

    translate([0, spool_holder_width/2 - thickness])
    rotate([90,0,180])
    FilamentSpoolHolder_sidepanel_sheet();
  }
}

module FilamentSpoolHolder_front_and_back_panels(){
  translate([0, -(total_width/2 - thickness/2 - adjust/2)])
  rotate([90,0,0])
  FilamentSpoolHolder_front_sheet();

  translate([0, total_width/2 - thickness/2 - adjust/2])
  rotate([90,0,180])
  FilamentSpoolHolder_back_sheet();
}

module FilamentSpoolHolder_threaded_rod_subassembly(){
  translate([-threaded_rod_length/2, 0, total_height - top_cut_height - (top_cut_width - threaded_rod_diameter)/2])
  rotate([0,90,0])
  FilamentSpoolHolder_threaded_rod();

  union(){
    translate([threaded_rod_length/2 - hole_domed_cap_nut, 0, total_height - top_cut_height - (top_cut_width - threaded_rod_diameter)/2])
    rotate([0,90,0])
    M8_domed_cap_nut();

    translate([-(threaded_rod_length/2-hole_domed_cap_nut), 0, total_height - top_cut_height - (top_cut_width-threaded_rod_diameter)/2])
    rotate([0,270,0])
    M8_domed_cap_nut();
  }
}

module FilamentSpoolHolder(){
  FilamentSpoolHolder_sidepanels();
  FilamentSpoolHolder_front_and_back_panels();
  FilamentSpoolHolder_threaded_rod_subassembly();
}

module FilamentSpool(){
  BillOfMaterials(partname="Filament Spool");
  translate([-160/2, 0, total_height - top_cut_height - 35/2 + threaded_rod_diameter/2 - (top_cut_width - threaded_rod_diameter)/2])
  rotate([0,90,0])
  material("ABS")
  linear_extrude(height=160)
  difference(){
    circle(r=160/2);
    circle(r=35/2);
  }
}

FilamentSpoolHolder();
FilamentSpool();
