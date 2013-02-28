//This is work in progress
// http://ultimachine.com/sites/default/files/imagecache/product_full/PulleyGT2.jpg
// http://dieselint.com/images-ebay/gt2-20t-aluminum-pulley-drawing.png
//
// GT2 pulley model
//
// (c) 2013 Felipe C. da S. Sanches <fsanches@metamaquina.com.br>
// Lincensed under the terms of the GNU General Public License
// version 3 (or later).

$fn=50;
bevel = 0.4; //TODO
body_external_radius = 9.7/2;
body_internal_radius = 5/2;
body_length = 14;//TODO
grub_screw_diameter = 1;
grub_screw_length = 4;
grub_position = 2;
num_teeth = 20;
gear_pitch = 2;
disc_radius = 17/2;
disc_thickness = 0.5; //TODO
gear_width = 7.4;

module beveled_tube(H, r, R, int_bev, ext_bev, int_bev2, ext_bev2){
  rotate_extrude($fn=100){
    hull(){
      // bottom
      translate([r + int_bev, 0])
      square([R-r-int_bev-ext_bev, int_bev]);

      translate([r, int_bev])
      square([int_bev, H/2-int_bev]);

      translate([R - ext_bev, ext_bev])
      square([ext_bev, H/2-ext_bev]);

      // top
      translate([0, H/2]){

        translate([r + int_bev2, 0])
        square([R-r-int_bev2-ext_bev2, H/2]);

        translate([r, 0])
        square([int_bev2, H/2-int_bev2]);

        translate([R - ext_bev2, 0])
        square([ext_bev2, H/2-ext_bev2]);
      }
    }
  }
}

module grub_screw_hole(){
  cylinder(r=grub_screw_diameter/2, h=body_external_radius, $fn=40);
  translate([0,0,body_external_radius-bevel])
  cylinder(r1=grub_screw_diameter/2, r2=grub_screw_diameter/2+bevel, h=bevel, $fn=40);
}

module gt2body(){
  internal_bevel = bevel;
  external_bevel = bevel;
  r = body_internal_radius;
  R = body_external_radius;
  H = body_length;

  render()
  difference(){
    beveled_tube(H, r, R, internal_bevel, external_bevel, internal_bevel, external_bevel);

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

  internal_bevel = bevel;
  external_bevel = 2*bevel;
  r = body_internal_radius;
  R = radius;
  H = gear_width + 2*(disc_thickness+external_bevel);

  difference(){
    beveled_tube(H, r, R, internal_bevel, external_bevel, internal_bevel, external_bevel);

    translate([0, 0, disc_thickness+external_bevel])
    linear_extrude(height=gear_width)
    for (i=[1:num_teeth]){
      rotate(i*360/num_teeth)
      translate([radius,0])
      circle(r=1/2, $fn=20);
    }
  }

  translate([0, 0, external_bevel])
  disc();

  translate([0,0, external_bevel + disc_thickness + gear_width])
  disc();
}

module disc(){
  linear_extrude(height=disc_thickness)
  difference(){
    circle(r=disc_radius);
    circle(r=body_internal_radius);
  }
}

module gt2pulley(){
  gt2body();
  gt2teeth();
}

gt2pulley();
