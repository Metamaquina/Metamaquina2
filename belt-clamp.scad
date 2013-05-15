// Reimplementation of Josef Průša's belt clamp
// Adapted for eighter laser cutting or 3d printing.
//
// (c) 2013 Felipe C. da S. Sanches <fsanches@metamaquina.com.br>
// Licensed under the terms of the GNU General Public License
// version 3 (or later).

include <BillOfMaterials.h>;
include <render.h>;
include <colors.h>;

module belt_clamp_holder(){
  r = 5;
  s = 28 - 2*r;
  hull(){
    for (p=[[s,0], [s,s], [0,0]]){
      translate(p)
      circle(r=r, $fn=20);
    }
  }
}

//2d shape (good for the lasercutter)
module beltclamp_curves(width, r, for_x_carriage=false, for_y_platform=false){
  d = width/2-r;

  difference(){
    hull(){
      for (x=[-d,d]){
        translate([x, 0])
        circle(r=5, $fn=20);
      }

      if(for_x_carriage){
        for (x=[-d,0.7*d]){
          translate([x, 4])
          circle(r=5, $fn=20);
        }
      }

      if (for_y_platform){
        for (x=[-d,d]){
          translate([x, 0])
          circle(r=8, $fn=20);
        }
      }

    }

    //These are holes for M3 bolts, but we want
    // some clearance so they'll have 3.3mm diameter.
    for (x=[-d,d]){
      translate([x, 0])
      circle(r=3.3/2, $fn=20);
    }
  }
}

// This seems to be designed for T5.
//TODO: Adapt this for 2mm GT2? (add a belt_pitch parameter?)
module teeth_for_belt(belt_width=6){
  for (y=[-2:2])
    translate([0,y*2.5])
    square([belt_width+2, 1.8], center = true);
}

module beltclamp(width=28, height=6, r=5, teeth_depth=0.5){
  BillOfMaterials(category="3D Printed", partname="Belt Clamp");

  if (render_ABS){
    color(ABS_color){
      render()
      difference(){
        linear_extrude(height=height)
        beltclamp_curves(width, r);

        translate([0, 0, height-teeth_depth]){
          linear_extrude(height = teeth_depth+1)
          teeth_for_belt();
        }
      }
    }
  }
}

module x_carriage_beltclamp(width=28, height=6, r=5){
  BillOfMaterials(category="Lasercut wood", partname="X Carriage Belt Clamp");

  if (render_lasercut){
    color(sheet_color){
      linear_extrude(height=height)
      beltclamp_curves(width, r, for_x_carriage=true);
    }
  }
}

module y_platform_beltclamp(width=28, height=6, r=5){
  BillOfMaterials(category="Lasercut wood", partname="Y Platform Belt Clamp");

  if (render_lasercut){
    color(sheet_color){
      linear_extrude(height=height)
      beltclamp_curves(width, r, for_y_platform=true);
    }
  }
}

beltclamp(); //for 3d printing

translate ([0,20])
x_carriage_beltclamp(); //lasercut model

translate ([0,40])
y_platform_beltclamp(); //lasercut model
