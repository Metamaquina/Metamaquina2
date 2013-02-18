// Reimplementation of Josef Průša's belt clamp
// Adapted for eighter laser cutting or 3d printing.
//
// (c) 2013 Felipe C. da S. Sanches <fsanches@metamaquina.com.br>
// Lincensed under the terms of the GNU General Public License
// version 3 (or later).

//2d shape (good for the lasercutter)
module beltclamp_curves(width, r){
  m4_diameter = 4;
  d = width/2-r;

  difference(){
    hull(){
      for (x=[-d,d]){
        translate([x, 0])
        circle(r=5, $fn=20);
      }
    }

    //These are holes for M3 bolts, but we want
    // some clearance so they'll have 4mm diameter.
    for (x=[-d,d]){
      translate([x, 0])
      circle(r=m4_diameter/2, $fn=20);
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

module beltclamp(width=28, height=7, r=5, teeth_depth=0.5){
  difference(){
    linear_extrude(height=height)
    beltclamp_curves(width, r);

    translate([0, 0, height-teeth_depth]){
      linear_extrude(height = teeth_depth+1)
      teeth_for_belt();
    }
  }
}

beltclamp();
