// (c) 2013 Felipe C. da S. Sanches <fsanches@metamaquina.com.br>
// Licensed under the terms of the GNU General Public License
// version 3 (or later).

include <Metamaquina2.h>;
use <rounded_square.scad>;

module heated_bed_pcb(width = 227, height = 224){
    color(pcb_color)
    linear_extrude(height=2)
    heated_bed_pcb_curves(width=width, height=height);
}

module heated_bed_pcb_curves(width = 227, height = 224, connector_holes=true){
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

module heated_bed_silk(width = 227, height = 224){
    line_thickness = 1;
    color("white"){
        translate([0,0,2.1])
        difference(){
            square([200,200], center=true);
            square([200-2*line_thickness,200-2*line_thickness], center=true);
        }
    }
}

module heated_bed(){
    heated_bed_pcb();
    heated_bed_silk();
}

heated_bed();
