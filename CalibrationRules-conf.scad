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

extruder_wiring_radius = 6;
YEndstopHolder_distance = 66;

//utils
use <utils.scad>;
use <mm2logo.scad>;
use <rounded_square.scad>;
use <tslot.scad>;
include <Metamaquina2.scad>

//dimensions
tolerancia=0;

module calibracao(){
  import("calibracao.dxf");
}

module FrontRule_face(){
  difference(){
    union(){
      translate([0,0])
        square([283, 50], center=true);
      translate([0,25+25/2])
        rounded_square([283+30, 25], corners=[10,10,10,10], center=true);
    }
    union(){
      translate([-44,15+16])
        scale(0.5) calibracao();

    for (i=[-1,1]){

//barras transversais
    translate([i*Y_rods_distance/2,-11+tolerancia,0]) 
      rounded_square([m8_diameter,50], corners=[0,0,m8_diameter/2,m8_diameter/2], center=true);

//arruelas encostadas nas laterais
    translate([i*(SidePanels_distance-2*thickness-m8_washer_thickness)/2,m8_washer_D/2-50/2+tolerancia,0])
      square([m8_washer_thickness,50], center=true);

//porcas encostadas nas laterais
    translate([i*(SidePanels_distance-2*thickness-2*m8_washer_thickness-m8_nut_height)/2,m8_nut_R-50/2+1.1+tolerancia,0])
      square([m8_nut_height,50], center=true);

//arruelas encostadas nas laterais do rolamento
    translate([i*(bearing_thickness+2*mudguard_washer_thickness+2*washer_thickness+1.25)/2,m8_washer_D/2-50/2+tolerancia,0])
      square([1.25,50], center=true);

//porcas encostadas nas laterais do rolamento
    translate([i*(bearing_thickness+2*mudguard_washer_thickness+2*washer_thickness+2*1.25+m8_nut_height)/2,m8_nut_R-50/2+1.1+tolerancia,0])
      square([m8_nut_height,50], center=true);
    }

//rolamento
    translate([0,-8+tolerancia,0])
      square([bearing_thickness+2*mudguard_washer_thickness+2*washer_thickness,50], center=true);
    }
  }
}

module FrontRule_sheet(){
  material("lasercut")
    linear_extrude(height=thickness)
      FrontRule_face();
}

module FrontRule(){
  translate([0,5,0])
    translate([0, -RightPanel_basewidth/2 + bar_cut_length+thickness/2, base_bars_Zdistance + base_bars_height]) 
      rotate([90,0,0]) 
        FrontRule_sheet();
}

module RearRule_face(){
  difference(){
    union(){
      translate([0,0])
        square([283, 50], center=true);
      translate([0,25+25/2])
        square([283, 25], center=true);
    }
    union(){
rotate([180,0,0])
  rotate([180,180,0])
  translate([-44,15+16])
    scale(0.5) calibracao();

      for (i=[-1,1]){

//barras transversais
        translate([i*Y_rods_distance/2,-11+tolerancia,0]) 
          rounded_square([m8_diameter,50], corners=[0,0,m8_diameter/2,m8_diameter/2], center=true);

//arruelas encostadas nas laterais
        translate([i*(SidePanels_distance-2*thickness-m8_washer_thickness)/2,m8_washer_D/2-50/2+tolerancia,0])
          square([m8_washer_thickness,50], center=true);

//porcas encostadas nas laterais
        translate([i*(SidePanels_distance-2*thickness-2*m8_washer_thickness-m8_nut_height)/2,m8_nut_R-50/2+1.1+tolerancia,0])
          square([m8_nut_height,50], center=true);
      }

//porca da direita encostada no rolamento
        translate([(bearing_thickness+2*mudguard_washer_thickness+2*washer_thickness+m8_nut_height)/2,m8_nut_R-50/2+1.1+tolerancia,0])
          square([m8_nut_height,50], center=true);

//porca da esquerda encostada no rolamento
        translate([-(bearing_thickness+2*mudguard_washer_thickness+2*washer_thickness+thickness+2*thickness+2*m8_washer_thickness)/2,m8_nut_R-50/2+1.1+tolerancia,0])
         square([m8_nut_height,50], center=true);

//arruela encostada no rolamento
        translate([-(bearing_thickness+2*mudguard_washer_thickness+2*washer_thickness+2*thickness+m8_washer_thickness)/2,m8_washer_D/2-50/2+tolerancia,0])
          square([m8_washer_thickness,50], center=true);

//rolamento
        translate([0,-9+tolerancia,0])
          square([bearing_thickness+2*mudguard_washer_thickness+2*washer_thickness,50], center=true);

//madeira motor
        translate([-(bearing_thickness+2*mudguard_washer_thickness+2*washer_thickness+thickness)/2,-14.5+tolerancia,0])
          square([thickness,50], center=true);
    }
  }
}

module RearRule_sheet(){
  material("lasercut")
  linear_extrude(height=thickness)
  RearRule_face();
}

module RearRule(){
  translate([0,430,0])
  translate([0, -RightPanel_basewidth/2 + bar_cut_length+thickness/2, base_bars_Zdistance + base_bars_height]) 
  rotate([90,0,0]) 
  RearRule_sheet();
}


FrontRule();
RearRule();
