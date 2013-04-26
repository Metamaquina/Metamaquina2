// (c) 2013 Felipe C. da S. Sanches <fsanches@metamaquina.com.br>
// Licensed under the terms of the GNU General Public License
// version 3 (or later).

use <rounded_square.scad>;

module rounded_edge_cut(width=10, height=20, r=5){
    translate([-width/2,-height])
    rounded_square([width,height], corners=[r,r,0,0]);

    translate([-width/2-r,-r]){
        difference(){
            square([r,r]);
            circle(r=r);
        }
    }

    translate([width/2,-r]){
        difference(){
            square([r,r]);
            translate([r,0])
            circle(r=r);
        }
    }

}

rounded_edge_cut();
