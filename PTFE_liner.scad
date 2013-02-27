// PTFE liner for 3d printer hotend (JHead)
// 2d/3d model
//
// (c) 2013 Felipe C. da S. Sanches <fsanches@metamaquina.com.br>
// Lincensed under the terms of the GNU General Public License
// version 3 (or later).

use <technical_drawing.scad>;

module PTFE_liner_2d_outline(dimensions=true){
  epsilon = 0.01;

  d1 = 6.33;
  l1 = 46.5;

  d2 = 3.25;
  l2 = 47;

  d3 = d2;
  l3 = 47.5;

  d4 = 3.0;
  l4 = l3 + 1;

  d5a = 4.5;
  d5b = 3.0;
  l5 = 2;

  if (dimensions){
    dimension(0, 8, l3, 8, line_thickness=0.05, fontsize=1);
    dimension(0, 10, l2, 10, line_thickness=0.05, fontsize=1);
    dimension(0, 12, l1, 12, line_thickness=0.05, fontsize=1);

    rotate(180)
    dimension(-l5, 8, 0, 8, line_thickness=0.05, fontsize=1);

    translate([4,0])
    rotate(90){
      dimension(-d5a/2, 11, d5a/2, 11, line_thickness=0.05, fontsize=1);
      dimension(-d5b/2, 9, d5b/2, 9, line_thickness=0.05, fontsize=1);
    }

    translate([l1,0])
    rotate(-90)
    dimension(-d1/2, 8, d1/2, 8, line_thickness=0.05, fontsize=1);
  }

  difference(){
    //exterior outline
    union(){
      hull(){
        translate([0,-d1/2])
        square([l1,d1]);

        translate([0,-d2/2])
        square([l2,d2]);
      }

      translate([0,-d3/2])
      square([l3,d3]);
    }

    //interior outline
    translate([0,-d4/2])
    square([l4,d4]);

    //entrance interior bevel    
    hull(){
      translate([l5-epsilon,-d5b/2])
      square([epsilon,d5b]);

      translate([-epsilon,-d5a/2])
      square([epsilon,d5a]);
    }
  }
}

module PTFE_liner(){
  color("red")
  rotate_extrude($fn=50)
  rotate(90)
  PTFE_liner_2d_outline();
}

PTFE_liner_2d_outline();
//PTFE_liner();

