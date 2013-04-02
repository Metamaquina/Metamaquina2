coupling_length = 30;
coupling_diameter = 25.4;
coupling_rod_depth = 17.6;
coupling_shaft_depth = coupling_length - coupling_rod_depth;
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
    cube([coupling_diameter, 2, coupling_length+2*epsilon]);
  }
}

mm2_coupling();

