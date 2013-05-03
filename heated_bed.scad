// (c) 2013 Felipe C. da S. Sanches <fsanches@metamaquina.com.br>
// Licensed under the terms of the GNU General Public License
// version 3 (or later).

include <Metamaquina2.h>;
include <heated_bed.h>;
include <colors.h>;
use <rounded_square.scad>;

module heated_bed_pcb(width = heated_bed_pcb_width, height = heated_bed_pcb_height){
    color(pcb_color)
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
    color("white"){
        translate([0,0,heated_bed_pcb_thickness+0.1])
        difference(){
            square([200,200], center=true);
            square([200-2*line_thickness,200-2*line_thickness], center=true);
        }
    }
}

module heated_bed_glass(){
  if(render_glass)
  color(glass_color)
  translate([-glass_w/2, -glass_h/2, heated_bed_pcb_thickness])
  cube([glass_w, glass_h, heated_bed_glass_thickness]);
}

module heated_bed(){
  heated_bed_pcb();
  heated_bed_silk();
  heated_bed_glass();
}

heated_bed();
