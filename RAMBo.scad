// (c) 2013 Felipe C. da S. Sanches <fsanches@metamaquina.com.br>
// Licensed under the terms of the GNU General Public License
// version 3 (or later).

include <Metamaquina-config.scad>;
use <rounded_square.scad>;

hexspacer_length = 35; //considering the height of the connectors and components
nylonspacer_length = 6;
RAMBo_pcb_thickness = 2;
M3_bolt_head = 3;
RAMBo_cover_thickness = 3;
RAMBo_thickness = nylonspacer_length + RAMBo_pcb_thickness + hexspacer_length + RAMBo_cover_thickness + M3_bolt_head;
RAMBo_border = 3.7;
RAMBo_width = 103;
RAMBo_height = 104;

acrylic_color = [1, 0.5, 0.5, 0.7];//red-transparent
module RAMBo_cover_curves(border=0){
  difference(){
    translate([-border,-border])
    rounded_square([RAMBo_width+2*border, RAMBo_height+2*border], corners=[3,3,3,3]);
    RAMBo_holes();
  }
  //TODO: Add logo / labels ?
}

module RAMBo_cover(){
  color(acrylic_color)
  linear_extrude(height=RAMBo_cover_thickness)
  RAMBo_cover_curves();
}

module RAMBo(){
  for (x=[RAMBo_border, RAMBo_width-RAMBo_border]){
    for (y=[RAMBo_border, RAMBo_height-RAMBo_border]){
      translate([x,y]){
        nylonspacer();

        translate([0,0,nylonspacer_length+RAMBo_pcb_thickness]){
          hexspacer();
          translate([0,0,hexspacer_length+RAMBo_cover_thickness]){
            //bolt head
            color("grey")
            cylinder(r=3, h=M3_bolt_head, $fn=20);
          }
        }
      }
    }
  }

  translate([0,0,nylonspacer_length]){
    RAMBo_pcb();

    translate([0,0,RAMBo_pcb_thickness + hexspacer_length])
    RAMBo_cover();    
  }
}

module RAMBo_volume(){
//This is the space that is required for the RAMBo Electronics.
//We must make sure there's enough space so that the electronics doesn't
//take up part of the printer's max build volume.
  %cube([RAMBo_width, RAMBo_height, RAMBo_thickness]);
}

module RAMBo_holes(){
  translate([RAMBo_border, RAMBo_border])
  circle(r=m4_diameter/2, $fn=20);

  translate([RAMBo_border, RAMBo_height-RAMBo_border])
  circle(r=m4_diameter/2, $fn=20);

  translate([RAMBo_width-RAMBo_border, RAMBo_border])
  circle(r=m4_diameter/2, $fn=20);

  translate([RAMBo_width-RAMBo_border, RAMBo_height-RAMBo_border])
  circle(r=m4_diameter/2, $fn=20);
}

dark_green = [0,0.2,0];
module RAMBo_pcb(){
  color(dark_green)
  linear_extrude(height=RAMBo_pcb_thickness)
  difference(){
    square([RAMBo_width, RAMBo_height]);
    RAMBo_holes();
  }
}

white_nylon_color = [1, 1, 0.8];
module nylonspacer(D=8, d=m4_diameter, h=nylonspacer_length){
  color(white_nylon_color)
  linear_extrude(height=h)
  difference(){
    circle(r=D/2, $fn=20);
    circle(r=d/2, $fn=20);
  }
}

module hexspacer(D=8, d=m3_diameter, h=hexspacer_length){
  color(metal_color)
  linear_extrude(height=h)
  difference(){
    circle(r=D/2, $fn=6);
    circle(r=d/2, $fn=20);
  }
}

