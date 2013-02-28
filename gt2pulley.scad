//This is work in progress
// http://ultimachine.com/sites/default/files/imagecache/product_full/PulleyGT2.jpg
// GT2 pulley model
//
// (c) 2013 Felipe C. da S. Sanches <fsanches@metamaquina.com.br>
// Lincensed under the terms of the GNU General Public License
// version 3 (or later).


body_external_radius = 5; //TODO
body_internal_radius = 2; //TODO
gear_width = 6; //TODO
body_length = 12; //TODO
bevel = 0.4; //TODO
$fn=50;

module body_outline(){
  hull(){
    translate([body_internal_radius+bevel, 0])
    square([body_external_radius-body_internal_radius-2*bevel, body_length]);

    translate([body_internal_radius, 0])
    square([body_external_radius-body_internal_radius, body_length-bevel]);
  }
}

grub_screw_diameter = 1;
grub_screw_length = 4;
grub_position = 2;
num_teeth = 20;
gear_pitch = 2;

module grub_screw_hole(){
  cylinder(r=grub_screw_diameter/2, h=body_external_radius, $fn=40);
  translate([0,0,body_external_radius-bevel])
  cylinder(r1=grub_screw_diameter/2, r2=grub_screw_diameter/2+bevel, h=bevel, $fn=40);
}

module gt2body(){
  render()
  difference(){
    rotate_extrude($fn=100)
    body_outline();

    translate([0, 0, body_length - grub_position])
    rotate([90,0,0])
    grub_screw_hole();

    translate([0, 0, body_length - grub_position])
    rotate(90)
    rotate([90,0,0])
    grub_screw_hole();

  }
}

module gt2teeth(){
  radius = gear_pitch * num_teeth/(2*3.1415);

  linear_extrude(height=gear_width)
  difference(){
    circle(r=radius, $fn=40);
    for (i=[1:num_teeth]){
      rotate(i*360/num_teeth)
      translate([radius,0])
      circle(r=1/2, $fn=20);
    }
    circle(r=body_internal_radius);
  }
}

disc_radius = 9; //TODO
disc_thickness = 0.5; //TODO

module disc(){
  linear_extrude(height=disc_thickness)
  difference(){
    circle(r=disc_radius);
    circle(r=body_internal_radius);
  }
}

module gt2borders(){
  disc();

  translate([0,0,gear_width-disc_thickness])
  disc();
}

module gt2pulley(){
  gt2body();
  gt2teeth();
  gt2borders();
}

gt2pulley();
