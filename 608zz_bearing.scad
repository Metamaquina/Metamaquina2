// 608zz bearing
//
// (c) 2013 Felipe C. da S. Sanches <fsanches@metamaquina.com.br>
// Licensed under the terms of the GNU General Public License
// version 3 (or later).

include <BillOfMaterials.h>;

module 608zz_bearing(details=false){
  BillOfMaterials("608zz bearing");

  if(details){
    608zz_bearing_detailed();
  } else {
    608zz_bearing_simple();
  }
}

module 608zz_bearing_simple(){
  color("silver"){
    linear_extrude(height=7)
    difference(){
      circle(r=22/2, $fn=40);
      circle(r=8/2, $fn=40);
    }
  }
}

module 608zz_bearing_detailed(){
  color("silver"){
    //inner disc
    linear_extrude(height=7)
    difference(){
      circle(r=11/2, $fn=40);
      circle(r=8/2, $fn=40);
    }

    //middle disc
    translate([0,0,0.5])
    linear_extrude(height=6)
    difference(){
      circle(r=18/2, $fn=40);
      circle(r=12/2, $fn=40);
    }

    //outer disc
    linear_extrude(height=7)
    difference(){
      circle(r=22/2, $fn=40);
      circle(r=19/2, $fn=40);
    }
  }
}
