// (c) 2013 Felipe C. da S. Sanches <fsanches@metamaquina.com.br>,
// Rafael H. de L. Moretti <moretti@metamaquina.com.br>
// Licensed under the terms of the GNU General Public License
// version 3 (or later).

coupling_length = 25;
coupling_diameter = 20.4;
coupling_rod_depth = 20;
coupling_shaft_depth = coupling_length - coupling_rod_depth;
bolt_diameter = 2.32;
bolt_size = 20;
bolt_offsetx = 7;
bolt1_offsetz = 3.1;
bolt2_offsetz = 3.4;
epsilon = 0.05;

metal_color = [0.8,0.8,0.8];
module mm2_coupling(shaft_diameter=5, rod_diameter=8){
  color(metal_color)
  difference(){
    cylinder(r=coupling_diameter/2, h=coupling_length, $fn=60);

    translate([0,0,-epsilon])
      cylinder(r=shaft_diameter/2, h=coupling_shaft_depth+2*epsilon, $fn=20);

    translate([0,0,coupling_length - coupling_rod_depth - epsilon])
      cylinder(r=rod_diameter/2, h=coupling_rod_depth+2*epsilon, $fn=20);

    translate([-coupling_diameter/2 + 2,-1, -epsilon])
      cube([coupling_diameter, 2, 10*coupling_length+2*epsilon]);

    // Bolt hole 1
    translate([bolt_offsetx,-bolt_size/2,bolt1_offsetz+bolt_diameter/2])
    rotate(a=[0,90,90])
      cylinder(r=bolt_diameter/2, h=bolt_size+2*epsilon, $fn=20);

    // Bolt hole 2
    translate([bolt_offsetx,-bolt_size/2,coupling_length-bolt2_offsetz-bolt_diameter/2])
    rotate(a=[0,90,90])
      cylinder(r=bolt_diameter/2, h=bolt_size+2*epsilon, $fn=20);

  }
}

mm2_coupling();

