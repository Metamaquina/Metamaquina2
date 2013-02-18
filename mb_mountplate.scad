//Makerbot-compatible mountplate
//
// (c) 2013 Felipe C. da S. Sanches <fsanches@metamaquina.com.br>
// Licensed under GNU GPL v3 (or later)

use <rounded_square.scad>;

module single_cut(H=9,R=3.25,r=1){
  difference(){
    union(){
      square([4*R,2*(H-R)], center=true);

      translate([0,H-R])
      circle(r=R, $fn=40);
    }

    translate([R,0])
    rounded_square([2*R,H], corners=[r,r,r,r], $fn=20);
    translate([-3*R,0])
    rounded_square([2*R,H], corners=[r,r,r,r], $fn=20);
  }
  
}

module double_cut(){
  single_cut();

  translate([-12,0])
  single_cut();
}

module mb_mountplate_mount_holes(){
  translate([52,0]){
    for(i=[-1,0,1]){
      rotate([0,0,90*i])
      translate([12,0])
      circle(r=3/2, $fn=20);
    }

    circle(r=5/2, $fn=30);
  }
}

module makerbot_mount_plate(){
  mount_plate_length = 138;
  mount_plate_width = 34;

  cut_positions = [0, -16.5, 12 + 16.5];

  difference(){
    translate([-mount_plate_length/2, -mount_plate_width/2])
    rounded_square([mount_plate_length, mount_plate_width], corners=[2.5,2.5,2.5,2.5], $fn=30);


    for (x = cut_positions){
      translate([x,-mount_plate_width/2])
      double_cut();
    }

    mb_mountplate_mount_holes();

    mirror([-1,0])
    mb_mountplate_mount_holes();

  }
}

makerbot_mount_plate();

