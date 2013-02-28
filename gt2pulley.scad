//This is work in progress
// http://ultimachine.com/sites/default/files/imagecache/product_full/PulleyGT2.jpg
// GT2 pulley model
//
// (c) 2013 Felipe C. da S. Sanches <fsanches@metamaquina.com.br>
// Lincensed under the terms of the GNU General Public License
// version 3 (or later).


body_external_radius = 3; //TODO
body_internal_radius = 1; //TODO
gear_width = 8; //TODO
body_length = 10; //TODO
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

module grub_screw_hole(){
  cylinder(r=grub_screw_diameter/2, h=body_external_radius, $fn=40);
  translate([0,0,body_external_radius-bevel])
  cylinder(r1=grub_screw_diameter/2, r2=grub_screw_diameter/2+bevel, h=bevel, $fn=40);
}

module gt2body(){
  difference(){
    rotate_extrude($fn=100)
    body_outline();

    translate([0, 0, body_length - grub_position])
    rotate([90,0,0])
    grub_screw_hole();

    translate([0, 0, body_length - grub_position])
    rotate(90)
    rotate([90,0,0])
#    grub_screw_hole();

  }
}

module gt2teeth(){
}

module gt2borders(){

}

module gt2pulley(){
  gt2body();
  gt2teeth();
  gt2borders();
}

gt2pulley();
