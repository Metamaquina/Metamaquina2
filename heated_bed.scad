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
include <heated_bed.h>;
include <render.h>;
use <rounded_square.scad>;

module heated_bed_pcb(width = heated_bed_pcb_width, height = heated_bed_pcb_height){
  BillOfMaterials("Metamaquina heated bed v14, assembled", ref="HB_MM2_14");

  material("pcb")
  linear_extrude(height=heated_bed_pcb_thickness)
heated_bed_pcb_curves(width=width, height=height);
}

module heated_bed_pcb_curves(width = heated_bed_pcb_width, height = heated_bed_pcb_height, connector_holes=true){
    r = 4;
    border = 5;

    connector_area = [26.5, 8.5];

    translate([-connector_area[0]/2, height/2])
    difference(){
        rounded_square(connector_area, corners=[0,0,4,4]);

        if (connector_holes){
            for (i=[-1.5,-0.5,0.5,1.5]){
                translate([connector_area[0]/2 + i*5,5])
                circle(r=1, $fn=30);
            }
        }
    }

    difference(){
        rounded_square([width, height], corners=[r,r,r,r], $fn=50, center=true);

        for (j=[-1,1]){
            for (i=[-1,1]){
                translate([i*(width/2 - border), j*(height/2 - border)])
                circle(r=3/2, $fn=50);
            }
        }
    }
}

module heated_bed_silk(width = heated_bed_pcb_width, height = heated_bed_pcb_height){
  line_thickness = 1;
  material("silk"){
    translate([0,0,heated_bed_pcb_thickness+0.1])
    difference(){
      square([200,200], center=true);
      square([200-2*line_thickness,200-2*line_thickness], center=true);
    }
  }
}

module heated_bed_glass(){
  BillOfMaterials(str(heated_bed_glass_thickness, "mm glass for the build platform (",glass_w,"mm x ",glass_h,"mm)"), ref=str("MM2_SIV_",glass_w,"x",glass_h));

  material("glass")
  translate([-glass_w/2, -glass_h/2, heated_bed_pcb_thickness])
  cube([glass_w, glass_h, heated_bed_glass_thickness]);
}

module heated_bed(){
  { //TODO: Add these parts to the CAD model
    BillOfMaterials("Compression Spring CM351 (D=4.5mm, lenght=15.3mm)", 4, ref="CM351");
    BillOfMaterials("M3x30 bolt", 4, ref="H_M3x30");
    BillOfMaterials("M3 washer", 4*3, ref="AL_M3");
    BillOfMaterials("Borboleta M3", 4, ref="P_M3_bo");
  }

  heated_bed_pcb();
  heated_bed_silk();
  heated_bed_glass();
}

heated_bed();
