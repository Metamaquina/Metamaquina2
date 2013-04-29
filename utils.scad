// (c) 2013 Felipe C. da S. Sanches <fsanches@metamaquina.com.br>
// Licensed under the terms of the GNU General Public License
// version 3 (or later).

use <rounded_square.scad>;

//TODO: move these declarations to a header file
m25_diameter = 2.5;
m3_diameter=3;

module M3_hole(){
  circle(r=m3_diameter/2, $fn=20);
}

module M25_hole(){
  circle(r=m25_diameter/2, $fn=20);
}

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
